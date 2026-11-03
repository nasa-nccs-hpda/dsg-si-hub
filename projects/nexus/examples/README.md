# Nexus examples

## Implemented examples

- [ROCKE-3D Figure 6 reproduction](rocke3d-figure6/README.md): script, notebook, and retained plot using the Tsigaridis et al. (2025) publication supplement. The example documents its source, execution paths, and regeneration limits.

## Contribution guidance

The contribution examples below describe where information belongs; they do not assert facts about Nexus.

## Add a dataset note

Copy the [dataset template](../../../knowledge/templates/dataset-entry.md) to:

```text
projects/nexus/knowledge/datasets/<dataset-name>.md
```

Document how Nexus uses the dataset, where approved users obtain it, its important fields, and known limitations. Do not commit protected data.

## Add a model entry

Copy the [model template](../../../knowledge/templates/model-entry.md) to:

```text
projects/nexus/knowledge/models/<model-name>.md
```

Describe how to configure, run, diagnose, and validate the model. If multiple projects use it, promote the entry to `knowledge/models/`.

## Add a troubleshooting note

For a recurring issue, add:

```text
projects/nexus/knowledge/troubleshooting/<short-problem-name>.md
```

Include symptoms, confirmed causes, safe diagnostic commands, resolution steps, and the environment in which the resolution was verified.

## Add a skill

Create a skill only when the procedure is repeatable and an agent should carry it out. Begin with the [example skill](../../template-project/skills/example-skill/), rename the directory and skill, and add an evaluation case.
