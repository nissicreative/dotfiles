# Laravel & PHP Guidelines

## Framework Preferences

- **Follow Laravel conventions first.** If Laravel has a documented way to do something, use it. Only deviate when you have a clear justification.
- Use **Laravel Boost** when available and applicable.
- **Prefer PHP attributes over equivalent class properties and methods** where Laravel supports them (e.g. `#[Fillable]`, `#[Cast]`, `#[Scope]`, `#[Rule]`, `#[On]`, `#[Computed]`). This applies framework-wide — models, jobs, commands, controllers, and Livewire components.

## Code Style

- Follow PSR-1, PSR-2, and PSR-12 coding standards.
- Prefer short closures and arrow functions (`fn() =>`) where appropriate.
- Use short nullable notation: `?string` instead of `string|null`.
- Avoid inline comments or docblocks unless required for clarity.

## Class Structure

- Use typed properties, not docblocks
- Constructor property promotion when all properties can be promoted
- One trait per line

### Eloquent Model Organization

Traits and constants appear at the top of the class without a section header. All remaining sections use the Laravel-style divider:

```php
/*
|--------------------------------------------------------------------------
| Section Name
|--------------------------------------------------------------------------
*/
```

**Section order:**

1. Traits (`use` statements, one per line) - no section header
2. Constants - no section header
3. Properties — `$fillable`, `$guarded`, `$hidden`, `$appends` - no section header
4. Casts — prefer `protected function casts(): array` method over the `$casts` array - no section header
5. Boot / lifecycle hooks (`boot()`, `booted()`)
6. Relationships
7. Query Scopes — prefer the `#[Scope]` attribute (Laravel 12+) over `scopeFoo()` naming
8. Accessors & Mutators — prefer `Attribute::make()` which colocates getter and setter
9. Public Methods
10. Protected / Private Methods
11. Static Methods

**Notes:**

- Omit sections that have no members — don't leave empty section blocks
- Prefer `#[Scope]` PHP attributes as the codebase moves toward modern Laravel conventions
- For accessors/mutators, prefer `Attribute::make()` when the project supports it (Laravel 9+):
- Omit section headers for traits and constants — they are standard PHP class anatomy and don't need one

```php
    protected function fullName(): Attribute
    {
        return Attribute::make(
            get: fn () => "{$this->first_name} {$this->last_name}",
            set: fn (string $value) => explode(' ', $value, 2),
        );
    }
```

**When to extract logic out of a model:**

- **Actions** — prefer extracting into an Action class when behavior is reused across multiple contexts (Jobs, Artisan commands, Tinkerwell, etc.) or when the logic is complex enough to warrant isolation. Keeps models lean and makes routines independently testable.
- **Scopes** — keep query logic as scopes on the model until complexity warrants more. A dedicated Query Builder class is acceptable when scopes become unwieldy.
- **Service classes** — appropriate when grouping related behavior that doesn't belong to a single model or action. Use when it genuinely simplifies things, not as a default abstraction layer.
- **General principle** — avoid god objects. If a model is accumulating unrelated responsibilities, that's a signal to extract.

### Livewire Component Organization

Applies to class-based and multi-file components (MFC). Single-file components (SFC) are exempt from section headers but should follow the same member order.

Traits, constants, and properties are not sectioned — they appear at the top of the class as standard PHP class anatomy. The following sections use the Laravel-style divider:

```php
/*
|--------------------------------------------------------------------------
| Section Name
|--------------------------------------------------------------------------
*/
```

**Member order:**

1. Traits (`use` statements, one per line)
2. Constants
3. Public properties (reactive state, form objects, simple form arrays)
4. Protected / private properties (locked properties, internal state)
5. _(section header)_ Lifecycle Hooks — `mount()`, `hydrate()`, `updating()`, `updated()`, etc.
6. _(section header)_ Validation — only when not using `#[Rule]` attributes; `rules()`, `messages()`, `attributes()`
7. _(section header)_ Computed Properties — methods decorated with `#[Computed]`
8. _(section header)_ Actions — public methods called from the template; `#[On]` listener methods colocated here with their action
9. _(section header)_ Protected / Private Methods
10. _(section header)_ Static Methods
11. _(section header)_ Render — explicit `render()` method for MFC and class-based components

**Example `render()` section:**

```php
/*
|--------------------------------------------------------------------------
| Render
|--------------------------------------------------------------------------
*/

public function render(): View
{
    return view('livewire.your-component');
}
```

**Notes:**

- Omit sections that have no members — don't leave empty section blocks
- Prefer `#[Rule]` attributes colocated with properties over a `rules()` method when the project supports it
- Prefer `#[On]` attributes over the `$listeners` property when the project supports it
- Form objects appear as a public property (`public UserForm $form`) — no special section needed

