From: Moritz Rempel <m.rempel@bee.de>
Subject: Re: sata_promise PDC20575 I/O error
Date: Wed, 6 Sep 2006 17:05:36 +0200
Message-ID: <20060906170536.3aa6c8f4.m.rempel@bee.de>
References: <20060905151339.62e5c9be.m.rempel@bee.de>
	<Pine.LNX.4.64.0609050952330.5670@p34.internal.lan>
	<20060906120805.6391b308.m.rempel@bee.de>
	<Pine.LNX.4.64.0609060728130.28237@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.bee.de ([213.221.112.22]:62597 "HELO webmail.bee.de")
	by vger.kernel.org with SMTP id S1751308AbWIFPFX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2006 11:05:23 -0400
In-Reply-To: <Pine.LNX.4.64.0609060728130.28237@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-ide@vger.kernel.org, m.rempel@bee.de

Hi,

On Wed, 6 Sep 2006 07:31:04 -0400 (EDT)
Justin Piszcz <jpiszcz@lucidpixels.com> wrote:

> Bottom line: Your drive is on its way out, get the data off of it and 
> replace ASAP, RMA if still under warranty.

OK, thank you very much for your responsiveness and help!

	Moritz

> 
> Justin.
> 
> 
> >>
> >> On Tue, 5 Sep 2006, Moritz Rempel wrote:
> >>
> >>> Hi!
> >>>
> >>> I'm getting the following error on a system with a Promise SATAII150
> >>> TX2plus Controller:
> >>>
> >>> Sep  4 15:15:26 server kernel: ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> >>> Sep  4 15:15:26 server kernel: ata1: status=0xff { Busy }
> >>> Sep  4 15:15:56 server kernel: ata1: command timeout
> >>> Sep  4 15:15:56 server kernel: ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> >>> Sep  4 15:15:56 server kernel: ata1: status=0xff { Busy }
> >>> Sep  4 15:15:56 server kernel: sd 1:0:0:0: SCSI error: return code = 0x8000002
> >>> Sep  4 15:15:56 server kernel: sdb: Current: sense key: Aborted Command
> >>> Sep  4 15:15:56 server kernel:     Additional sense: Scsi parity error
> >>> Sep  4 15:15:56 server kernel: Info fld=0xfffffff
> >>> Sep  4 15:15:56 server kernel: end_request: I/O error, dev sdb, sector 839
> >>> Sep  4 15:15:56 server kernel: Buffer I/O error on device sdb1, logical block 388
> >>> Sep  4 15:15:56 server kernel: lost page write due to I/O error on sdb1
> >>> Sep  4 15:16:26 server kernel: ata1: command timeout
> >>>
> >>> I had no problem formatting the drive, but the error showes up short after
> >>> issueing mkfs.ext3 on the one partition I created over the whole disk. mkfs
> >>> then hangs and those messages repeat with increasing sector and block number.
> >>>
> >>> Attached to the controller is a external 500G Seagate HD (ST3500641AS)
> >>> connected via eSATA. As I've tested with different HDs (of the same type),
> >>> I think it's not a defective drive.
> >>>
> >>> Kernels I've tested so far: 2.6.16.19 and 2.6.17.11
> >>>
> >>> Any ideas what is goping wrong?
> >>>
> >>> If you need more information or want me to do any tests I'll do my best to
> >>> serve your requests.
> >>>
> >>> thanks in advance,
> >>> 	Moritz
> >>>
> >>
> >> Sep  4 15:15:56 server kernel: end_request: I/O error, dev sdb, sector 839
> >> Sep  4 15:15:56 server kernel: Buffer I/O error on device sdb1, logical
> >> block 388
> >> Sep  4 15:15:56 server kernel: lost page write due to I/O error on sdb1
> >>
> >> May be a bad disk?
> >
> > As mentioned before I tried with two new disks of the same type. Both
> > failed. I'll try to test with yet another one. I'm currently running the
> > tests on the second disk. Would the smart infos of the other failing disk(s)
> > help?
> >
> >> smartctl -d ata -t short /dev/sda # wait 5 min
> >> smartctl -d ata -t long /dev/sda
> >>
> >> Then show us:
> >>
> >> smartctl -d ata -a /dev/sda # output paste into e-mail
> >
> > is attached below. The self-tests ran without errors, but I wonder
> > if those high RAW_VALUES for attributes like Seek_Error_Rate are OK?
> >
> >
> > thanks,
> > 	Moritz
> >
> >
> > smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
> > Home page is http://smartmontools.sourceforge.net/
> >
> > === START OF INFORMATION SECTION ===
> > Device Model:     ST3500641AS
> > Serial Number:    3PM0DPFF
> > Firmware Version: 3.AAD
> > Device is:        Not in smartctl database [for details use: -P showall]
> > ATA Version is:   7
> > ATA Standard is:  Exact ATA specification draft version not indicated
> > Local Time is:    Tue Sep  5 23:00:25 2006 CEST
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> >
> > === START OF READ SMART DATA SECTION ===
> > SMART overall-health self-assessment test result: PASSED
> > See vendor-specific Attribute list for marginal Attributes.
> >
> > General SMART Values:
> > Offline data collection status:  (0x82) Offline data collection activity
> >                                        was completed without error.
> >                                        Auto Offline Data Collection: Enabled.
> > Self-test execution status:      (   0) The previous self-test routine completed
> >                                        without error or no self-test has ever
> >                                        been run.
> > Total time to complete Offline
> > data collection:                 ( 430) seconds.
> > Offline data collection
> > capabilities:                    (0x5b) SMART execute Offline immediate.
> >                                        Auto Offline data collection on/off support.
> >                                        Suspend Offline collection upon new
> >                                        command.
> >                                        Offline surface scan supported.
> >                                        Self-test supported.
> >                                        No Conveyance Self-test supported.
> >                                        Selective Self-test supported.
> > SMART capabilities:            (0x0003) Saves SMART data before entering
> >                                        power-saving mode.
> >                                        Supports SMART auto save timer.
> > Error logging capability:        (0x01) Error logging supported.
> >                                        General Purpose Logging supported.
> > Short self-test routine
> > recommended polling time:        (   1) minutes.
> > Extended self-test routine
> > recommended polling time:        ( 255) minutes.
> >
> > SMART Attributes Data Structure revision number: 10
> > Vendor Specific SMART Attributes with Thresholds:
> > ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
> >  1 Raw_Read_Error_Rate     0x000f   087   067   006    Pre-fail  Always       -       90873478
> >  3 Spin_Up_Time            0x0003   099   099   000    Pre-fail  Always       -       0
> >  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       2
> >  5 Reallocated_Sector_Ct   0x0033   098   098   036    Pre-fail  Always       -       86
> >  7 Seek_Error_Rate         0x000f   071   060   030    Pre-fail  Always       -       21556131258
> >  9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       1446
> > 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
> > 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       4
> > 187 Unknown_Attribute       0x0032   100   100   000    Old_age   Always       -       0
> > 189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always       -       0
> > 190 Unknown_Attribute       0x0022   047   039   045    Old_age   Always   In_the_past 305935351861
> > 194 Temperature_Celsius     0x0022   053   061   000    Old_age   Always       -       53 (Lifetime Min/Max 0/31)
> > 195 Hardware_ECC_Recovered  0x001a   047   046   000    Old_age   Always       -       108510405
> > 197 Current_Pending_Sector  0x0012   070   069   000    Old_age   Always       -       619
> > 198 Offline_Uncorrectable   0x0010   070   069   000    Old_age   Offline      -       619
> > 199 UDMA_CRC_Error_Count    0x003e   200   199   000    Old_age   Always       -       2
> > 200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
> > 202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0
> >
> > SMART Error Log Version: 1
> > No Errors Logged
> >
> > SMART Self-test log structure revision number 1
> > Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
> > # 1  Extended offline    Completed without error       00%      1442         -
> > # 2  Short offline       Completed without error       00%      1439         -
> >
> > SMART Selective self-test log data structure revision number 1
> > SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
> >    1        0        0  Not_testing
> >    2        0        0  Not_testing
> >    3        0        0  Not_testing
> >    4        0        0  Not_testing
> >    5        0        0  Not_testing
> > Selective self-test flags (0x0):
> >  After scanning selected spans, do NOT read-scan remainder of disk.
> > If Selective self-test is pending on power-up, resume after 0 minute delay.
> >
> 
