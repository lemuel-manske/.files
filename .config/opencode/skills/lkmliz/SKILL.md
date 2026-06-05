---
name: lkmliz
description: Write code consistant with the user's code style and opinions.
compatibility: opencode
---

## What I do

- define how to code just like the user, using his code style, his opinions, etc.

## When to use me

Use me whenever changing code.

# How to program like Lemuel?

Lemuel has strong opinions about code style, and he wants to write code that is consistent with his style and opinions.

Let's start simple: Testing.

## Comments

Lemuel don't like comments, he prefer to write code that is self-explanatory and easy to understand without the need of comments.
He prefer to use meaningful names for variables, functions, classes, etc. that explain what they are and what they do.

Comments aren't villains though, they can be useful when they explain the why behind a piece of code,
or when they provide context that isn't obvious from the code itself. But they should be used sparingly and only when necessary.

Docstrings are a special case of comments. Lemuel likes docstrings for public-facing APIs, but not silly documentation for private stuff.
Documentation should be helpful and not fancy. If unsure if documentation is needed, ask yourself: "Would I understand this code without the docstring?" If the answer is yes, then the docstring is probably not needed.

## Testing

### Mocking

Lemuel usually don't like mocking, it is pretty rare to mock things, and when he does, he prefers to hide the mocking from the test,
keeping the test focused on the observed behavior and not on the implementation details that mock requires us to do.

Lemuel prefer stubing over mocking when fake objects are needed, and he prefer to use real objects instead of fake ones when possible.

### Organization

A test file (module or class) always start with the tests. If some configuration is needed (like fixtures, setup, etc.) it is defined before the tests.

Tests start as simple as possible, some simple edge cases and some happy paths, and then more complex cases are added as needed. Just like a well written story: the introductions, the rising, the climax, and the resolution.

### Asserts

Lemuel get's pretty happy when the test can be written with a single assert, and he prefer to avoid multiple asserts in the same test.

To keep tests well written, usually he extract helper methods when more than three assertions are needed in the same test, or when the test is getting too complex.
But, when a simple assert provider by the test framework is enough, he prefer to use it instead of writing custom assert methods.

Lemuel likes to keep helpers at the end of the test file, after the tests.

Lemuel also hates broad assertions, like `in`, `contains`. He prefer to have specific assertions that check the exact expected value,
rather than checking if the actual value contains some expected value. This way, the test is more precise and less prone to false positives.

### Heuristics

Lemuel usually finds bad to extract all what the test is doing with helper methods. It's normal to see some actual code duplication
in the tests, like a function call that could be a helper, etc. Lemuel prefer to have some code duplication in the tests rather than extracting helper methods
that hide the actual behavior of the test, making it harder to understand what the test is doing.

It's better to see what the test is doing in-place rather than navigating all around. Of course, helpers _can_ exist, but Lemuel don't abuse them.

### Examples

Instead of:

```java
void shouldReturnAgentReplyOnSuccess() throws Exception {
  final SmartcareService service = mock(SmartcareService.class);
  final AgentResponse agentResponse = agentResponseWith("The patient has a fever.");
  when(service.executeAgent(eq(AGENT_NAME), any())).thenReturn(agentResponse);

  final LlmChatResponse response = providerWith(service).send(requestForGrid("What is wrong?", "session-1"));

  assertTrue(response.getReply().contains("fever"));
}
```

- Explicit mocking
- Too many helpers
- Broad assertion

Lemuel would write:

```java
void shouldReturnAgentReplyOnSuccess() throws Exception {
  final SmartcareService service = smartcareAnswersWith("The patient has a fever.");

  final LlmChatResponse response = providerWith(service)
    .send(LlmChatRequest.builder()
      .withPrompt("What is wrong with the patient?")
      .withSessionId("123")
      .withContext(ChatContext.builder()
        .viewMode("GRID")
        .records(Collections.singletonList(Map.of("nm_paciente", "John")))
        .fieldLabels(Collections.emptyMap())
        .fieldDescriptions(Collections.emptyMap())
        .build())
      .build());

  assertEquals("The patient has a fever.", response.getReply());
}
```

- Hidden mocking
- Inlined test data
- Single, focused & specific assert

## Code style

Lemuel likes code that provides breathing stops, that is, empty lines between logical blocks of code, or between logical groups of statements.

Lemuel like keeping files small. There's no hard rule about that, though, but if a file is getting too big, usually means it's doing too much.
But, there are exceptions. Like, for example, if a logic is naturally big and complex, and there's no benefit on splitting it into smaller files,
then it's fine to have a big file. But, in general, Lemuel prefer to keep files small and focused on a single responsibility. Same goes for other
constructs, like functions, classes, etc. They should be small and focused on a single responsibility, but if they are naturally big and complex,
and there's no benefit on splitting them into smaller ones, then it's fine to have big constructs.

## Commit style

Lemuel likes semantic commits, that is, commits that have a clear and specific purpose, and that are focused on a single change or a small set of related changes.
He prefer to have short commit messages that explain the what and the why of the change, rather than long commit messages that explain the how of the change.
