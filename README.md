# Repository Agnostic INgest (RAIN)

[![Coverage Status](https://coveralls.io/repos/MITLibraries/rain/badge.svg?branch=pre_workflow_cleanup&service=github)](https://coveralls.io/github/MITLibraries/rain?)
[![Dependency Status](https://gemnasium.com/MITLibraries/rain.svg)](https://gemnasium.com/MITLibraries/rain)
[![Code Climate](https://codeclimate.com/github/MITLibraries/rain/badges/gpa.svg)](https://codeclimate.com/github/MITLibraries/rain)

## What is this?

RAIN will initially be a system in which admin users can create workflows for
users to upload content, create packages, and deposit into repositories.

The initial use case will be to solve a Department of Energy requirement.

## How does it work?

It doesn't.

## How will it work?

### Ingest workflow creator

The gist is that it'll treat an HTML form like a tree and allow the nodes of the tree to be
added and manipulated based on rules of how HTML forms actualy work.

For instance, `fieldset` can be added to a `form` element, but a `form` cannot be added to
a `fieldset`.

This should allow for the flexibility in creating complex single-page forms for the initial
ingest work.

### Packaging

We'll initially support METS, but other options should be easy to add.

### Deposit

This could get interesting. Our main MIT use case is DSpace, but we are interested in
building this to support Fedora as well. It is possible we'd consider expanding this to
do the subject repository deposit as well (i.e. deposit in DSpace@MIT and DOE) to allow our
researchers to focus on one repository while we orchestrate the hoop jumping necessary to
allow them to fulfill the requirements of their grant funding. If we did that, it would
likely be a checkbox option like "Are you grant funded by DOE?" and if checked do what is
necessary.
