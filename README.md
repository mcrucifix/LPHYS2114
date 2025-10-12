# LPHYS2114 — Course Notes

**Note:** To build the notes, simply run `make`. All compilation steps are handled automatically.

These are the working course notes for the UCLouvain course  
**LPHYS2114 – Climatology and Climate Physics**  
➡ https://uclouvain.be/cours-2024-lphys2114

---

[![License: GPL](https://img.shields.io/badge/License-GPL-blue.svg)](LICENSE)

---

## Status

- **License:** Distributed under the **GNU General Public License (GPL)**.
- **Work in progress:** These notes are *not yet fully proofread for publication*.  
  - Citations may be incomplete or not fully up to date.
  - Some sections are in draft form and may evolve.

Feedback and corrections are welcome.

---

## Installation and Compilation

### Requirements

To compile the notes successfully, install:

| Dependency | Purpose | Notes |
|------------|---------|-------|
| **TeX Live 2025** | Main typesetting engine | Earlier TeX Live versions should also work. |
| **ePiX** | For figure generation | https://mathcs.holycross.edu/~ahwang/current/ePiX.html |
| **Python + IPython** | For executing included notebooks | Used for interactive material |
| **Pandoc** | For document conversion | Required by the Makefile |
| **Git with submodule support** | Required for auxiliary content | See below |

### Cloning the Repository

This repository includes a submodule. Clone as follows:

```bash
git clone --recursive https://github.com/mcrucifix/lphys2114.git
# or, if already cloned:
git submodule update --init --recursive

