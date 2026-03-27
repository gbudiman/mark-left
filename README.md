# mdx-tex

A Ruby gem that converts Markdown (MDX) syntax to Textile. Pure Ruby with no runtime dependencies.

> **Note:** Currently only MDX -> Textile conversion is supported.

## Installation

Add to your Gemfile:

```ruby
gem 'mdx-tex'
```

Then run:

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

# Basic conversion
MdxTex.to_textile(markdown: '# Hello **world**')
# => "h3. Hello *world*"

# Per-call options
MdxTex.to_textile(markdown: '# Hello', header_level: 'h1')
# => "h1. Hello"

# Global configuration
MdxTex.configure do |config|
  config.header_level = 'h2'
  config.list_depth = 1
end

# Per-call options override global config
MdxTex.to_textile(markdown: '- item', list_depth: 2)
```

## Supported Syntaxes

### Headers

Markdown headings (`#` through `######`) are converted to Textile headings. The `header_level` option controls the base Textile heading level (default: `h3`).

| Markdown | header_level | Textile |
|----------|--------------|---------|
| `# Title` | `h1` | `h1. Title` |
| `## Title` | `h2` | `h2. Title` |
| `### Title` | `h3` | `h3. Title` |
| `#### Title` | `h4` | `h4. Title` |
| `##### Title` | `h5` | `h5. Title` |
| `###### Title` | `h6` | `h6. Title` |

A space after `#` is required. `#NoSpace` will not be converted.

### Bold

Both `**text**` and `__text__` are converted to Textile bold (`*text*`).

| Markdown | Textile |
|----------|---------|
| `**hello**` | `*hello*` |
| `__hello__` | `*hello*` |
| `**a** and **b**` | `*a* and *b*` |
| `**a** and __b__` | `*a* and *b*` |

Multiple bold spans and mixed delimiters on the same line are supported.

### Unordered Lists

Markdown unordered lists (`- item`) are converted to Textile unordered lists. Nesting is determined by indentation (2 spaces per level), offset by the `list_depth` option (default: `3`).

| Markdown | list_depth | Textile |
|----------|------------|---------|
| `- Item` | 1 | `* Item` |
| `- Item` | 3 | `*** Item` |
| `  - Nested` | 3 | `**** Nested` |
| `    - Deep` | 3 | `***** Deep` |

### Ordered Lists

Markdown ordered lists (`1. item`) are converted to Textile ordered lists. Nesting is determined by indentation (2 spaces per level). The number prefix is discarded.

| Markdown | Textile |
|----------|---------|
| `1. First` | `# First` |
| `99. Any number` | `# Any number` |
| `  1. Nested` | `## Nested` |
| `    1. Deep` | `### Deep` |

## Configuration

| Option | Type | Valid Values | Default | Description |
|--------|------|-------------|---------|-------------|
| `header_level` | String | `h1`..`h6` | `h3` | Textile heading tag for Markdown headings |
| `list_depth` | Integer | Positive integer | `3` | Base asterisk count for unordered list items |

Invalid values raise `InvalidHeaderLevelError` or `InvalidListDepthError`.

## Full Example

**Input:**
```markdown
# **Title**

- item one
- **item two**
  - nested with **bold**

1. **first**
1. second
```

**Output** (default config):
```textile
h3. *Title*

*** item one
*** *item two*
**** nested with *bold*

# *first*
# second
```

## Development

### Setup

```bash
git clone https://github.com/gbudiman/mdx-tex.git
cd mdx-tex
bundle install
```

### Git Hooks (Overcommit)

This project uses [overcommit](https://github.com/sds/overcommit) to run RuboCop as a pre-commit hook. Install the hooks after cloning:

```bash
bundle exec overcommit --install
bundle exec overcommit --sign
```

This ensures RuboCop runs automatically on every commit.

### Running Tests

```bash
bundle exec rspec
# or
bundle exec rake
```

### Linting

```bash
bundle exec rubocop
```

## Releasing

The `bin/release` script handles version bumping, tagging, and pushing. GitHub Actions publishes the gem to RubyGems.

```bash
bin/release patch   # 0.1.10 → 0.1.11
bin/release minor   # 0.1.10 → 0.2.0
bin/release major   # 0.1.10 → 1.0.0
```

The script will:
1. Run the test suite
2. Bump the version in `lib/mdx_tex/version.rb`
3. Commit and tag the release
4. Push to GitHub (triggers gem publish via GitHub Actions)

## License

MIT
