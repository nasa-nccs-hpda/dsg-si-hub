# PACE-VCF

Start with the [project overview](knowledge/overview/project-overview.md)
for the Vegetation Continuous Fields (VCF) research goals, scientific
roadmap, metrics-version history, results, and future work.

## Owners

[Project metadata](project.yaml) is the canonical source for the project
name, status, and maintainers.

## Access constraints

Working code lives in a private repository
(`github.com/nasa-nccs-hpda/PACE_VCF`) and an active working copy on NCCS
Explore; this project directory holds the knowledge, troubleshooting record,
a run-book skill, and curated, output-stripped notebooks and scripts -- not
a runnable pipeline (it depends on internal `/explore/nobackup/...` paths,
restricted datasets, and a colleague's non-public training package).

## How the work was done

The [agentic workflow retrospective](knowledge/overview/agentic-workflow.md)
records the move from chat assistance to Claude Code, the division of work
between the agent and project owner, and the workflow's limitations.

## Where to look

- [Project overview](knowledge/overview/project-overview.md) -- experiment
  roadmap, data flow, scientific findings, and future work.
- [Datasets](knowledge/datasets/) -- PACE-OCI, VIIRS LST, MODIS VCF reference
  data, and AlphaEarth Foundations embeddings.
- [Algorithms](knowledge/algorithms/) -- the phenology-based (AltSort) metric
  sorting, Int16 scaling and NaN conventions, the v4 metric definitions and
  duplicate-band removal, and the two-R²-definitions gotcha.
- [Models](knowledge/models/) -- XGBoost + Monte Carlo feature selection, the
  three-model (XGBoost / Spatial-CNN / Pixel-Transformer) comparison, the
  band-count sweep, the multi-seed ranking-stability study, and what the
  PACE-derived bands add over MODIS-equivalent ones.
- [Troubleshooting](knowledge/troubleshooting/) -- real problems found during
  development, each with symptom, confirmed cause, and resolution. Several
  silently produced wrong or optimistic numbers rather than errors -- read
  this before trusting any historical number from this project.
- [Pipeline run book](skills/run-pace-vcf-pipeline/SKILL.md) -- how an agent
  runs, checks and resumes the pipeline on NCCS (internal to NCCS; not
  runnable elsewhere).
- [Examples](examples/README.md) -- curated, output-stripped notebooks and
  the batch launchers used for v4; see the access constraints above.
- [PACE blockers](../../docs/blocker-register.md#pace-001) -- unresolved
  evidence and scientific decisions, with owners and resolution requirements.

## Contributing

Follow the repository [contribution policy](../../CONTRIBUTING.md) for
placement, promotion to shared areas, and information handling. Agents must
also follow the [project instructions](AGENTS.md).
