#!/usr/bin/env bash
set -Eeuo pipefail

need_root() { [ "${EUID:-$(id -u)}" -eq 0 ] || { echo "Run as root"; exit 1; }; }
is_debian() { [ -f /etc/debian_version ]; }

need_root
is_debian || { echo "This script targets Debian."; exit 1; }

export DEBIAN_FRONTEND=noninteractive

# --- Updates & unattended upgrades ---
apt-get update -y
apt-get install -y unattended-upgrades apt-listchanges fail2ban ufw apparmor-profiles apparmor-utils auditd
dpkg-reconfigure -f noninteractive unattended-upgrades || true
install -m 0644 -o root -g root hardening/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
install -m 0644 -o root -g root hardening/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades
systemctl enable --now unattended-upgrades

# --- Journald & auditd ---
install -m 0644 -o root -g root hardening/journald.conf /etc/systemd/journald.conf
systemctl restart systemd-journald
systemctl enable --now auditd

# --- UFW baseline ---
ufw default deny incoming
ufw default allow outgoing
# open SSH (adjust port if you change it)
ufw allow OpenSSH
yes | ufw enable

# --- SSH hardening (server side) ---
mkdir -p /etc/ssh/sshd_config.d
install -m 0644 -o root -g root hardening/sshd_hardening.conf /etc/ssh/sshd_config.d/99-hardening.conf
sshd -t && systemctl reload ssh || systemctl restart ssh

# --- Fail2ban baseline ---
install -m 0644 -o root -g root hardening/jail.local /etc/fail2ban/jail.local
systemctl enable --now fail2ban

# --- Kernel/sysctl hardening ---
install -m 0644 -o root -g root hardening/90-security.conf /etc/sysctl.d/90-security.conf
sysctl --system

# --- Core dumps off ---
install -m 0644 -o root -g root hardening/limits.conf /etc/security/limits.d/99-nocoredump.conf
sysctl -w fs.suid_dumpable=0

# --- AppArmor (ensure enforcing) ---
grubby_cmd=$(command -v grubby || true)
if grep -q 'apparmor=1' /proc/cmdline; then
  echo "AppArmor already enabled"
else
  # For GRUB:
  sed -i 's/^\(GRUB_CMDLINE_LINUX=.*\)"/\1 apparmor=1 security=apparmor"/' /etc/default/grub
  update-grub || true
fi
systemctl enable --now apparmor || true

# --- Shell defaults (umask/hist) ---
install -m 0644 -o root -g root hardening/umask.conf /etc/profile.d/99-umask.sh

# --- Optional: disable rarely used network services if present ---
systemctl disable --now avahi-daemon 2>/dev/null || true
systemctl disable --now cups 2>/dev/null || true
systemctl disable --now rpcbind 2>/dev/null || true

echo "✅ Hardening baseline applied. Consider rebooting to pick up all kernel/GRUB settings."
