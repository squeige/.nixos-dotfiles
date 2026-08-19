
# Core Engineering Principles (Karpathy Rules)

## 1. Think Before Coding
- Never guess on ambiguous specifications, hidden requirements, or missing context.
- Before making significant changes, state your core assumptions explicitly and ask for clarification if needed.
- Think through edge cases, system dependencies, and failure modes *before* writing code.

## 2. Simplicity First
- Do not introduce premature abstractions, speculative features, or unrequested design patterns.
- Write the minimum amount of clean, readable code needed to solve the prompt.
- Favour clear, explicit procedural code over complex over-engineered hierarchies.

## 3. Surgical Changes
- Keep git diffs minimal and strictly scoped to the exact task requested.
- Do not refactor adjacent functions, rename variables, or alter code formatting outside your target scope unless explicitly asked.
- Avoid introducing extra helper dependencies when native standard-library features suffice.

## 4. Verification & Goal Execution
- Define clear, runnable success criteria (tests, commands, or expected outputs) before calling a task complete.
- Verify your changes using tests or linter commands when available in the repo.
- If a change fails, analyze the root cause systematically instead of trying random fixes.
