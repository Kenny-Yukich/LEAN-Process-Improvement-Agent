# Privacy and Public-Release Checklist

This repository was constructed as a clean public edition, not as a redacted production export.

## Never commit

- Hidden platform export/cache folders.
- Connection references or connector configuration.
- Environment, tenant, account, user, agent, or deployment identifiers.
- Email addresses, credentials, tokens, private URLs, or internal domains.
- Real employee, customer, supplier, product, or facility information.
- Internal newsletters, workbooks, process logs, screenshots, or attachments.
- Real production measurements unless they are explicitly approved for publication.

## Before every release

1. Run `./scripts/privacy-check.ps1`.
2. Review `git diff --cached` and `git ls-files` manually.
3. Confirm every example is fictional or cited from a public source.
4. Confirm generated exports have not appeared under a new filename.
5. Review the complete Git history, not only the latest working tree.

## If private information is found

Stop publication. Remove the material from the working tree and full Git history, rotate any exposed credentials, and obtain the appropriate internal review before trying again.

