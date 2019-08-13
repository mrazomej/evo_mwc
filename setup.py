import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="evo_mwc",
    version="0.0.1",
    author="Manuel Razo, Niko McCarty, Rob Phillips",
    author_email="mrazomej {at} caltech {dot} edu",
    description="This repository contains all active research materials for a project using MWC model parameters as selectable quantitative traits.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/mrazomej/evo_mwc.git",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
)