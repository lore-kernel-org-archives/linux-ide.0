From: Patrik Jonsson <patrik@ucolick.org>
Subject: Re: Frequent SATA errors / port timeouts in 2.6.18.3?
Date: Tue, 19 Dec 2006 16:31:58 -0800
Message-ID: <4588847E.3090303@ucolick.org>
References: <4578F5D4.8080205@moniker.net> <4580907D.1020407@ucolick.org> <4587903C.3050204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB1E726F26A1F959EB1A0491B"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hunan.ucolick.org ([128.114.23.233]:57185 "EHLO
	smtp.ucolick.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbWLTAby (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 19:31:54 -0500
In-Reply-To: <4587903C.3050204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1E726F26A1F959EB1A0491B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tejun Heo wrote:
> Patrik Jonsson wrote:
>> First I thought it was a cabling or card issue, because the same drive=

>> got kicked twice. That drive was connected to a 2-port SIG sata_sil24
>> card. However, I just had another drive kicked that's connected to the=

>> onboard sata_nv, which leads me to suspect that the upgraded kernel
>> might have something to do with it. A quick googling seems to indicate=

>> that others are seeing this with 2.6.18, too, so I was wondering if
>> anyone knows more.
>=20
> I don't think there has been any change which can affect both sata_sil2=
4
> and sata_nv to cause timeouts.  Please post the result of 'smartctl -d
> ata -a /dev/sdX' of failed devices.

At the time it happened, none of the devices responded to smart commands
("not an ATA device"). After resetting, they do. The outputs are at the
bottom.

>=20
>> The drives contain science data for analysis, so it
>> would be a pain (though not a disaster) to lose it. Would it be
>> advisable to revert to the previous 2.6.17 that I was running before o=
r
>> is this a problem that's fixed in a later kernel than the one I'm
>> running now?
>>
>> I did at the same time also install an Areca ARC1260 controller and
>> connected a bunch of drives to it, so another idea I had was cable
>> interference or something (there are now 18 drives in the machine).
>>
>> Any ideas or thought would be appreciated,
>=20
> Power quality degradation can cause transmission failures which can
> result in timeouts.  How are your power lines hooked?

The drives are connected to the Seasonic M12-600 PSU, connected to an
APC BackUPS and then it's in the wall. It's in a dedicated computer
room, but I'm not sure if the power in conditioned in any way.

cheers,

/Patrik


**** Drive 1 SMART output ****


=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     WDC WD2500SD-01KCC0
Serial Number:    WD-WCAL74587210
Firmware Version: 08.02D08
User Capacity:    250,059,350,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Dec 19 16:25:01 2006 PST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x05) Offline data collection activity
                                        was aborted by an interrupting
command from host.
                                        Auto Offline Data Collection:
Disabled.
Self-test execution status:      (   0) The previous self-test routine
completed
                                        without error or no self-test
has ever
                                        been run.
Total time to complete Offline
data collection:                 (6942) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                        Auto Offline data collection
on/off support.
                                        Suspend Offline collection upon n=