## Control Flow

- **Happy path last**: Handle error conditions first, success case last
- **Avoid else**: Use early returns instead of nested conditions
- **Separate conditions**: Prefer multiple if statements over compound conditions
- **Always use curly brackets** even for single statements
- **Ternary operators**: Each part on own line unless very short

```php
// Happy path last
if (! $user) {
    return null;
}

if (! $user->isActive()) {
    return null;
}

// Process active user...

// Short ternary
$name = $isFoo ? 'foo' : 'bar';

// Multi-line ternary
$result = $object instanceof Model
    ? $object->name
    : 'A default value';

// Ternary instead of else
$condition
    ? $this->doSomething()
    : $this->doSomethingElse();
```

## Laravel Conventions

### Routes

- URLs: kebab-case (`/open-source`)
- Route names: kebab-case (`->name('open-source')`)
- Parameters: camelCase (`{userId}`)
- Use tuple notation: `[Controller::class, 'method']`

### Controllers

- Single resource names (`UserController`)
- Stick to CRUD methods (`index`, `create`, `store`, `show`, `edit`, `update`, `destroy`)
- Extract new controllers for non-CRUD actions
- Consider invokable controllers where appropriate
- Before creating a controller, consider whether a Livewire full-page component would be preferable

### Configuration

- Files: kebab-case (`pdf-generator.php`)
- Keys: snake_case (`chrome_path`)
- Add service configs to `config/services.php`, don't create new files
- Use `config()` helper, avoid `env()` outside config files

### Artisan Commands

- Suffix
- Names: kebab-case (`delete-old-records`)
- Always provide feedback (`$this->comment('All ok!')`)
- Show progress for loops, summary at end
- Put output BEFORE processing item (easier debugging):

```php
$items->each(function(Item $item) {
    $this->info("Processing item id `{$item->id}`...");
    $this->processItem($item);
});

$this->comment("Processed {$items->count()} items.");
```

## Strings & Formatting

- Prefer **String interpolation** or `sprintf()` over concatenation:

## Enums

- Use PascalCase for enum values:

## Whitespace

- Add blank lines between statements for readability
- Exception: sequences of equivalent single-line operations
- No extra empty lines between `{}` brackets
- Let code "breathe" - avoid cramped formatting

## Validation

- Use array notation for multiple rules (easier for custom rule classes):

```php
public function rules() {
    return [
        'email' => ['required', 'email'],
    ];
}
```

- Custom validation rules use snake_case:

```php
Validator::extend('organization_type', function ($attribute, $value) {
    return OrganizationType::isValid($value);
});
```

## Blade Templates

- Add one space between sibling HTML elements unless it is a simple list.
- When extracting content, prefer `@include` for simple boilerplate, Blade components when props or variable scope warrant, and Livewire components when server interactivity is needed.
- In Blade components, use `$attributes->class()` rather than `@class()` or interpolation.
- In other contexts, prefer `@class()` over string interpolation when logic is required.
- Prefer Tailwind classes over `style` attributes.
- When writing Javascript / JSON-LD inside a Blade file, either escape Blade directive-like keys `"@@context": "https://schema.org"` or use the `@verbatim` directive.

## Authorization

- Policies use camelCase: `Gate::define('editPost', ...)`
- Use CRUD words, but `view` instead of `show`

## Testing

- Use **Pest PHP** as the default testing framework.
- Offer to write tests to cover new features.

## General

- Prefer **Eloquent ORM** over raw SQL.
- Avoid over-engineering — no unnecessary abstractions, repository patterns, or service layers unless complexity warrants it.
- For complex tasks, briefly explain your approach before writing code.

## Quick Reference

### Naming Conventions

- **Classes**: PascalCase (`UserController`, `OrderStatus`)
- **Methods/Variables**: camelCase (`getUserName`, `$firstName`)
- **Routes**: kebab-case (`/open-source`, `/user-profile`)
- **Config files**: kebab-case (`pdf-generator.php`)
- **Config keys**: snake_case (`chrome_path`)
- **Artisan commands**: kebab-case (`php artisan delete-old-records`)

### File Structure

- Controllers: single resource name + `Controller` (`PostController`)
- Views: kebab-case (`open-source.blade.php`)
- Jobs: action-based (`CreateUser`, `SendEmailNotification`)
- Events: tense-based (`UserRegistering`, `UserRegistered`)
- Listeners: action + `Listener` suffix (`SendInvitationMailListener`)
- Commands: action + `Command` suffix (`PublishScheduledPostsCommand`)
- Mailables: purpose + `Mail` suffix (`AccountActivatedMail`)
- Enums: descriptive name, no prefix (`OrderStatus`, `BookingType`)
