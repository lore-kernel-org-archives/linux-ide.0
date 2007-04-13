From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Fri, 13 Apr 2007 21:36:41 +0300 (EEST)
Message-ID: <54785.192.168.9.10.1176489401.squirrel@ncircle.nullnet.fi>
References: <200704091018.l39AI9tg020015@harpo.it.uu.se>
    <38769.194.237.142.7.1176209348.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:39844 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbXDMSgq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 14:36:46 -0400
Received: from ncircle.nullnet.fi (a80-186-77-174.elisa-laajakaista.fi [80.186.77.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 4AA1C41DD5
	for <linux-ide@vger.kernel.org>; Fri, 13 Apr 2007 21:36:43 +0300 (EEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with ESMTP id B7C9D158BF6
	for <linux-ide@vger.kernel.org>; Fri, 13 Apr 2007 21:36:42 +0300 (EEST)
Received: from ncircle.nullnet.fi ([127.0.0.1])
	by localhost (alderan.ncircle.nullnet.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zlL86G3c-O3H for <linux-ide@vger.kernel.org>;
	Fri, 13 Apr 2007 21:36:41 +0300 (EEST)
Received: from ncircle.nullnet.fi (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Fri, 13 Apr 2007 21:36:40 +0300 (EEST)
In-Reply-To: <38769.194.237.142.7.1176209348.squirrel@ncircle.nullnet.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Related to my previous tests, it seems that after I changed the order of the
hard-disks connected to Promise Sata300TX4 the errors followed both of the
7200.10 disks. I swapped the power supply and the SATA-cables at the same
time
and still get the following kind of errors (and only with 7200.10, _never_
with
the older 7200.7 disks):

ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: cmd c8/00:08:77:7a:68/00:00:00:00:00/e7 tag 0 cdb 0x0 data 4096 in
         res 50/00:00:7e:7a:68/00:00:00:00:00/e7 Emask 0x1 (device error)
ata3.00: configured for UDMA/133
ata3: EH complete
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: cmd c8/00:08:57:bb:6a/00:00:00:00:00/e7 tag 0 cdb 0x0 data 4096 in
         res 50/00:00:5e:bb:6a/00:00:00:00:00/e7 Emask 0x1 (device error)
ata3.00: configured for UDMA/133
ata3: EH complete
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata4.00: cmd c8/00:20:2f:86:90/00:00:00:00:00/ea tag 0 cdb 0x0 data 16384 in
         res 50/00:00:4e:86:90/00:00:00:00:00/ea Emask 0x1 (device error)
ata4.00: configured for UDMA/133
ata4: EH complete
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata4.00: cmd c8/00:50:e7:f3:98/00:00:00:00:00/ea tag 0 cdb 0x0 data 40960 in
         res 50/00:00:36:f4:98/00:00:00:00:00/ea Emask 0x1 (device error)
ata4.00: configured for UDMA/133
ata4: EH complete
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata4.00: cmd c8/00:48:57:c8:9e/00:00:00:00:00/ea tag 0 cdb 0x0 data 36864 in
         res 50/00:00:9e:c8:9e/00:00:00:00:00/ea Emask 0x1 (device error)
ata4.00: configured for UDMA/133
ata4: EH complete

The problems seem to be generated from simple ATA-READ commands:
        ATA_CMD_READ            = 0xC8,
        ATA_CMD_READ_EXT     = 0x25,

but I have absolutely no idea what is causing them ... The both disks
have nothing special in their SMART-records:

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED 
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   104   100   006    Pre-fail  Always  
    -       6873586
  3 Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always  
    -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always  
    -       11
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always  
    -       0
  7 Seek_Error_Rate         0x000f   076   061   030    Pre-fail  Always  
    -       44625875
  9 Power_On_Hours          0x0032   099   099   000    Old_age   Always  
    -       1236
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always  
    -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always  
    -       11
187 Unknown_Attribute       0x0032   100   100   000    Old_age   Always  
    -       0
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always  
    -       0
190 Unknown_Attribute       0x0022   063   060   045    Old_age   Always  
    -       639631397
194 Temperature_Celsius     0x0022   037   040   000    Old_age   Always  
    -       37 (Lifetime Min/Max 0/27)
195 Hardware_ECC_Recovered  0x001a   076   054   000    Old_age   Always  
    -       194225
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always  
    -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline 
    -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always  
    -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline 
    -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always  
    -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining 
LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      1181      
  -
# 2  Extended offline    Completed without error       00%       231      
  -


Any good ideas from where to search for the solution to this error messages ?

Regards,
Tomi Orava


> I just ran a test with the 2.6.21-rc6-git1 + your patches below
> and got the following errors (bottom of the mail). Do you have
> any idea what they might be trying to tell ?
>
> My configuration contains Promise Sata300TX4-pci card:
>
> 00:0e.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA
> 300 TX4) (rev 02)
>         Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
>         Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 16
>         I/O ports at ec00 [size=128]
>         I/O ports at e000 [size=256]
>         Memory at fe900000 (32-bit, non-prefetchable) [size=4K]
>         Memory at fe800000 (32-bit, non-prefetchable) [size=128K]
>         Expansion ROM at fe600000 [disabled] [size=32K]
>         Capabilities: [60] Power Management version 2
>
> Asus A7V880 / AMD Athlon XP 2.8MHz
> Antec truepower II 550W power supply
> 2 * Seagate 7200.7 disks 200GB (no errors with these two)
> 2 * Seagate 7200.10 disks 500GB (these ones generate all the errors)
>     (jumpered into 3.0Gbs mode)
>
>
>> I've seen reports of issues like these with second-generation
>> Promise SATA chips and SATAII (3Gbps) drives, but this is the
>> first time I've seen any issues with a first-generation chip.
>>
>> 1. Please try 2.6.21-rc6 plus the following two patches:
>>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21-rc6
>>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21-rc6
>>
>>    This probably won't eliminate the errors, but should improve
>>    the level of detail in the error messages.
>>
>> 2. Try with a better power supply and verify that cooling is OK.
>>    Also verify that the SATA data and power cables are firmly attached.
>>
>>    We've seen several reports of mysterious issues that eventually
>>    were traced to insufficient power supplies or poorly seated
>>    PCI cards (but in your case the chip is integrated on the mobo).
>
> On my system, cooling is OK. The power supply however has been
> changed twice because previous Antec supplies have died under stress :(
>
> Regards,
> Tomi Orava
>
> -----------------------------------------------------------------------
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (port_status 0x20080000)
> ata2.00: cmd c8/00:68:27:ea:7c/00:00:00:00:00/e7 tag 0 cdb 0x0 data 53248
> in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (port_status 0x20080000)
> ata2.00: cmd c8/00:a8:5f:95:87/00:00:00:00:00/e7 tag 0 cdb 0x0 data 86016
> in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (port_status 0x20080000)
> ata2.00: cmd c8/00:00:3f:6f:b3/00:00:00:00:00/e7 tag 0 cdb 0x0 data 131072
> in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ata2.00: limiting speed to UDMA/100:PIO4
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (port_status 0x20080000)
> ata2.00: cmd 25/00:00:2f:2b:b3/00:02:07:00:00/e0 tag 0 cdb 0x0 data 262144
> in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/100
> ata2: EH complete
> SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA


