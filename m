From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [QUESTION] ATA: abnormal status 0x80 on port 0xCC07
Date: Tue, 06 Feb 2007 21:53:01 +0100
Message-ID: <45C8EAAD.5000905@googlemail.com>
References: <6bffcb0e0702031044v601e4fc3icf859544af292789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965457AbXBFUxU@vger.kernel.org>
In-Reply-To: <6bffcb0e0702031044v601e4fc3icf859544af292789@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Michal Piotrowski napisa=C5=82(a):
> Hi Jeff,
>=20
> What does this mean?
>=20
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:08:67:40:68/00:00:00:00:00/e3 tag 0 cdb 0x0 data 4=
096 in
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:00:c3:52:43/00:00:00:00:00/ea tag 0 cdb 0x0 data
> 131072 in
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:00:c3:52:43/00:00:00:00:00/ea tag 0 cdb 0x0 data
> 131072 in
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
> support DPO
> or FUA
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
> support DPO
> or FUA
> ATA: abnormal status 0x80 on port 0xCC07
> ATA: abnormal status 0x80 on port 0xCC07
> ATA: abnormal status 0x80 on port 0xCC07
> ata1.00: limiting speed to UDMA/100
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd ca/00:38:8f:7a:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data
> 28672 out
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/100
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
> support DPO                                             or FUA
> ATA: abnormal status 0x80 on port 0xCC07
> ATA: abnormal status 0x80 on port 0xCC07
> ATA: abnormal status 0x80 on port 0xCC07
> ata1.00: limiting speed to UDMA/66
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd ca/00:40:ab:e2:4a/00:00:00:00:00/ea tag 0 cdb 0x0 data
> 32768 out
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/66
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
> support DPO                                             or FUA
>=20
> Is this a hardware problem?
>=20

CONFIG_ATA=3Dy
CONFIG_ATA_PIIX=3Dy
CONFIG_SATA_INTEL_COMBINED=3Dy

This might be an ata driver problem, 2.6.19-1.2895.fc6 works fine, 2.6.=
20-rc6 was fine.

This was the latest working kernel
=46eb  3 00:53:49 euridica kernel: Linux version 2.6.20-rc7 (michal@eur=
idica.enternet.net.pl) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-51)) =
#27 SMP PREEMPT Thu Feb 1 11:57:34 CET 2007

This was the first bad one
=46eb  3 18:26:07 euridica kernel: Linux version 2.6.20-rc7 (michal@eur=
idica.enternet.net.pl) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-51)) =
#28 SMP PREEMPT Sat Feb 3 02:07:08 CET 2007

I'll revert this patch.

