# ROCKE-3D Figure 6 reproduction

- Project: [Nexus](../../README.md); scientific ownership remains unassigned in [project metadata](../../project.yaml).
- Documentation last reviewed: 2026-11-02 (placement and execution guidance; scientific results were not revalidated).
- Relocation scope: [issue #9](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/9).

This example plots global annual net planetary radiation from the ROCKE-3D 2.0 publication supplement. It reads existing simulation output; it does not run ROCKE-3D or validate the Nexus JAX implementation.

## Source and retained files

The scientific source is Tsigaridis et al. (2025), [*ROCKE-3D 2.0: an updated general circulation model for simulating the climates of rocky planets*](https://gmd.copernicus.org/articles/18/5825/2025/index.html), Geoscientific Model Development, 18, 5825–5871, DOI: [10.5194/gmd-18-5825-2025](https://doi.org/10.5194/gmd-18-5825-2025). Figure 6 summarizes net planetary radiation over the final 100 years of the balanced simulations.

Inputs come from the public [NASA GISS publication supplement](https://portal.nccs.nasa.gov/GISS_modelE/ROCKE-3D/publication-supplements/Tsigaridis2025GMD-planet_2.0/). The script and notebook retain their configuration mappings and comments about name corrections relative to the supplement's `README.txt`. They read index 2 (global) of `net_rad_planet_hemis` from annual `aij` NetCDF files, in W m⁻².

| File | Purpose |
| --- | --- |
| [reproduce_figure6.py](reproduce_figure6.py) | Command-line downloader and plotting script |
| [reproduce_figure6.ipynb](reproduce_figure6.ipynb) | Interactive version, with original code and saved outputs |
| [figure6_reproduction.png](figure6_reproduction.png) | Retained generated image, moved without changing its bytes |

These files previously lived in the repository-root `notebooks/` directory. The script, scientific calculations, notebook code and saved outputs, and retained image are preserved by this move.

## Environment and working directory

From the repository root, enter this directory and prepare a Python environment:

```bash
cd projects/nexus/examples/rocke3d-figure6
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install netCDF4 'matplotlib>=3.9,<3.11' jupyterlab ipykernel
```

Both entry points use netCDF4 and Matplotlib. The version range accommodates the script's `tick_labels` argument and the notebook's older `labels` argument; see the [Matplotlib boxplot compatibility notes](https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.boxplot.html). This is a dependency setup guide, not a locked environment. The notebook's retained output reports Matplotlib 3.10.3 and netCDF4 1.7.2.

Paths are relative to the process or kernel working directory. Run the commands below from this example directory. Downloads go into `./rocke3d_cache/`, which is ignored by Git at this location as well as at the old location. Outputs default to `figure6_reproduction.png`; the examples below use different names to preserve the retained image.

## Regenerate with the script

Inspect options without downloading data:

```bash
python3 reproduce_figure6.py --help
```

Start with one configuration and one year to check access and plotting:

```bash
python3 reproduce_figure6.py --configs P2GApM40 --n-years 1 --workers 1 --out figure6_smoke.png
```

For all 36 configured M40 and F40 cases using the last 100 available annual files per case:

```bash
python3 reproduce_figure6.py --configs all --n-years 100 --workers 1 --out figure6_regenerated.png
```

Without `--configs`, the script selects the 18 M40 cases; its default window is 100 years. Use `--cache-dir` and `--out` to choose other locations. A full run can download many gigabytes. The script still lists remote files on each run, even when the data are cached, so network access to the supplement is required.

## Regenerate with the notebook

Launch Jupyter from this directory:

```bash
python3 -m jupyterlab reproduce_figure6.ipynb
```

Select a kernel using the environment prepared above; the saved kernel name refers to the original contributor's conda environment. Run cells in order. The notebook defaults to `N_YEARS = 20` and selects the 18 M40 cases via `CONFIGS`; its retained prose says 12, which disagrees with that selection. Set `N_YEARS = 100` and `SELECTED = list(CONFIGS)` for the full configured set. Change the plotting cell's `fig.savefig(...)` filename before execution to preserve the retained PNG.

The existing environment self-check may attempt a `pip install --user -U matplotlib` if plotting imports fail. Prepare the dependencies before execution; that fallback does not preserve the version range above.

## Limitations and verification boundary

The script and notebook catch configuration failures, print warnings, and continue. A saved plot therefore does not establish that every requested configuration succeeded. The notebook's saved output includes a skipped `P2GNoM40` case with `NetCDF: Not a valid ID`. Using `--workers 1` in the script avoids concurrent NetCDF reads for an initial diagnostic run; it does not establish a fix or a scientific validation result.

The retained image has no separate run manifest identifying its exact inputs, configuration set, or package versions. The commands above describe how to generate a new plot; byte-for-byte regeneration of the retained image is not established. Record configuration names, year windows, warnings, package versions, and input provenance when reviewing a new run. Keep generated caches and trial plots out of contributions unless deliberately curated as evidence.

This relocation preserves the original evidence without reconciling its claims. Nexus's scientific ownership and validation decisions remain subject to the [open Nexus blockers](../../../../docs/blocker-register.md#imvi-001).
