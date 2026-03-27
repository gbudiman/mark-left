# mdx-tex

Converts Markdown (MDX) to Textile, for those of you unfortunate enough to have to maintain a legacy system that relies on Textile.

Pure Ruby, no runtime dependencies.

> **Note:** Currently only supports MDX -> Textile conversion. Textile -> MDX conversion is on the roadmap.

## Installation

Add to your Gemfile:

```ruby
gem 'mdx-tex'
```

```bash
bundle install
```

Or install directly:

```bash
gem install mdx-tex
```

## Usage

```ruby
require 'mdx_tex'

MdxTex.to_textile(markdown: '# Hello **world**')
# => "h3. Hello *world*"

# Override options per call
MdxTex.to_textile(markdown: '# Hello', header_level: 'h1')
# => "h1. Hello"

# Or set them globally
MdxTex.configure do |config|
  config.header_level = 'h2'
  config.list_depth = 1
end

# Per-call options take precedence over global config
MdxTex.to_textile(markdown: '- item', list_depth: 2)
```

### String Extension

Adds `to_textile` directly to `String`. Off by default.

**Any Ruby app:**

```ruby
require 'mdx_tex/core_ext/string'

'# Hello **world**'.to_textile
# => "h3. Hello *world*"

'- item'.to_textile(list_depth: 1)
# => "* item"
```

Or load it through config:

```ruby
MdxTex.configure do |config|
  config.enable_string_extension = true
end
MdxTex.load_string_extension!
```

**Rails** (`config/initializers/mdx_tex.rb`):

```ruby
MdxTex.configure do |config|
  config.enable_string_extension = true
end
```

The Railtie loads this automatically after initialization.

## Supported Syntaxes

### Headers

Converts all Markdown headings (`#` through `######`) to the same Textile heading tag. The number of `#` doesn't matter. `header_level` controls which tag to use (default: `h3`).

| Markdown | header_level | Textile |
|----------|--------------|---------|
| `# Title` | `h3` (default) | `h3. Title` |
| `## Title` | `h3` (default) | `h3. Title` |
| `###### Title` | `h3` (default) | `h3. Title` |
| `# Title` | `h1` | `h1. Title` |
| `### Title` | `h1` | `h1. Title` |

Requires a space after `#`. `#NoSpace` won't convert.

This does not preserve heading hierarchy yet (`##` and `###` both produce the same tag). We plan to fix this in a future version.

### Bold

`**text**` and `__text__` become `*text*`. Multiple spans and mixed delimiters work on the same line.

| Markdown | Textile |
|----------|---------|
| `**hello**` | `*hello*` |
| `__hello__` | `*hello*` |
| `**a** and **b**` | `*a* and *b*` |
| `**a** and __b__` | `*a* and *b*` |

### Unordered Lists

`- item` becomes Textile `* item`. Nesting uses 2-space indentation. `list_depth` controls the base asterisk count (default: `3`).

| Markdown | list_depth | Textile |
|----------|------------|---------|
| `- Item` | 1 | `* Item` |
| `- Item` | 3 | `*** Item` |
| `  - Nested` | 3 | `**** Nested` |
| `    - Deep` | 3 | `***** Deep` |

### Ordered Lists

`1. item` becomes `# item`. Ignores the actual number. Nesting uses 2-space indentation.

| Markdown | Textile |
|----------|---------|
| `1. First` | `# First` |
| `99. Any number` | `# Any number` |
| `  1. Nested` | `## Nested` |
| `    1. Deep` | `### Deep` |

### Not Supported

The following Markdown syntax passes through as-is (no conversion):

- Italic (`*text*`, `_text_`)
- Strikethrough (`~~text~~`)
- Links (`[text](url)`)
- Images (`![alt](url)`)
- Inline code (`` `code` ``)
- Code blocks (`` ``` ``)
- Blockquotes (`>`)
- Tables
- Horizontal rules (`---`)
- Task lists (`- [ ]`, `- [x]`)

## Configuration

| Option | Type | Valid Values | Default | Description |
|--------|------|-------------|---------|-------------|
| `header_level` | String | `h1`..`h6` | `h3` | Textile heading tag |
| `list_depth` | Integer | Positive integer | `3` | Base asterisk count for unordered lists |

Bad values raise `InvalidHeaderLevelError` or `InvalidListDepthError`.

## Full Example

Input:
```markdown
# **Title**

- item one
- **item two**
  - nested with **bold**

1. **first**
1. second
```

Output (default config):
```textile
h3. *Title*

*** item one
*** *item two*
**** nested with *bold*

# *first*
# second
```

## Development

```bash
git clone https://github.com/gbudiman/mdx-tex.git
cd mdx-tex
bundle install
```

### Git Hooks

Uses [overcommit](https://github.com/sds/overcommit) for pre-commit RuboCop. After cloning:

```bash
bundle exec overcommit --install
bundle exec overcommit --sign
```

### Tests

```bash
bundle exec rspec
```

### Lint

```bash
bundle exec rubocop
```

## Releasing

```bash
bin/release patch   # 0.1.10 → 0.1.11
bin/release minor   # 0.1.10 → 0.2.0
bin/release major   # 0.1.10 → 1.0.0
```

Runs specs, bumps the version, commits, tags, and pushes. GitHub Actions handles the RubyGems publish.

## License

MIT