commit 7a0f1c8a4b1052da7efc7715e2e557255b632712
Author: Lennert Buytenhek <buytenh@wantstofly.org>
Date:   Mon Jan 29 13:28:47 2007 +0100

    ata_if_xfermask() word 51 fix

    If word 53 bit 1 isn't set, the maximum PIO mode is indicated by
    the upper 8 bits of word 51, not the lower 8 bits.  Fixes PIO mode
    detection on old Compact Flash cards.

    Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a388a8d..cf70702 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1037,7 +1037,7 @@ static unsigned int ata_id_xfermask(cons
                 * the PIO timing number for the maximum. Turn it into
                 * a mask.
                 */
-               u8 mode =3D id[ATA_ID_OLD_PIO_MODES] & 0xFF;
+               u8 mode =3D (id[ATA_ID_OLD_PIO_MODES] >> 8) & 0xFF;
                if (mode < 5)   /* Valid PIO range */
                        pio_mask =3D (2 << mode) - 1;
                else

There are 55 per cent chances that this is a hardware problem and 45 % =
that this is a software bug.

uptime
 21:36:36 up  4:48,  0 users,  load average: 0.62, 0.71, 0.65

on 2.6.19-1.2895.fc6 without any hdd related problems.

http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc7/messages

sudo /usr/sbin/smartctl -a -d ata /dev/sda
smartctl version 5.36 [i386-redhat-linux-gnu] Copyright (C) 2002-6 Bruc=
e Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     ST3160811AS
Serial Number:    5PT0KRNR
=46irmware Version: 3.AAE
User Capacity:    160,041,885,696 bytes
Device is:        Not in smartctl database [for details use: -P showall=
]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Feb  6 21:50:32 2007 CET
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
Self-test execution status:      (   0) The previous self-test routine =
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
/off support.
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
                                        General Purpose Logging support=
ed.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        (  54) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDAT=
ED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   119   100   006    Pre-fail  Alway=
s       -       231824575
  3 Spin_Up_Time            0x0003   099   096   000    Pre-fail  Alway=
s       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Alway=
s       -       309
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Alway=
s       -       0
  7 Seek_Error_Rate         0x000f   075   060   030    Pre-fail  Alway=
s       -       29962423
  9 Power_On_Hours          0x0032   098   098   000    Old_age   Alway=
s       -       2207
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Alway=
s       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Alway=
s       -       520
187 Unknown_Attribute       0x0032   100   100   000    Old_age   Alway=
s       -       0
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Alway=
s       -       0
190 Unknown_Attribute       0x0022   057   053   045    Old_age   Alway=
s       -       724107307
194 Temperature_Celsius     0x0022   043   047   000    Old_age   Alway=
s       -       43 (Lifetime Min/Max 0/17)
195 Hardware_ECC_Recovered  0x001a   061   043   000    Old_age   Alway=
s       -       190459272
197 Current_Pending_Sector  0x0012   001   001   000    Old_age   Alway=
s       -       4294967294
198 Offline_Uncorrectable   0x0010   001   001   000    Old_age   Offli=
ne      -       4294967294
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Alway=
s       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offli=
ne      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Alway=
s       -       0

SMART Error Log Version: 1
ATA Error Count: 6 (device log contains only the most recent five error=
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

Error 6 occurred at disk power-on lifetime: 2202 hours (91 days + 18 ho=
urs)
  When the command that caused the error occurred, the device was activ=
e or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 bc 0c 02 e0  Error: UNC at LBA =3D 0x00020cbc =3D 134332

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 2f 0c 02 e0 00      00:01:07.193  READ DMA
  ec 03 46 00 00 00 a0 02      00:01:07.192  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      00:01:07.180  SET FEATURES [Set transfer=
 mode]
  ec 00 00 bc 0c 02 a0 02      00:01:05.100  IDENTIFY DEVICE
  c8 00 00 2f 0c 02 e0 00      00:01:05.096  READ DMA

Error 5 occurred at disk power-on lifetime: 2202 hours (91 days + 18 ho=
urs)
  When the command that caused the error occurred, the device was activ=
e or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 bc 0c 02 e0  Error: UNC at LBA =3D 0x00020cbc =3D 134332

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 2f 0c 02 e0 00      00:01:07.193  READ DMA
  ec 03 46 00 00 00 a0 02      00:01:07.192  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      00:01:07.180  SET FEATURES [Set transfer=
 mode]
  ec 00 00 bc 0c 02 a0 02      00:01:05.100  IDENTIFY DEVICE
  c8 00 00 2f 0c 02 e0 00      00:01:05.096  READ DMA

Error 4 occurred at disk power-on lifetime: 2202 hours (91 days + 18 ho=
urs)
  When the command that caused the error occurred, the device was activ=
e or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 bc 0c 02 e0  Error: UNC at LBA =3D 0x00020cbc =3D 134332

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 2f 0c 02 e0 00      00:01:07.193  READ DMA
  ec 03 46 00 00 00 a0 02      00:01:07.192  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      00:01:07.180  SET FEATURES [Set transfer=
 mode]
  ec 00 00 bc 0c 02 a0 02      00:01:05.100  IDENTIFY DEVICE
  c8 00 00 2f 0c 02 e0 00      00:01:05.096  READ DMA

Error 3 occurred at disk power-on lifetime: 2202 hours (91 days + 18 ho=
urs)
  When the command that caused the error occurred, the device was activ=
e or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 bc 0c 02 e0  Error: UNC at LBA =3D 0x00020cbc =3D 134332

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 2f 0c 02 e0 00      00:01:00.301  READ DMA
  ec 03 46 00 00 00 a0 02      00:01:00.299  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      00:01:00.296  SET FEATURES [Set transfer=
 mode]
  ec 00 00 bc 0c 02 a0 02      00:01:05.100  IDENTIFY DEVICE
  c8 00 00 2f 0c 02 e0 00      00:01:05.096  READ DMA

Error 2 occurred at disk power-on lifetime: 2202 hours (91 days + 18 ho=
urs)
  When the command that caused the error occurred, the device was activ=
e or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 bc 0c 02 e0  Error: UNC at LBA =3D 0x00020cbc =3D 134332

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 2f 0c 02 e0 00      00:01:00.301  READ DMA
  ec 03 46 00 00 00 a0 02      00:01:00.299  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      00:01:00.296  SET FEATURES [Set transfer=
 mode]
  ec 00 00 bc 0c 02 a0 02      00:01:00.294  IDENTIFY DEVICE
  c8 00 00 2f 0c 02 e0 00      00:01:00.293  READ DMA

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(ho=
urs)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      2180   =
      -
# 2  Extended offline    Completed without error       00%       390   =
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


Regards,
Michal

--=20
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
