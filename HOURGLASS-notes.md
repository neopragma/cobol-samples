# Setting the date/time for a job or step with HourGlass

This document is not about Cobol coding as such, and there is no executable example in this project that corresponds to this information. 

There are occasions when you want to control the date and time a program sees when it obtains the current date using the [CURRENT-DATE intrinsic function](DATE1-notes.md) or the [ACCEPT statement](DATE2-notes.md). Two common use cases are:

- re-running or restarting a date-dependent job that must generate output containing a date other than the present calendar date, such as a month-end or year-end job that failed on a previous day; and 
- running controlled tests of a program in which one or more test cases depends on a particular date value, such as verifying month-end functionality for February in leap and non-leap years, or calculating the next invoice date from a given day of the month. 

The IBM product, HourGlass, enables you to control the run date and time for a job or job step in several ways. 

Note that this only works with HourGlass installed. You can include date and/or time cards in your JCL to set the system date and/or time just for a particular job step. 

This is the format for a date card:

```
//HGcyyddd    DD  DUMMY
```

_HG_ is the default prefix for HourGlass. This may be set differently when HourGlass is installed, but in most shops it will be HG. 

_c_ denotes the century, where 0 is the 20th century and 1 is the 21st century. 

_yy_ is the last two digits of the year within the specified century. 

_ddd_ is the day of the year (not the day of any monty). 

Example: 

``` 
//...      EXEC  ... 
//HG122036   DD  DUMMY 
```` 

represents February 6, 2022. 

There are special DD card formats to specify a relative date in terms of offsets to the year or day. Consult the HourGlass documentation for details. 

This is the format for a time card: 

```
//HGdhhmm 
```

_d_ is the _direction_ of the time offset. Values are: 

- P plus - add the specified number of hours and minutes to the current time.
- M minus - subtract the specified number of hours and minutes from the current time. 
- F fixed - set the job step start time to this value (not an offset).
- A absolute - make the system return the same time value every time the application requests the system time. 
- E east - increments the job step start time based on the user's timezone. 
- W west - decrements the job step start time based on the user's timezone. 

_hh_ is the hour to set, or the time offset in hours from current time. 
_mm_ is the minute to set, or the time offset in minutes (within hours) from current time. 


Example: 

``` 
//...      EXEC  ... 
//HGF0320    DD  DUMMY 
``` 

This means to set the job step start time for this step to the fixed value of 3:20 a.m.

If you need a job step to honor the real system date/time, while HourGlass provides the date/time for other steps, you can include a "bypass" card in that step: 

``` 
//...      EXEC  ... 
//HGBYPASS   DD  DUMMY 
``` 

## Additional information 

- [IBM HourGlass Documentation: Specifying the Date and Time Using DD Statements](https://www.ibm.com/support/knowledgecenter/SS9S7H_6.1.0/com.ibm.hourglass.doc_6.1/aggic36.html)