ew
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging suppor=
t.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  88) minutes.
Conveyance self-test routine
recommended polling time:        (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   200   159   051    Pre-fail  Always
      -       0
  3 Spin_Up_Time            0x0007   123   121   021    Pre-fail  Always
      -       6375
  4 Start_Stop_Count        0x0032   100   100   040    Old_age   Always
      -       172
  5 Reallocated_Sector_Ct   0x0033   183   183   140    Pre-fail  Always
      -       271
  7 Seek_Error_Rate         0x000b   200   200   051    Pre-fail  Always
      -       0
  9 Power_On_Hours          0x0032   083   083   000    Old_age   Always
      -       12742
 10 Spin_Retry_Count        0x0013   100   100   051    Pre-fail  Always
      -       0
 11 Calibration_Retry_Count 0x0013   100   100   051    Pre-fail  Always
      -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always
      -       171
194 Temperature_Celsius     0x0022   125   103   000    Old_age   Always
      -       25
196 Reallocated_Event_Count 0x0032   161   161   000    Old_age   Always
      -       39
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always
      -       1
198 Offline_Uncorrectable   0x0012   200   200   000    Old_age   Always
      -       0
199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always
      -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail
Offline      -       0

SMART Error Log Version: 1
ATA Error Count: 899 (device log contains only the most recent five error=
s)
        CR =3D Command Register [HEX]
        FR =3D Features Register [HEX]
        SC =3D Sector Count Register [HEX]
        SN =3D Sector Number Register [HEX]
        CL =3D Cylinder Low Register [HEX]
        CH =3D Cylinder High Register [HEX]
        DH =3D Device/Head Register [HEX]
        DC =3D Device Command Register [HEX]
        ER =3D Error register [HEX]
        ST =3D Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.


Error 899 occurred at disk power-on lifetime: 12737 hours (530 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 08 2a c3 90 e5  Error: UNC 8 sectors at LBA =3D 0x0590c32a =3D 93=
373226

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 28 c3 90 05 00   5d+19:30:10.900  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:10.900  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:10.900  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:10.900  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:10.900  READ DMA

Error 898 occurred at disk power-on lifetime: 12737 hours (530 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 08 2a c3 90 e5  Error: UNC 8 sectors at LBA =3D 0x0590c32a =3D 93=
373226

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 28 c3 90 05 00   5d+19:30:08.850  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:08.850  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:08.850  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:08.850  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:08.850  READ DMA

Error 897 occurred at disk power-on lifetime: 12737 hours (530 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 08 2a c3 90 e5  Error: UNC 8 sectors at LBA =3D 0x0590c32a =3D 93=
373226

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 28 c3 90 05 00   5d+19:30:06.800  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:06.800  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:06.800  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:06.800  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:06.800  READ DMA

Error 896 occurred at disk power-on lifetime: 12737 hours (530 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 08 2a c3 90 e5  Error: UNC 8 sectors at LBA =3D 0x0590c32a =3D 93=
373226

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 28 c3 90 05 00   5d+19:30:04.650  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:04.650  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:04.650  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:04.650  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:04.650  READ DMA

Error 895 occurred at disk power-on lifetime: 12737 hours (530 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 08 2a c3 90 e5  Error: UNC 8 sectors at LBA =3D 0x0590c32a =3D 93=
373226

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 28 c3 90 05 00   5d+19:30:02.550  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:02.550  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:02.550  READ DMA
  ec 00 08 2a c3 90 00 00   5d+19:30:02.550  IDENTIFY DEVICE
  c8 00 08 28 c3 90 05 00   5d+19:30:02.550  READ DMA

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     12742
     -
# 2  Extended offline    Completed: read failure       70%     12738
     110374951
# 3  Short offline       Completed: read failure       10%     12729
     93373219
# 4  Short offline       Completed: read failure       10%     12705
     93373219
# 5  Extended offline    Completed: read failure       70%     12681
     93373219
# 6  Short offline       Completed: read failure       10%     12657
     93373219
# 7  Short offline       Completed: read failure       10%     12633
     93373219
# 8  Short offline       Completed: read failure       10%     12609
     93373219
# 9  Extended offline    Completed: read failure       70%     12598
     93373219
#10  Short offline       Completed without error       00%     12587
     -
#11  Short offline       Completed without error       00%     12563
     -
#12  Short offline       Completed without error       00%     12543
     -
#13  Short offline       Completed without error       00%     12519
     -
#14  Extended offline    Completed without error       00%     12396
     -
#15  Short offline       Completed without error       00%     12342
     -
#16  Short offline       Completed without error       00%     12318
     -
#17  Short offline       Completed without error       00%     12294
     -
#18  Extended offline    Completed without error       00%     12272
     -
#19  Short offline       Completed without error       00%     12247
     -
#20  Short offline       Completed without error       00%     12223
     -
#21  Short offline       Completed without error       00%     12202
     -


**** Drive 2 SMART output ****


=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     WDC WD2500SD-01KCC0
Serial Number:    WD-WCAL74586965
Firmware Version: 08.02D08
User Capacity:    250,059,350,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Dec 19 16:27:31 2006 PST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x02) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection:
Disabled.
Self-test execution status:      (   0) The previous self-test routine
completed
                                        without error or no self-test
has ever
                                        been run.
Total time to complete Offline
data collection:                 (7275) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                        Auto Offline data collection
on/off support.
                                        Suspend Offline collection upon n=
ew
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging suppor=
t.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  91) minutes.
Conveyance self-test routine
recommended polling time:        (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   200   158   051    Pre-fail  Always
      -       0
  3 Spin_Up_Time            0x0007   146   126   021    Pre-fail  Always
      -       5225
  4 Start_Stop_Count        0x0032   100   100   040    Old_age   Always
      -       94
  5 Reallocated_Sector_Ct   0x0033   183   183   140    Pre-fail  Always
      -       258
  7 Seek_Error_Rate         0x000b   200   200   051    Pre-fail  Always
      -       0
  9 Power_On_Hours          0x0032   094   094   000    Old_age   Always
      -       4878
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always
      -       0
 11 Calibration_Retry_Count 0x0013   100   253   051    Pre-fail  Always
      -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always
      -       93
194 Temperature_Celsius     0x0022   123   101   000    Old_age   Always
      -       27
196 Reallocated_Event_Count 0x0032   175   175   000    Old_age   Always
      -       25
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always
      -       0
198 Offline_Uncorrectable   0x0012   200   200   000    Old_age   Always
      -       0
199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always
      -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail
Offline      -       0

SMART Error Log Version: 1
ATA Error Count: 246 (device log contains only the most recent five error=
s)
        CR =3D Command Register [HEX]
        FR =3D Features Register [HEX]
        SC =3D Sector Count Register [HEX]
        SN =3D Sector Number Register [HEX]
        CL =3D Cylinder Low Register [HEX]
        CH =3D Cylinder High Register [HEX]
        DH =3D Device/Head Register [HEX]
        DC =3D Device Command Register [HEX]
        ER =3D Error register [HEX]
        ST =3D Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.

Error 246 occurred at disk power-on lifetime: 2573 hours (107 days + 5
hours)
  When the command that caused the error occurred, the device was active
or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 28 15 bd 69 e1  Error: UNC 40 sectors at LBA =3D 0x0169bd15 =3D 2=
3706901

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 28 0f bd 69 01 00  30d+01:23:50.954  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:50.954  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:50.954  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:50.954  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:50.954  READ DMA

Error 245 occurred at disk power-on lifetime: 2573 hours (107 days + 5
hours)
  When the command that caused the error occurred, the device was active
or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 28 15 bd 69 e1  Error: UNC 40 sectors at LBA =3D 0x0169bd15 =3D 2=
3706901

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 28 0f bd 69 01 00  30d+01:23:48.904  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:48.904  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:48.904  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:48.904  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:48.904  READ DMA

Error 244 occurred at disk power-on lifetime: 2573 hours (107 days + 5
hours)
  When the command that caused the error occurred, the device was active
or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 28 15 bd 69 e1  Error: UNC 40 sectors at LBA =3D 0x0169bd15 =3D 2=
3706901

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 28 0f bd 69 01 00  30d+01:23:46.854  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:46.854  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:46.854  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:46.854  READ DMA
  c8 00 30 07 bd 69 01 00  30d+01:23:46.854  READ DMA

Error 243 occurred at disk power-on lifetime: 2573 hours (107 days + 5
hours)
  When the command that caused the error occurred, the device was active
or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 28 15 bd 69 e1  Error: UNC 40 sectors at LBA =3D 0x0169bd15 =3D 2=
3706901

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 28 0f bd 69 01 00  30d+01:23:44.754  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:44.754  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:44.754  READ DMA
  c8 00 30 07 bd 69 01 00  30d+01:23:44.754  READ DMA
  c8 00 30 07 bd 69 01 00  30d+01:23:44.754  READ DMA

Error 242 occurred at disk power-on lifetime: 2573 hours (107 days + 5
hours)
  When the command that caused the error occurred, the device was active
or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 28 15 bd 69 e1  Error: UNC 40 sectors at LBA =3D 0x0169bd15 =3D 2=
3706901

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 28 0f bd 69 01 00  30d+01:23:42.654  READ DMA
  c8 00 28 0f bd 69 01 00  30d+01:23:42.654  READ DMA
  c8 00 30 07 bd 69 01 00  30d+01:23:42.654  READ DMA
  c8 00 30 07 bd 69 01 00  30d+01:23:42.654  READ DMA
  c8 00 30 07 bd 69 01 00  30d+01:23:42.654  READ DMA

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      4865
     -
# 2  Short offline       Completed without error       00%      4841
     -
# 3  Extended offline    Completed without error       00%      4818
     -
# 4  Short offline       Completed without error       00%      4793
     -
# 5  Short offline       Completed without error       00%      4769
     -
# 6  Short offline       Completed without error       00%      4745
     -
# 7  Short offline       Completed without error       00%      4722
     -
# 8  Short offline       Completed without error       00%      4698
     -
# 9  Short offline       Completed: read failure       10%      4687
     254963387
#10  Short offline       Completed without error       00%      4678
     -
#11  Short offline       Completed without error       00%      4654
     -
#12  Extended offline    Completed without error       00%      4532
     -
#13  Short offline       Completed without error       00%      4478
     -
#14  Short offline       Completed without error       00%      4454
     -
#15  Short offline       Completed without error       00%      4430
     -
#16  Extended offline    Completed without error       00%      4408
     -
#17  Short offline       Completed without error       00%      4382
     -
#18  Short offline       Completed without error       00%      4358
     -
#19  Short offline       Completed without error       00%      4338
     -
#20  Short offline       Completed without error       00%      4314
     -
#21  Short offline       Completed without error       00%      4290
     -



--------------enigB1E726F26A1F959EB1A0491B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiISAT+KvsdUW5p8RAu9/AKCV3+9+bLS5tpANxSA02GcZsnE+iQCghFE/
zfak3ilZHG6/N0iG5vSt9Vo=
=87YS
-----END PGP SIGNATURE-----

--------------enigB1E726F26A1F959EB1A0491B--
