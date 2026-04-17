# Laravel & PHP Guidelines

## Framework Preferences

- **Follow Laravel conventions first.** If Laravel has a documented way to do something, use it. Only deviate when you have a clear justification.
- Use **Laravel Boost** when available and applicable.

## Code Style

- Follow PSR-1, PSR-2, and PSR-12 coding standards.
- Prefer short closures and arrow functions (`fn() =>`) where appropriate.
- Use short nullable notation: `?string` instead of `string|null`.
- Avoid inline comments or docblocks unless required for clarity.

## Class Structure

- Use typed properties, not docblocks
- Constructor property promotion when all properties can be promoted
- One trait per line

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

## Authorization

- Policies use camelCase: `Gate::define('editPost', ...)`
- Use CRUD words, but `view` instead of `show`

## Testing

- Use **Pest PHP** as the default testing framework.
- Do not write tests unless asked.

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
