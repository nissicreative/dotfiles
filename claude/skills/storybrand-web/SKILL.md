---
name: storybrand-web
description: Generate StoryBrand-aligned web copy for small business marketing sites, primarily home pages. Invoke when asked to write, draft, or outline web content for a client. Requires client context files in the project.
---

Generate web copy using the StoryBrand (SB7) framework developed by Donald Miller. This methodology positions the **customer as the hero** and the **brand as the guide** — never the other way around. Every section of the page should serve the customer's story, not the brand's ego.

## Required Context Files

Before generating any copy, locate the following in the project files. Ask for anything missing:

- **Brand brief** — business name, tagline (if any), core offering, mission
- **Ideal customer profile** — who they are, what they're trying to accomplish, what's frustrating them
- **Services or products** — what's offered and at what level of detail
- **Brand voice** — tone descriptors, words to use/avoid, writing samples if available
- **Social proof** — testimonials, stats, notable clients, awards
- **CTA destination** — what the primary call to action leads to (contact form, booking page, phone call, etc.)

If any of these are missing, ask before generating. Do not invent customer personas or brand details.

---

## The SB7 Framework

StoryBrand maps every marketing message to a 7-part story arc:

| Element                           | Question it answers                                                        |
| --------------------------------- | -------------------------------------------------------------------------- |
| **A Character**                   | Who is the hero? What do they want?                                        |
| **Has a Problem**                 | External (surface), Internal (frustration), Philosophical (why it matters) |
| **Meets a Guide**                 | Why should they trust this brand? (Empathy + Authority)                    |
| **Who Has a Plan**                | What simple steps does the customer take?                                  |
| **And Calls Them to Action**      | What do they do right now?                                                 |
| **That Helps Them Avoid Failure** | What's at stake if they don't act?                                         |
| **And Ends in Success**           | What does their life look like after?                                      |

Every home page section maps to one or more of these elements. Keep this arc in mind throughout.

---

## Home Page Section Structure

Generate copy section by section. For each, include a **copywriter's note** explaining the SB7 purpose of the section.

### 1. Header (Hero Section)

**SB7 elements:** Character + External Problem + Direct CTA

The most important section. Must pass the "grunt test" — a stranger should understand what you do, who it's for, and how to get it within 5 seconds.

- **Headline:** States what the customer wants or what problem is solved. Customer-centric, not brand-centric. Avoid clever wordplay that obscures meaning.
- **Sub-headline:** Clarifies who it's for and the result they'll get. One or two sentences max.
- **Primary CTA button:** Action-oriented, specific. E.g. "Book a Free Call" not "Learn More."
- **Secondary CTA:** Lower-commitment option. E.g. "See Our Work" or "Watch How It Works."

### 2. The Problem (Stakes Section)

**SB7 elements:** External + Internal + Philosophical Problem

Name the villain — the real friction the customer faces. This section earns trust by showing you understand their situation before you pitch your solution.

- Lead with **external problem** (the surface-level issue)
- Acknowledge the **internal frustration** (how it makes them feel)
- Hint at the **philosophical wrong** (why this shouldn't be)
- Keep it brief — 2–3 short paragraphs or a tight list of pain points
- Do NOT introduce the solution here; let the tension sit

### 3. The Guide Introduction

**SB7 elements:** Empathy + Authority

The brand enters the story — but as a guide, not a hero. Two elements must be present:

- **Empathy statement:** Show you understand the struggle. "We know how frustrating it is when..."
- **Authority signal:** Prove you can help. Use specifics: years in business, number of clients, credentials, recognizable outcomes — not generic claims like "we're the best."

Keep this section focused. One short paragraph for empathy, one for authority, or blend them into a tight 3–4 sentence block.

### 4. The Plan

**SB7 elements:** The Plan (Process Plan)

Reduce the perceived risk of working with you by showing a simple, clear path forward. Three steps is the sweet spot — never more than four.

Format as a numbered list or visual step sequence:

1. **[Action verb] [short label]** — One sentence describing what this step involves.
2. **[Action verb] [short label]** — One sentence.
3. **[Action verb] [short label]** — One sentence describing the outcome they're moving toward.

Steps should feel achievable, not overwhelming. The final step should hint at transformation/success.

### 5. Explanatory Section (Value Proposition)

**SB7 elements:** Character + Success Preview

Optional but useful for services that need more explanation. Expand on what's offered and connect each service/feature directly to a customer outcome. Structure as:

- Short intro paragraph (2–3 sentences)
- 2–4 service/feature blocks, each with:
    - Short label/name
    - 1–2 sentence customer-outcome description (not a feature dump)

Avoid internal jargon. Every sentence should answer "so what?" from the customer's perspective.

### 6. Social Proof

**SB7 elements:** Authority + Success

Testimonials, results, logos, or stats. Place after the plan — the customer now understands what you do and is considering whether to trust you.

- Pull 2–3 testimonials from the provided social proof. Prefer quotes that mention a specific result or name a problem that was solved.
- If stats are available, surface 2–3 with a one-line label (e.g. "200+ clients served," "12 years in business")
- If no social proof is provided, flag this as a gap and leave a placeholder

### 7. Direct CTA Section

**SB7 elements:** Call to Action

A standalone section dedicated entirely to asking the customer to take the next step. Often repeated from the header but placed after social proof.

- Short, punchy headline framed around the customer's success (not the brand's offer)
- 1–2 sentences of supporting copy reinforcing what they get
- Single, prominent CTA button — same label as in the header for consistency

### 8. Failure / Stakes (Optional but Powerful)

**SB7 elements:** Avoid Failure

Name what's at risk if the customer doesn't act. This section can feel uncomfortable to write but it's psychologically effective — loss aversion is real.

Use sparingly and honestly. One short paragraph or 3 bullet points naming real consequences of inaction. Do not fear-monger; frame it as caring about the customer's outcome.

Can be woven into the problem section or the CTA section rather than standing alone if the tone requires it.

### 9. Footer

Not a StoryBrand section per se, but should include:

- Tagline or one-liner restatement
- Navigation links
- Contact info or CTA
- Legal links

---

## Copy Principles

- **Customer is always the subject.** Audit every headline: if it starts with "We" or the brand name, rewrite it.
- **Clarity over cleverness.** If a reader has to think about what you mean, rewrite it.
- **Specificity builds trust.** "Over 150 logos designed for Nashville small businesses" beats "years of experience."
- **Active voice.** Passive constructions drain energy from copy.
- **Short sentences.** Especially in CTAs, headers, and problem statements.
- **No mission statement language.** Avoid "passionate," "dedicated," "innovative," "solutions," "synergy."
- **Match the voice file.** If a brand voice document is provided, read it before writing a word and honor it throughout.

---

## Output Format

Unless instructed otherwise, output copy section by section with:

```
## [Section Name]

**Copywriter's note:** [1–2 sentences on what this section accomplishes in the SB7 arc]

---

[Copy]
```

After all sections, include a **Review Checklist:**

- [ ] Hero passes the grunt test (understood in 5 seconds)
- [ ] Customer is the subject, brand is the guide
- [ ] Problem is named before solution is introduced
- [ ] Plan has 3 clear steps
- [ ] At least one real testimonial or stat included
- [ ] Primary CTA is consistent across sections
- [ ] No mission statement language
- [ ] Copy matches provided brand voice

---

## Example Invocations

- "Write a StoryBrand home page for [client]. Use the brand brief and testimonials in this project."
- "Draft the hero section and problem section for [client] following the StoryBrand skill."
- "Review this existing copy against the StoryBrand framework and suggest rewrites."
- "I have a new client in [industry] — what context files do I need before you can write the home page?"
