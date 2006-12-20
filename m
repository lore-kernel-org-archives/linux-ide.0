From: Kovid Goyal <kovid@theory.caltech.edu>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Tue, 19 Dec 2006 18:00:18 -0800
Message-ID: <200612191800.18624.kovid@theory.caltech.edu>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from theory.caltech.edu ([131.215.116.2]:39864 "EHLO
	theory.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964785AbWLTC0B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 21:26:01 -0500
In-Reply-To: <4588877D.1000400@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Yes going back to 2.6.17 does fix it. Also windows and various LiveCDs =
boot=20
without problems.=20

Here is the output=20
smartctl -d ata -a /dev/sda
smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Al=
len
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
Device Model:     ST380013AS
Serial Number:    5JVFSQQW
=46irmware Version: 8.05
User Capacity:    80,000,000,000 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 2
Local Time is:    Tue Dec 19 17:56:07 2006 PST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activit=
y
                                        was completed without error.
                                        Auto Offline Data Collection: E=
nabled.
Self-test execution status:      (   0) The previous self-test routine=20
completed
                                        without error or no self-test h=
as ever
                                        been run.
Total time to complete Offline
data collection:                 ( 430) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate=
=2E
                                        Auto Offline data collection on=
/off=20
support.
                                        Suspend Offline collection upon=
 new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        No Conveyance Self-test support=
ed.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before enterin=
g
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging supp=
ort.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        (  58) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDAT=
ED =20
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   060   057   006    Pre-fail =20
Always       -       38101080
  3 Spin_Up_Time            0x0003   098   098   000    Pre-fail =20
Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age  =20
Always       -       8
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail =20
Always       -       0
  7 Seek_Error_Rate         0x000f   086   060   030    Pre-fail =20
Always       -       424904923
  9 Power_On_Hours          0x0032   087   087   000    Old_age  =20
Always       -       11741
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail =20
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age  =20
Always       -       311
194 Temperature_Celsius     0x0022   060   072   000    Old_age  =20
Always       -       60
195 Hardware_ECC_Recovered  0x001a   060   057   000    Old_age  =20
Always       -       38101080
197 Current_Pending_Sector  0x0012   100   100   000    Old_age  =20
Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age  =20
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age  =20
Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age  =20
Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age  =20
Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(ho=
urs) =20
LBA_of_first_error
# 1  Short offline       Completed without error       00%     11726   =
      -
# 2  Short offline       Completed without error       00%     11702   =
      -
# 3  Short offline       Completed without error       00%     11679   =
      -
# 4  Extended offline    Completed without error       00%     11658   =
      -
# 5  Short offline       Completed without error       00%     11655   =
      -
# 6  Short offline       Completed without error       00%     11632   =
      -
# 7  Short offline       Completed without error       00%     11608   =
      -
# 8  Short offline       Completed without error       00%     11585   =
      -
# 9  Short offline       Completed without error       00%     11562   =
      -
#10  Short offline       Completed without error       00%     11538   =
      -
#11  Extended offline    Completed without error       00%     11500   =
      -
#12  Short offline       Completed without error       00%     11498   =
      -
#13  Short offline       Completed without error       00%     11474   =
      -
#14  Short offline       Completed without error       00%     11452   =
      -
#15  Short offline       Completed without error       00%     11429   =
      -
#16  Short offline       Completed without error       00%     11405   =
      -
#17  Short offline       Completed without error       00%     11381   =
      -
#18  Short offline       Completed without error       00%     11358   =
      -
#19  Extended offline    Completed without error       00%     11338   =
      -
#20  Short offline       Completed without error       00%     11334   =
      -
#21  Short offline       Completed without error       00%     11311   =
      -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute de=
lay.

Thanks,

Kovid.

On Tuesday 19 December 2006 16:44, you wrote:
> Does goving back to 2.6.17 fix the problem? =A0Also, please report th=
e
> result of 'smartctl -d ata -a /dev/sdX' where sdX is the problematic =
drive.

--=20
_____________________________________

Kovid Goyal  MC 452-48
California Institute of Technology
1200 E California Blvd
Pasadena, CA 91125

home  : +01 626 390 8699
office: +01 626 395 6595 (449 Lauritsen)
email : kovid@theory.caltech.edu
web   : http://www.kovidgoyal.net
_____________________________________
