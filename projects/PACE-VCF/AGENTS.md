# PACE-VCF agent instructions

- Read [project metadata](project.yaml) for the name, status, and maintainers,
  and the [project overview](knowledge/overview/project-overview.md) for the
  scientific roadmap and results.
- Run the pipeline only inside NCCS Explore; respect the
  [access constraints](README.md#access-constraints).
- Treat performance numbers (R², RMSE) as tied to a metrics version and to
  the fix state described in the
  [troubleshooting record](knowledge/troubleshooting/). Several problems
  documented there silently altered reported metrics without raising errors.
  Quote a number only with its version (v2, v3, v4), its R² definition, and
  whether it is a chip-level or full-tile score.
- This project uses two R² definitions (`coefficient_of_determination` vs.
  squared Pearson correlation) -- see
  [the two R² definitions](knowledge/algorithms/two-r2-definitions.md) before
  comparing two numbers.
- Neural-model band rankings from a single training run are unstable; read
  [the multi-seed study](knowledge/models/multi-seed-ranking-stability.md)
  before interpreting a feature-importance list.
- Treat [examples](examples/README.md) as methodology documentation, not as
  evidence of execution or independently reproduced results.
- To run or resume the pipeline on NCCS, use
  the [pipeline run book](skills/run-pace-vcf-pipeline/SKILL.md). Batch jobs
  are submitted by the project owner, not by the agent.
- Do not invent follow-on results, additional experiments, or validation that
  isn't documented here.
- Never add credentials, restricted datasets, or non-public collaborator
  code.
