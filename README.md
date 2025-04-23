# Registra

Registra is a drive time logger for iOS and macOS.

## Motivation

This is a project of mine that started out as a spreadsheet that I used to keep
track of my driving hours while obtaining my driving license which I've
continued since I'm interested to see the data trends.

## Core Features

- User must be able to add driving entries with a start and end time, driven
  distance, and associate it with a car
- The application must calculate the amount of time, weather condititions at
  every 10 minute intervals, and the amount of time in daylight/night conditions
- User must be able to add cars with a name, make, model, year, trim level,
  odometer distance unit (km/mi)
- Application must be able to take the input driven distance in the units for
  the car in question and standardise them for comparison/analysis.
- The user must be able to enter a description of the weather conditions and
  manually classify entries as being during the day or the night, if desired.
- The application must give statistcs both in general and on a per-car basis
- The user must be able to archive cars which they no longer have access to or
  deem unlikely to drive in the near future.
- The user must be able to unarchive cars which they are currently driving
- Archived cars must not be offered as an option for a car driven during a newer
  entry.
- Prexisting entries linked to cars which subsequently become archived must
  - remain in the statistical information
  - remain visible in the list of entries
  - be immutable
- User must be able to import and export data into a CSV file

## Project Status

This project is currently in its infancy. Versions will be issued according to
the semantic versioning system (eg x.y.z; x = major, y = minor, z = patch;
breaking changes only in major versions or any version where major is 0).
Initial development versions will be numbered 0.y.z. Contributions to the
project in the form of issues and pull requests are welcome. Since this is more
of a side project, I cannot guarantee as quick a response, though I will try my
best to respond to any contributions.
