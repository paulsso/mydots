# Find and replace cheatsheet

### Find and replace on an interval
`:3,10s/foo/bar/g`

### Find and replace entire file
`%s/foo/bar/g`

### Case sensitivity flag
`%s/foo/BAR/gi`

### Confirm substitution
`%s/foo/bar/gc`

### Replace /
`s|foo|bar|g`
or
`s~foo~bar~g`
or
`s.foo.bar.g`

### Whole word
`s~\<foo\>~bar~g`

### Comment lines
`5,20s/^/#/`

### Uncomment lines
`5,20s/^#//`

### Replace all instances of ‘apple’, ‘orange’, and ‘mango’ with ‘fruit’:
`:%s/apple\|orange\|mango/fruit/g`

### Remove trailing whitespace
`:%s/\s\+$//e`
