# PySide2

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Stable Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://micheleceresoli.github.io/PySide2.jl/stable/)
[![Dev Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://micheleceresoli.github.io/PySide2.jl/dev/) 
[![Build Status](https://github.com/MicheleCeresoli/PySide2.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/MicheleCeresoli/PySide2.jl/actions/workflows/CI.yml)
[![Codecov](https://codecov.io/gh/micheleceresoli/PySide2.jl/branch/main/graph/badge.svg?token=A813UUIHGS)](https://codecov.io/gh/micheleceresoli/PySide2.jl)

This package provides a Julia Interface to the [PySide2](https://doc.qt.io/qtforpython-5/index.html) Python Library for [Qt5](https://www.qt.io/). It guarantees an easy access to all of PySide2 functionalities, allowing the development of complex GUI in Julia. It exploits [PythonCall](https://github.com/cjdoris/PythonCall.jl) to silently handle all type conversions from Julia to Python and viceversa.
