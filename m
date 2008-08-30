From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Subject: Re: Problems with ALPM on devices part of raid array
Date: Sat, 30 Aug 2008 17:33:43 +0300
Message-ID: <48B95A47.8070408@gmail.com>
References: <48B17C20.7020203@gmail.com> <48B926AE.7030108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:11357 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYH3Odw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Aug 2008 10:33:52 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1146715muf.1
        for <linux-ide@vger.kernel.org>; Sat, 30 Aug 2008 07:33:49 -0700 (PDT)
In-Reply-To: <48B926AE.7030108@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, Linux Kernel <linux-kernel@vger.kernel.org>

[Cc-ing linux-kernel since I forgot to do so on my initial report]

On 2008-08-30 13:53, Tejun Heo wrote:
> T=F6r=F6k Edwin wrote:
>  =20
>> I have an AHCI capable chipset now (ICH10), so I tried ALPM[*], by
>> echo-ing min_power to:
>> ./class/scsi_host/host0/link_power_management_policy
>> ./class/scsi_host/host5/link_power_management_policy
>>
>> The 6 SATA2 drives have 3 partitions each, partition 1 is RAID1,
>> partition 3 is RAID10.
>>
>> This soon caused me troubles, as the kernel gave I/O error messages,=
 and
>> unmounted my filesystems running
>> on /dev/md4 (raid10 array). Unfortunately I don't have those message=
s
>> saved to my logs, because my /var filesystem got automatically unmou=
nted.
>> I had no choice but to reboot, and then md kicked 4 drives out of th=
e
>> md4 array (6 total drives), and then refused
>> to assemble (too few drives). The RAID1 array (md3) got reassembled,=
 and
>> resynced successfully.
>> I had to force the assembly of /dev/md4 [and encountered a mdadm bug
>> while doing so: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D4=
96334]
>>
>> I think ALPM should refuse to set link pm if the device is part of a
>> raid array, or the md driver should be aware
>> of ALPM, and wait a little longer for the device to come back online=
=2E
>> Mentioning this problem somewhere in the sources/docs would be nice.
>>    =20
>
> Being part of RAID is very unlikely to have anything to do with the
> failures.  Can you post kernel, boot log, error messages and the
> output of hdparm -I on array members?

Hi Tejun,

I have found a (safe) way to reproduce this problem, without loosing da=
ta.
What I found is that setting the link_power_management_policy to=20
min_power is completely harmless, and works,
however setting it *back* to max_performance causes an ATA link hard=20
reset, and drives kicked out of RAID array.

=46or my RAID1 array this is not a big problem, since its resynced fast=
,=20
and I can hot-remove/add drives,
however with RAID10 (last time, I didn't try again) I needed to use=20
mdadm --assemble --force, and a full resync
(which takes hours).

I am using this Debian kernel: Linux debian 2.6.26-1-amd64 #1 SMP Thu=20
Aug 28 11:13:42 UTC 2008 x86_64 GNU/Linux
You can find .config at end of this mail

The steps are these:
- unmount /var, /usr/, /home, take my raid10 array offline
- now I only have /dev/md3 which is a RAID1 array of 6 drives mounted o=
n /
1. set all my drives to min_power:
# for i in /sys/class/scsi_host/*/link_power_management_policy; echo=20
min_power >$i; done

2. check that it worked, do a sync:
# sync

3. now set one of the drives back to max_performance (the drive will ge=
t=20
an ATA hard reset,
if I change the link pm policy for all drives, then all drives are=20
affected, you can see in the dmesg at the end of this mail, I tried bot=
h)

# echo max_performance=20
 >/sys/class/scsi_host/host0/link_power_management_policy

4. sync again, this time ATA reset messages appear on the console
# sync

[ 2304.355772] ata6.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.355772] ata4.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.355772] ata4.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.355772] ata4: SError: { PHYRdyChg CommWake }
[ 2304.355772] ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.355772]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.355772] ata4.00: status: { DRDY }
[ 2304.355772] ata4: hard resetting link
[ 2304.896743] ata5.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.896743] ata5.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.896743] ata5: SError: { PHYRdyChg CommWake }
[ 2304.896743] ata5.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.896743]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.896743] ata5.00: status: { DRDY }
[ 2304.896743] ata5: hard resetting link
[ 2304.896743] ata6.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.896789] ata6: SError: { PHYRdyChg CommWake }
[ 2304.896835] ata6.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.896836]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.896939] ata6.00: status: { DRDY }
[ 2304.896984] ata6: hard resetting link
[ 2304.897035] ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.897093] ata3.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.897138] ata3: SError: { PHYRdyChg CommWake }
[ 2304.897184] ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.897185]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.897288] ata3.00: status: { DRDY }
[ 2304.897332] ata3: hard resetting link
[ 2304.897381] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.897439] ata2.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.897485] ata2: SError: { PHYRdyChg CommWake }
[ 2304.897530] ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.897531]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.897634] ata2.00: status: { DRDY }
[ 2304.897679] ata2: hard resetting link
[ 2305.832653] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.832656] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.837489] ata4.00: configured for UDMA/133
[ 2305.837489] ata4: EH complete
[ 2305.837489] ata5.00: configured for UDMA/133
[ 2305.837489] sd 3:0:0:0: [sdd] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.837489] sd 3:0:0:0: [sdd] Write Protect is off
[ 2305.837489] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2305.837489] sd 3:0:0:0: [sdd] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.837489] ata5: EH complete
[ 2305.837489] sd 4:0:0:0: [sde] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.837489] sd 4:0:0:0: [sde] Write Protect is off
[ 2305.837489] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2305.837489] sd 4:0:0:0: [sde] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.841497] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.841556] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.841615] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.841615] ata3.00: configured for UDMA/133
[ 2305.841615] ata3: EH complete
[ 2305.841615] ata2.00: configured for UDMA/133
[ 2305.841615] sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.841615] sd 2:0:0:0: [sdc] Write Protect is off
[ 2305.841615] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2305.841615] sd 2:0:0:0: [sdc] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.845240] ata6.00: configured for UDMA/133
[ 2305.845240] ata6: EH complete
[ 2305.841615] ata2: EH complete
[ 2305.841615] sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.841615] sd 1:0:0:0: [sdb] Write Protect is off
[ 2305.841615] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2305.841615] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.841694] sd 5:0:0:0: [sdf] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.845240] sd 5:0:0:0: [sdf] Write Protect is off
[ 2305.845284] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2305.845299] sd 5:0:0:0: [sdf] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.852738] end_request: I/O error, dev sdd, sector 19534911
[ 2305.852738] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.852738] raid1: Disk failure on sdd1, disabling device.
[ 2305.852738] raid1: Operation continuing on 5 devices.
[ 2305.852738] end_request: I/O error, dev sdf, sector 19534911
[ 2305.852738] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.852738] raid1: Disk failure on sdf1, disabling device.
[ 2305.852738] raid1: Operation continuing on 4 devices.
[ 2305.853240] end_request: I/O error, dev sdc, sector 19534911
[ 2305.853240] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.853240] raid1: Disk failure on sdc1, disabling device.
[ 2305.853240] raid1: Operation continuing on 3 devices.
[ 2305.841615] end_request: I/O error, dev sde, sector 19534911
[ 2305.841615] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.841615] raid1: Disk failure on sde1, disabling device.
[ 2305.841615] raid1: Operation continuing on 2 devices.
[ 2305.857144] end_request: I/O error, dev sdb, sector 19534911
[ 2305.857144] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.857144] raid1: Disk failure on sdb1, disabling device.
[ 2305.857144] raid1: Operation continuing on 1 devices.
[ 2305.872898] RAID1 conf printout:
[ 2305.872898]  --- wd:1 rd:6
[ 2305.872898]  disk 0, wo:0, o:1, dev:sda1
[ 2305.872898]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.872898]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.872898]  disk 3, wo:1, o:0, dev:sde1
[ 2305.872898]  disk 4, wo:1, o:0, dev:sdc1
[ 2305.872898]  disk 5, wo:1, o:0, dev:sdf1
[ 2305.881242] RAID1 conf printout:
[ 2305.881286]  --- wd:1 rd:6
[ 2305.881330]  disk 0, wo:0, o:1, dev:sda1
[ 2305.881379]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.881423]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.881466]  disk 3, wo:1, o:0, dev:sde1
[ 2305.881510]  disk 4, wo:1, o:0, dev:sdc1
[ 2305.881557] RAID1 conf printout:
[ 2305.881599]  --- wd:1 rd:6
[ 2305.881641]  disk 0, wo:0, o:1, dev:sda1
[ 2305.881684]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.881728]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.881772]  disk 3, wo:1, o:0, dev:sde1
[ 2305.881815]  disk 4, wo:1, o:0, dev:sdc1
[ 2305.893241] RAID1 conf printout:
[ 2305.893285]  --- wd:1 rd:6
[ 2305.893328]  disk 0, wo:0, o:1, dev:sda1
[ 2305.893376]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.893418]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.893462]  disk 3, wo:1, o:0, dev:sde1
[ 2305.893506] RAID1 conf printout:
[ 2305.893548]  --- wd:1 rd:6
[ 2305.893589]  disk 0, wo:0, o:1, dev:sda1
[ 2305.893633]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.893676]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.893719]  disk 3, wo:1, o:0, dev:sde1
[ 2305.905242] RAID1 conf printout:
[ 2305.905285]  --- wd:1 rd:6
[ 2305.905329]  disk 0, wo:0, o:1, dev:sda1
[ 2305.905376]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.905418]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.905463] RAID1 conf printout:
[ 2305.905505]  --- wd:1 rd:6
[ 2305.905546]  disk 0, wo:0, o:1, dev:sda1
[ 2305.905590]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.905633]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.917241] RAID1 conf printout:
[ 2305.917284]  --- wd:1 rd:6
[ 2305.917328]  disk 0, wo:0, o:1, dev:sda1
[ 2305.917374]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.917417] RAID1 conf printout:
[ 2305.917460]  --- wd:1 rd:6
[ 2305.917501]  disk 0, wo:0, o:1, dev:sda1
[ 2305.917544]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.929241] RAID1 conf printout:
[ 2305.929284]  --- wd:1 rd:6
[ 2305.929328]  disk 0, wo:0, o:1, dev:sda1

5. The drives are working, they just got kicked out of the array, so=20
lets add them back
mdadm --remove /dev/md3 /dev/sdc1 /dev/sdf1 /dev/sde1 /dev/sdd1 /dev/sd=
b1
mdadm --add /dev/md3 /dev/sdc1 /dev/sdf1 /dev/sde1 /dev/sdd1 /dev/sdb1
dmesg output for this is:
[ 2505.989204] md: md3 still in use.
[ 2521.148651] md: unbind<sdc1>
[ 2521.148651] md: export_rdev(sdc1)
[ 2537.045017] md: unbind<sdf1>
[ 2537.045017] md: export_rdev(sdf1)
[ 2537.070370] md: unbind<sde1>
[ 2537.070370] md: export_rdev(sde1)
[ 2537.812473] md: unbind<sdd1>
[ 2537.812524] md: export_rdev(sdd1)
[ 2537.822335] md: unbind<sdb1>
[ 2537.822335] md: export_rdev(sdb1)
[ 2565.680914] md: bind<sdf1>
[ 2565.722761] RAID1 conf printout:
[ 2565.722761]  --- wd:1 rd:6
[ 2565.722761]  disk 0, wo:0, o:1, dev:sda1
[ 2565.722761]  disk 1, wo:1, o:1, dev:sdf1
[ 2565.724253] md: recovery of RAID array md3
[ 2565.724253] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[ 2565.724253] md: using maximum available idle IO bandwidth (but not=20
more than 200000 KB/sec) for recovery.
[ 2565.724253] md: using 128k window, over a total of 9767424 blocks.
[ 2565.876674] md: bind<sde1>
[ 2565.995415] md: bind<sdd1>
[ 2566.057634] md: bind<sdb1>
[ 2566.101549] md: bind<sdc1>
[ 2782.657615] md: md3: recovery done.
[ 2783.368035] RAID1 conf printout:
[ 2783.368035]  --- wd:2 rd:6
[ 2783.368035]  disk 0, wo:0, o:1, dev:sda1
[ 2783.368035]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.555376] RAID1 conf printout:
[ 2783.555423]  --- wd:2 rd:6
[ 2783.555467]  disk 0, wo:0, o:1, dev:sda1
[ 2783.555533]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.555576]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.555625] RAID1 conf printout:
[ 2783.555667]  --- wd:2 rd:6
[ 2783.555708]  disk 0, wo:0, o:1, dev:sda1
[ 2783.555751]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.555794]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.555837]  disk 3, wo:1, o:1, dev:sdb1
[ 2783.555882] RAID1 conf printout:
[ 2783.555924]  --- wd:2 rd:6
[ 2783.555966]  disk 0, wo:0, o:1, dev:sda1
[ 2783.559532]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.559532]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.559532]  disk 3, wo:1, o:1, dev:sdb1
[ 2783.559532]  disk 4, wo:1, o:1, dev:sdd1
[ 2783.559532] RAID1 conf printout:
[ 2783.559532]  --- wd:2 rd:6
[ 2783.559532]  disk 0, wo:0, o:1, dev:sda1
[ 2783.559532]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.559532]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.559532]  disk 3, wo:1, o:1, dev:sdb1
[ 2783.559532]  disk 4, wo:1, o:1, dev:sdd1
[ 2783.559532]  disk 5, wo:1, o:1, dev:sde1
[ 2783.559532] md: recovery of RAID array md3
[ 2783.559532] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[ 2783.559532] md: using maximum available idle IO bandwidth (but not=20
more than 200000 KB/sec) for recovery.
[ 2783.559532] md: using 128k window, over a total of 9767424 blocks.

If I repeat  steps 1-4 again, I get ATA errors again, and drives kicked=
 out.

Best regards,
--Edwin

The output of hdparm -I /dev/sd[a-z] is:

/dev/sda:

ATA device, with non-removable media
    Model Number:       WDC WD7501AALS-00J7B0                 =20
    Serial Number:      WD-WMATV0086271
    Firmware Revision:  05.00K05
    Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev=
 2.5
Standards:
    Supported: 8 7 6 5
    Likely used: 8
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  268435455
    LBA48  user addressable sectors: 1465149168
    device size with M =3D 1024*1024:      715404 MBytes
    device size with M =3D 1000*1000:      750156 MBytes (750 GB)
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, with device specific mini=
mum
    R/W multiple sector transfer: Max =3D 16    Current =3D 0
    Recommended acoustic management value: 128, current value: 254
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=3D120ns recommended=3D120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    Host Protected Area feature set
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    NOP cmd
       *    DOWNLOAD_MICROCODE
            Power-Up In Standby feature set
       *    SET_FEATURES required to spinup after power up
            SET_MAX security extension
            Automatic Acoustic Management feature set
       *    48-bit Address feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    SMART self-test
       *    General Purpose Logging feature set
       *    64-bit World wide name
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
       *    SATA-I signaling speed (1.5Gb/s)
       *    SATA-II signaling speed (3.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Host-initiated interface power management
       *    Phy event counters
            DMA Setup Auto-Activate optimization
       *    Software settings preservation
       *    SMART Command Transport (SCT) feature set
       *    SCT Long Sector Access (AC1)
       *    SCT LBA Segment Access (AC2)
       *    SCT Error Recovery Control (AC3)
       *    SCT Features Control (AC4)
       *    SCT Data Tables (AC5)
            unknown 206[12] (vendor specific)
            unknown 206[13] (vendor specific)
Security:
    Master password revision code =3D 65534
        supported
    not    enabled
    not    locked
    not    frozen
    not    expired: security count
        supported: enhanced erase
    162min for SECURITY ERASE UNIT. 162min for ENHANCED SECURITY ERASE =
UNIT.
Logical Unit WWN Device Identifier: 50014ee0b6d6c1
    NAA        : 5
    IEEE OUI    : 14ee
    Unique ID    : 0b6d6c1
Checksum: correct

/dev/sdb:

ATA device, with non-removable media
    Model Number:       WDC WD7501AALS-00J7B0                 =20
    Serial Number:      WD-WMATV0083946
    Firmware Revision:  05.00K05
    Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev=
 2.5
Standards:
    Supported: 8 7 6 5
    Likely used: 8
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  268435455
    LBA48  user addressable sectors: 1465149168
    device size with M =3D 1024*1024:      715404 MBytes
    device size with M =3D 1000*1000:      750156 MBytes (750 GB)
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, with device specific mini=
mum
    R/W multiple sector transfer: Max =3D 16    Current =3D 0
    Recommended acoustic management value: 128, current value: 254
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=3D120ns recommended=3D120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    Host Protected Area feature set
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    NOP cmd
       *    DOWNLOAD_MICROCODE
            Power-Up In Standby feature set
       *    SET_FEATURES required to spinup after power up
            SET_MAX security extension
            Automatic Acoustic Management feature set
       *    48-bit Address feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    SMART self-test
       *    General Purpose Logging feature set
       *    64-bit World wide name
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
       *    SATA-I signaling speed (1.5Gb/s)
       *    SATA-II signaling speed (3.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Host-initiated interface power management
       *    Phy event counters
            DMA Setup Auto-Activate optimization
       *    Software settings preservation
       *    SMART Command Transport (SCT) feature set
       *    SCT Long Sector Access (AC1)
       *    SCT LBA Segment Access (AC2)
       *    SCT Error Recovery Control (AC3)
       *    SCT Features Control (AC4)
       *    SCT Data Tables (AC5)
            unknown 206[12] (vendor specific)
            unknown 206[13] (vendor specific)
Security:
    Master password revision code =3D 65534
        supported
    not    enabled
    not    locked
    not    frozen
    not    expired: security count
        supported: enhanced erase
    162min for SECURITY ERASE UNIT. 162min for ENHANCED SECURITY ERASE =
UNIT.
Logical Unit WWN Device Identifier: 50014ee0b48ba2
    NAA        : 5
    IEEE OUI    : 14ee
    Unique ID    : 0b48ba2
Checksum: correct

/dev/sdc:

ATA device, with non-removable media
    Model Number:       WDC WD7501AALS-00J7B0                 =20
    Serial Number:      WD-WMATV0156388
    Firmware Revision:  05.00K05
    Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev=
 2.5
Standards:
    Supported: 8 7 6 5
    Likely used: 8
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  268435455
    LBA48  user addressable sectors: 1465149168
    device size with M =3D 1024*1024:      715404 MBytes
    device size with M =3D 1000*1000:      750156 MBytes (750 GB)
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, with device specific mini=
mum
    R/W multiple sector transfer: Max =3D 16    Current =3D 0
    Recommended acoustic management value: 128, current value: 254
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=3D120ns recommended=3D120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    Host Protected Area feature set
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    NOP cmd
       *    DOWNLOAD_MICROCODE
            Power-Up In Standby feature set
       *    SET_FEATURES required to spinup after power up
            SET_MAX security extension
            Automatic Acoustic Management feature set
       *    48-bit Address feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    SMART self-test
       *    General Purpose Logging feature set
       *    64-bit World wide name
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
       *    SATA-I signaling speed (1.5Gb/s)
       *    SATA-II signaling speed (3.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Host-initiated interface power management
       *    Phy event counters
            DMA Setup Auto-Activate optimization
       *    Software settings preservation
       *    SMART Command Transport (SCT) feature set
       *    SCT Long Sector Access (AC1)
       *    SCT LBA Segment Access (AC2)
       *    SCT Error Recovery Control (AC3)
       *    SCT Features Control (AC4)
       *    SCT Data Tables (AC5)
            unknown 206[12] (vendor specific)
            unknown 206[13] (vendor specific)
Security:
    Master password revision code =3D 65534
        supported
    not    enabled
    not    locked
    not    frozen
    not    expired: security count
        supported: enhanced erase
    162min for SECURITY ERASE UNIT. 162min for ENHANCED SECURITY ERASE =
UNIT.
Logical Unit WWN Device Identifier: 50014ee0560c33e7
    NAA        : 5
    IEEE OUI    : 14ee
    Unique ID    : 0560c33e7
Checksum: correct

/dev/sdd:

ATA device, with non-removable media
    Model Number:       WDC WD7501AALS-00J7B0                 =20
    Serial Number:      WD-WMATV0005417
    Firmware Revision:  05.00K05
    Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev=
 2.5
Standards:
    Supported: 8 7 6 5
    Likely used: 8
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  268435455
    LBA48  user addressable sectors: 1465149168
    device size with M =3D 1024*1024:      715404 MBytes
    device size with M =3D 1000*1000:      750156 MBytes (750 GB)
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, with device specific mini=
mum
    R/W multiple sector transfer: Max =3D 16    Current =3D 0
    Recommended acoustic management value: 128, current value: 254
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=3D120ns recommended=3D120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    Host Protected Area feature set
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    NOP cmd
       *    DOWNLOAD_MICROCODE
            Power-Up In Standby feature set
       *    SET_FEATURES required to spinup after power up
            SET_MAX security extension
            Automatic Acoustic Management feature set
       *    48-bit Address feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    SMART self-test
       *    General Purpose Logging feature set
       *    64-bit World wide name
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
       *    SATA-I signaling speed (1.5Gb/s)
       *    SATA-II signaling speed (3.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Host-initiated interface power management
       *    Phy event counters
            DMA Setup Auto-Activate optimization
       *    Software settings preservation
       *    SMART Command Transport (SCT) feature set
       *    SCT Long Sector Access (AC1)
       *    SCT LBA Segment Access (AC2)
       *    SCT Error Recovery Control (AC3)
       *    SCT Features Control (AC4)
       *    SCT Data Tables (AC5)
            unknown 206[12] (vendor specific)
            unknown 206[13] (vendor specific)
Security:
    Master password revision code =3D 65534
        supported
    not    enabled
    not    locked
    not    frozen
    not    expired: security count
        supported: enhanced erase
    194min for SECURITY ERASE UNIT. 194min for ENHANCED SECURITY ERASE =
UNIT.
Logical Unit WWN Device Identifier: 50014ee0b7229d
    NAA        : 5
    IEEE OUI    : 14ee
    Unique ID    : 0b7229d
Checksum: correct

/dev/sde:

ATA device, with non-removable media
    Model Number:       WDC WD7501AALS-00J7B0                 =20
    Serial Number:      WD-WMATV0053076
    Firmware Revision:  05.00K05
    Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev=
 2.5
Standards:
    Supported: 8 7 6 5
    Likely used: 8
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  268435455
    LBA48  user addressable sectors: 1465149168
    device size with M =3D 1024*1024:      715404 MBytes
    device size with M =3D 1000*1000:      750156 MBytes (750 GB)
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, with device specific mini=
mum
    R/W multiple sector transfer: Max =3D 16    Current =3D 0
    Recommended acoustic management value: 128, current value: 254
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=3D120ns recommended=3D120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    Host Protected Area feature set
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    NOP cmd
       *    DOWNLOAD_MICROCODE
            Power-Up In Standby feature set
       *    SET_FEATURES required to spinup after power up
            SET_MAX security extension
            Automatic Acoustic Management feature set
       *    48-bit Address feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    SMART self-test
       *    General Purpose Logging feature set
       *    64-bit World wide name
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
       *    SATA-I signaling speed (1.5Gb/s)
       *    SATA-II signaling speed (3.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Host-initiated interface power management
       *    Phy event counters
            DMA Setup Auto-Activate optimization
       *    Software settings preservation
       *    SMART Command Transport (SCT) feature set
       *    SCT Long Sector Access (AC1)
       *    SCT LBA Segment Access (AC2)
       *    SCT Error Recovery Control (AC3)
       *    SCT Features Control (AC4)
       *    SCT Data Tables (AC5)
            unknown 206[12] (vendor specific)
            unknown 206[13] (vendor specific)
Security:
    Master password revision code =3D 65534
        supported
    not    enabled
    not    locked
    not    frozen
    not    expired: security count
        supported: enhanced erase
    162min for SECURITY ERASE UNIT. 162min for ENHANCED SECURITY ERASE =
UNIT.
Logical Unit WWN Device Identifier: 50014ee0b6d521
    NAA        : 5
    IEEE OUI    : 14ee
    Unique ID    : 0b6d521
Checksum: correct

/dev/sdf:

ATA device, with non-removable media
    Model Number:       WDC WD7501AALS-00J7B0                 =20
    Serial Number:      WD-WMATV0038929
    Firmware Revision:  05.00K05
    Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev=
 2.5
Standards:
    Supported: 8 7 6 5
    Likely used: 8
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  268435455
    LBA48  user addressable sectors: 1465149168
    device size with M =3D 1024*1024:      715404 MBytes
    device size with M =3D 1000*1000:      750156 MBytes (750 GB)
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, with device specific mini=
mum
    R/W multiple sector transfer: Max =3D 16    Current =3D 0
    Recommended acoustic management value: 128, current value: 254
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=3D120ns recommended=3D120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    Host Protected Area feature set
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    NOP cmd
       *    DOWNLOAD_MICROCODE
            Power-Up In Standby feature set
       *    SET_FEATURES required to spinup after power up
            SET_MAX security extension
            Automatic Acoustic Management feature set
       *    48-bit Address feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    SMART self-test
       *    General Purpose Logging feature set
       *    64-bit World wide name
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
       *    SATA-I signaling speed (1.5Gb/s)
       *    SATA-II signaling speed (3.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Host-initiated interface power management
       *    Phy event counters
            DMA Setup Auto-Activate optimization
       *    Software settings preservation
       *    SMART Command Transport (SCT) feature set
       *    SCT Long Sector Access (AC1)
       *    SCT LBA Segment Access (AC2)
       *    SCT Error Recovery Control (AC3)
       *    SCT Features Control (AC4)
       *    SCT Data Tables (AC5)
            unknown 206[12] (vendor specific)
            unknown 206[13] (vendor specific)
Security:
    Master password revision code =3D 65534
        supported
    not    enabled
    not    locked
    not    frozen
    not    expired: security count
        supported: enhanced erase
    162min for SECURITY ERASE UNIT. 162min for ENHANCED SECURITY ERASE =
UNIT.
Logical Unit WWN Device Identifier: 50014ee0ab55b53
    NAA        : 5
    IEEE OUI    : 14ee
    Unique ID    : 0ab550b53
Checksum: correct

The output of dmesg:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-1-amd64 (Debian 2.6.26-4)=20
(waldi@debian.org) (gcc version 4.1.3 20080623 (prerelease) (Debian=20
4.1.2-23)) #1 SMP Thu Aug 28 11:13:42 UTC 2008
[    0.000000] Command line: root=3D/dev/md3 ro single
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfee0000 (usable)
[    0.000000]  BIOS-e820: 00000000cfee0000 - 00000000cfee3000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 00000000cfee3000 - 00000000cfef0000 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 00000000cfef0000 - 00000000cff00000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000e4000000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] Entering add_active_range(0, 0, 158) 0 entries of 3200 u=
sed
[    0.000000] Entering add_active_range(0, 256, 851680) 1 entries of=20
3200 used
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries=
=20
of 3200 used
[    0.000000] max_pfn_mapped =3D 1245184
[    0.000000] init_memory_mapping
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP 000F7050, 0014 (r0 GBT   )
[    0.000000] ACPI: RSDT CFEE3040, 0038 (r1 GBT    GBTUACPI 42302E31=20
GBTU  1010101)
[    0.000000] ACPI: FACP CFEE30C0, 0074 (r1 GBT    GBTUACPI 42302E31=20
GBTU  1010101)
[    0.000000] ACPI: DSDT CFEE3180, 4C26 (r1 GBT    GBTUACPI     1000=20
MSFT  100000C)
[    0.000000] ACPI: FACS CFEE0000, 0040
[    0.000000] ACPI: HPET CFEE7F00, 0038 (r1 GBT    GBTUACPI 42302E31=20
GBTU       98)
[    0.000000] ACPI: MCFG CFEE7F80, 003C (r1 GBT    GBTUACPI 42302E31=20
GBTU  1010101)
[    0.000000] ACPI: APIC CFEE7E00, 0084 (r1 GBT    GBTUACPI 42302E31=20
GBTU  1010101)
[    0.000000] ACPI: SSDT CFEE88E0, 03AB (r1  PmRef    CpuPm     3000=20
INTL 20040311)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000130000000
[    0.000000] Entering add_active_range(0, 0, 158) 0 entries of 3200 u=
sed
[    0.000000] Entering add_active_range(0, 256, 851680) 1 entries of=20
3200 used
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries=
=20
of 3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-0000000130000000
[    0.000000]   NODE_DATA [000000000000e000 - 0000000000012fff]
[    0.000000]   bootmap [0000000000013000 -  0000000000038fff] pages 2=
6
[    0.000000]   early res: 0 [0-fff] BIOS data page
[    0.000000]   early res: 1 [6000-7fff] TRAMPOLINE
[    0.000000]   early res: 2 [200000-673397] TEXT DATA BSS
[    0.000000]   early res: 3 [37817000-37fef99f] RAMDISK
[    0.000000]   early res: 4 [9e800-fffff] BIOS reserved
[    0.000000]   early res: 5 [8000-dfff] PGTABLE
[    0.000000]  [ffffe20000000000-ffffe20002dfffff] PMD ->=20
[ffff810001200000-ffff810003ffffff] on node 0
[    0.000000]  [ffffe20003800000-ffffe200043fffff] PMD ->=20
[ffff81000c000000-ffff81000cbfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1245184
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      158
[    0.000000]     0:      256 ->   851680
[    0.000000]     0:  1048576 ->  1245184
[    0.000000] On node 0 totalpages: 1048190
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1247 pages reserved
[    0.000000]   DMA zone: 2695 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 833304 pages, LIFO batch:31
[    0.000000]   Normal zone: 2688 pages used for memmap
[    0.000000]   Normal zone: 193920 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI=
 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] PM: Registered nosave memory: 000000000009e000 -=20
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 -=20
00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 -=20
0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000cfee0000 -=20
00000000cfee3000
[    0.000000] PM: Registered nosave memory: 00000000cfee3000 -=20
00000000cfef0000
[    0.000000] PM: Registered nosave memory: 00000000cfef0000 -=20
00000000cff00000
[    0.000000] PM: Registered nosave memory: 00000000cff00000 -=20
00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 -=20
00000000e4000000
[    0.000000] PM: Registered nosave memory: 00000000e4000000 -=20
00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 -=20
0000000100000000
[    0.000000] Allocating PCI resources starting at e6000000 (gap:=20
e4000000:1ac00000)
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 37168 bytes of per cpu data
[    0.000000] NR_CPUS: 32, nr_cpu_ids: 4
[    0.000000] Built 1 zonelists in Node order, mobility grouping on. =20
Total pages: 1029919
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=3D/dev/md3 ro single
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[    0.000000] time.c: Detected 2833.023 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA - bai=
ling!
[    0.004000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
[    0.004000] Placing software IO TLB between 0x4000000 - 0x8000000
[    0.004000] Memory: 4054384k/4980736k available (2225k kernel code,=20
138376k reserved, 1080k data, 392k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.004000] hpet clockevent registered
[    0.083898] Calibrating delay using timer specific routine.. 5669.97=
=20
BogoMIPS (lpj=3D11339942)
[    0.084005] Security Framework initialized
[    0.084005] SELinux:  Disabled at boot.
[    0.084005] Capability LSM initialized
[    0.084005] Dentry cache hash table entries: 524288 (order: 10,=20
4194304 bytes)
[    0.084005] Inode-cache hash table entries: 262144 (order: 9, 209715=
2=20
bytes)
[    0.084005] Mount-cache hash table entries: 256
[    0.084005] Initializing cgroup subsys ns
[    0.084005] Initializing cgroup subsys cpuacct
[    0.084005] Initializing cgroup subsys devices
[    0.084005] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.084005] CPU: L2 cache: 6144K
[    0.084005] CPU 0/0 -> Node 0
[    0.084005] CPU: Physical Processor ID: 0
[    0.084005] CPU: Processor Core ID: 0
[    0.084005] CPU0: Thermal monitoring enabled (TM2)
[    0.084005] using mwait in idle threads.
[    0.084804] ACPI: Core revision 20080321
[    0.132312] CPU0: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz=20
stepping 07
[    0.132412] Using local APIC timer interrupts.
[    0.140008] APIC timer calibration result 20831070
[    0.140008] Detected 20.831 MHz APIC timer.
[    0.140008] Booting processor 1/1 ip 6000
[    0.148009] Initializing CPU#1
[    0.148009] Calibrating delay using timer specific routine.. 5666.08=
=20
BogoMIPS (lpj=3D11332171)
[    0.148009] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.148009] CPU: L2 cache: 6144K
[    0.148009] CPU 1/1 -> Node 0
[    0.148009] CPU: Physical Processor ID: 0
[    0.148009] CPU: Processor Core ID: 1
[    0.148009] CPU1: Thermal monitoring enabled (TM2)
[    0.228014] CPU1: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz=20
stepping 07
[    0.228014] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.232014] Booting processor 2/3 ip 6000
[    0.240015] Initializing CPU#2
[    0.240015] Calibrating delay using timer specific routine.. 5666.11=
=20
BogoMIPS (lpj=3D11332223)
[    0.240015] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.240015] CPU: L2 cache: 6144K
[    0.240015] CPU 2/3 -> Node 0
[    0.240015] CPU: Physical Processor ID: 0
[    0.240015] CPU: Processor Core ID: 3
[    0.240015] CPU2: Thermal monitoring enabled (TM2)
[    0.323252] CPU2: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz=20
stepping 07
[    0.323693] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.328020] Booting processor 3/2 ip 6000
[    0.339678] Initializing CPU#3
[    0.339678] Calibrating delay using timer specific routine.. 5666.11=
=20
BogoMIPS (lpj=3D11332220)
[    0.339678] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.339678] CPU: L2 cache: 6144K
[    0.339678] CPU 3/2 -> Node 0
[    0.339678] CPU: Physical Processor ID: 0
[    0.339678] CPU: Processor Core ID: 2
[    0.339678] CPU3: Thermal monitoring enabled (TM2)
[    0.420332] CPU3: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz=20
stepping 07
[    0.420773] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.425001] Brought up 4 CPUs
[    0.425001] Total of 4 processors activated (22668.27 BogoMIPS).
[    0.425001] CPU0 attaching sched-domain:
[    0.425001]  domain 0: span 0-1
[    0.425001]   groups: 0 1
[    0.425001]   domain 1: span 0-3
[    0.425001]    groups: 0-1 2-3
[    0.425001]    domain 2: span 0-3
[    0.425001]     groups: 0-3
[    0.425001] CPU1 attaching sched-domain:
[    0.425001]  domain 0: span 0-1
[    0.425001]   groups: 1 0
[    0.425001]   domain 1: span 0-3
[    0.425001]    groups: 0-1 2-3
[    0.425001]    domain 2: span 0-3
[    0.425001]     groups: 0-3
[    0.425001] CPU2 attaching sched-domain:
[    0.425001]  domain 0: span 2-3
[    0.425001]   groups: 2 3
[    0.425001]   domain 1: span 0-3
[    0.425001]    groups: 2-3 0-1
[    0.425001]    domain 2: span 0-3
[    0.425001]     groups: 0-3
[    0.425001] CPU3 attaching sched-domain:
[    0.425001]  domain 0: span 2-3
[    0.425001]   groups: 3 2
[    0.425001]   domain 1: span 0-3
[    0.425001]    groups: 2-3 0-1
[    0.425001]    domain 2: span 0-3
[    0.425001]     groups: 0-3
[    0.425001] net_namespace: 1224 bytes
[    0.425001] Booting paravirtualized kernel on bare hardware
[    0.425001] NET: Registered protocol family 16
[    0.425001] ACPI: bus type pci registered
[    0.425001] PCI: MCFG configuration 0: base e0000000 segment 0 buses=
=20
0 - 63
[    0.425001] PCI: MCFG area at e0000000 reserved in E820
[    0.428768] PCI: Using MMCONFIG at e0000000 - e3ffffff
[    0.428811] PCI: Using configuration type 1 for base access
[    0.430039] ACPI: EC: Look up EC in DSDT
[    0.435168] ACPI: Interpreter enabled
[    0.435218] ACPI: (supports S0 S3 S4 S5)
[    0.435374] ACPI: Using IOAPIC for interrupt routing
[    0.442100] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.442100] PCI: Transparent bridge - 0000:00:1e.0
[    0.442100] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.442100] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.442100] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[    0.442100] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[    0.442100] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[    0.442100] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
[    0.442100] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[    0.458101] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11=20
12 *14 15)
[    0.458101] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11=
=20
12 14 15)
[    0.458101] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11=
=20
12 14 15)
[    0.458101] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11=20
12 14 *15)
[    0.458569] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11=20
12 14 15) *0, disabled.
[    0.459086] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11=
=20
12 14 15)
[    0.464934] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 6 7 9 10 11=
=20
12 14 15)
[    0.465397] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 *7 9 10 11=
=20
12 14 15)
[    0.471466] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.471466] pnp: PnP ACPI init
[    0.471466] ACPI: bus type pnp registered
[    0.471466] pnp 00:00: parse allocated resources
[    0.471466] pnp 00:00:   add io  0xcf8-0xcff flags 0x1
[    0.471466] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (activ=
e)
[    0.471601] pnp 00:01: parse allocated resources
[    0.471606] pnp 00:01:   add io  0x10-0x1f flags 0x1
[    0.471607] pnp 00:01:   add io  0x22-0x3f flags 0x1
[    0.471608] pnp 00:01:   add io  0x44-0x5f flags 0x1
[    0.471610] pnp 00:01:   add io  0x62-0x63 flags 0x1
[    0.471611] pnp 00:01:   add io  0x65-0x6f flags 0x1
[    0.471612] pnp 00:01:   add io  0x74-0x7f flags 0x1
[    0.471613] pnp 00:01:   add io  0x91-0x93 flags 0x1
[    0.471615] pnp 00:01:   add io  0xa2-0xbf flags 0x1
[    0.471616] pnp 00:01:   add io  0xe0-0xef flags 0x1
[    0.471617] pnp 00:01:   add io  0x4d0-0x4d1 flags 0x1
[    0.471618] pnp 00:01:   add io  0x290-0x29f flags 0x1
[    0.471620] pnp 00:01:   add io  0x800-0x87f flags 0x1
[    0.471621] pnp 00:01:   add io  0x290-0x294 flags 0x1
[    0.471622] pnp 00:01:   add io  0x880-0x88f flags 0x1
[    0.471624] pnp 00:01: PNP0c02: calling=20
quirk_system_pci_resources+0x0/0x15c
[    0.475466] pnp 00:01: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.475466] pnp 00:02: parse allocated resources
[    0.475466] pnp 00:02:   add dma 4 flags 0x4
[    0.475466] pnp 00:02:   add io  0x0-0xf flags 0x1
[    0.475466] pnp 00:02:   add io  0x80-0x90 flags 0x1
[    0.475466] pnp 00:02:   add io  0x94-0x9f flags 0x1
[    0.475466] pnp 00:02:   add io  0xc0-0xdf flags 0x1
[    0.475466] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (activ=
e)
[    0.475466] pnp 00:03: parse allocated resources
[    0.475466] pnp 00:03:   add irq 8 flags 0x1
[    0.475466] pnp 00:03:   add mem 0xfed00000-0xfed003ff flags 0x1
[    0.475466] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (activ=
e)
[    0.475466] pnp 00:04: parse allocated resources
[    0.475466] pnp 00:04:   add io  0x70-0x73 flags 0x1
[    0.475466] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (activ=
e)
[    0.475466] pnp 00:05: parse allocated resources
[    0.475466] pnp 00:05:   add io  0x61-0x61 flags 0x1
[    0.475466] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (activ=
e)
[    0.475466] pnp 00:06: parse allocated resources
[    0.475466] pnp 00:06:   add io  0xf0-0xff flags 0x1
[    0.475466] pnp 00:06:   add irq 13 flags 0x1
[    0.475466] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (activ=
e)
[    0.475466] pnp 00:07: parse allocated resources
[    0.475466] pnp 00:07:   add io  0x3f0-0x3f5 flags 0x1
[    0.475466] pnp 00:07:   add io  0x3f7-0x3f7 flags 0x1
[    0.475466] pnp 00:07:   add irq 6 flags 0x1
[    0.475466] pnp 00:07:   add dma 2 flags 0x0
[    0.475466] pnp 00:07: parse resource options
[    0.475466] pnp 00:07: new independent option
[    0.475466] pnp 00:07: new dependent option (priority 0x1)
[    0.475466] pnp 00:07:   io  min 0x3f0 max 0x3f0 align 1 size 6 flag=
s 0x1
[    0.475466] pnp 00:07:   io  min 0x3f7 max 0x3f7 align 1 size 1 flag=
s 0x1
[    0.475466] pnp 00:07:   irq bitmask=20
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000040=
=20
flags 0x1
[    0.475466] pnp 00:07:   dma bitmask 0x4 flags 0x0
[    0.475466] pnp 00:07: end dependent options
[    0.475466] pnp 00:07: Plug and Play ACPI device, IDs PNP0700 (activ=
e)
[    0.475466] pnp 00:08: parse allocated resources
[    0.475466] pnp 00:08:   add io  0x3f8-0x3ff flags 0x1
[    0.475466] pnp 00:08:   add irq 4 flags 0x1
[    0.475466] pnp 00:08: parse resource options
[    0.475466] pnp 00:08: new independent option
[    0.475466] pnp 00:08: new dependent option (priority 0x1)
[    0.475466] pnp 00:08:   io  min 0x3f8 max 0x3f8 align 1 size 8 flag=
s 0x1
[    0.475466] pnp 00:08:   irq bitmask=20
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001eb8=
=20
flags 0x1
[    0.475466] pnp 00:08: new dependent option (priority 0x1)
[    0.475466] pnp 00:08:   io  min 0x2f8 max 0x2f8 align 1 size 8 flag=
s 0x1
[    0.475466] pnp 00:08:   irq bitmask=20
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001eb8=
=20
flags 0x1
[    0.475466] pnp 00:08: new dependent option (priority 0x1)
[    0.475466] pnp 00:08:   io  min 0x3e8 max 0x3e8 align 1 size 8 flag=
s 0x1
[    0.475466] pnp 00:08:   irq bitmask=20
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001eb8=
=20
flags 0x1
[    0.475466] pnp 00:08: new dependent option (priority 0x1)
[    0.475466] pnp 00:08:   io  min 0x2e8 max 0x2e8 align 1 size 8 flag=
s 0x1
[    0.475466] pnp 00:08:   irq bitmask=20
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001eb8=
=20
flags 0x1
[    0.475466] pnp 00:08: end dependent options
[    0.475466] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (activ=
e)
[    0.475466] pnp 00:09: parse allocated resources
[    0.475466] pnp 00:09:   add irq 12 flags 0x1
[    0.475466] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (activ=
e)
[    0.475466] pnp 00:0a: parse allocated resources
[    0.475466] pnp 00:0a:   add io  0x60-0x60 flags 0x1
[    0.475466] pnp 00:0a:   add io  0x64-0x64 flags 0x1
[    0.475466] pnp 00:0a:   add irq 1 flags 0x1
[    0.475466] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 (activ=
e)
[    0.475466] pnp 00:0b: parse allocated resources
[    0.475466] pnp 00:0b:   add io  0x400-0x4bf flags 0x1
[    0.475466] pnp 00:0b: PNP0c02: calling=20
quirk_system_pci_resources+0x0/0x15c
[    0.475466] pnp 00:0b: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.475466] pnp 00:0c: parse allocated resources
[    0.475466] pnp 00:0c:   add mem 0xe0000000-0xe3ffffff flags 0x1
[    0.475466] pnp 00:0c: PNP0c02: calling=20
quirk_system_pci_resources+0x0/0x15c
[    0.475466] pnp 00:0c: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.475466] pnp 00:0d: parse allocated resources
[    0.475466] pnp 00:0d:   add mem 0xd2000-0xd3fff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xf0000-0xf7fff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xf8000-0xfbfff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xfc000-0xfffff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xcfee0000-0xcfefffff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0x0-0x9ffff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0x100000-0xcfedffff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xfec00000-0xfec00fff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xfed10000-0xfed1dfff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xfed20000-0xfed8ffff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xfee00000-0xfee00fff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xffb00000-0xffb7ffff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xfff00000-0xffffffff flags 0x1
[    0.475466] pnp 00:0d:   add mem 0xe0000-0xeffff flags 0x1
[    0.475466] pnp 00:0d: PNP0c01: calling=20
quirk_system_pci_resources+0x0/0x15c
[    0.475466] pnp 00:0d: Plug and Play ACPI device, IDs PNP0c01 (activ=
e)
[    0.475466] pnp 00:0e: parse allocated resources
[    0.475466] pnp 00:0e:   add mem 0xffb80000-0xffbfffff flags 0x1
[    0.475466] pnp 00:0e: Plug and Play ACPI device, IDs INT0800 (activ=
e)
[    0.475466] pnp: PnP ACPI: found 15 devices
[    0.475466] ACPI: ACPI bus type pnp unregistered
[    0.475466] usbcore: registered new interface driver usbfs
[    0.475466] usbcore: registered new interface driver hub
[    0.475466] usbcore: registered new device driver usb
[    0.475466] PCI: Using ACPI for IRQ routing
[    0.493155] PCI-GART: No AMD northbridge found.
[    0.493202] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.493381] hpet0: 4 64-bit timers, 14318180 Hz
[    0.497134] ACPI: RTC can wake from S4
[    0.511776] pnp: the driver 'system' has been registered
[    0.511785] system 00:01: ioport range 0x4d0-0x4d1 has been reserved
[    0.511831] system 00:01: ioport range 0x290-0x29f has been reserved
[    0.511883] system 00:01: ioport range 0x800-0x87f has been reserved
[    0.511927] system 00:01: ioport range 0x290-0x294 has been reserved
[    0.511971] system 00:01: ioport range 0x880-0x88f has been reserved
[    0.512015] system 00:01: driver attached
[    0.512021] system 00:0b: ioport range 0x400-0x4bf has been reserved
[    0.512065] system 00:0b: driver attached
[    0.512069] system 00:0c: iomem range 0xe0000000-0xe3ffffff could no=
t=20
be reserved
[    0.512124] system 00:0c: driver attached
[    0.512127] system 00:0d: iomem range 0xd2000-0xd3fff has been reser=
ved
[    0.512172] system 00:0d: iomem range 0xf0000-0xf7fff could not be=20
reserved
[    0.512217] system 00:0d: iomem range 0xf8000-0xfbfff could not be=20
reserved
[    0.512262] system 00:0d: iomem range 0xfc000-0xfffff could not be=20
reserved
[    0.512307] system 00:0d: iomem range 0xcfee0000-0xcfefffff could no=
t=20
be reserved
[    0.512363] system 00:0d: iomem range 0x0-0x9ffff could not be reser=
ved
[    0.512408] system 00:0d: iomem range 0x100000-0xcfedffff could not=20
be reserved
[    0.512463] system 00:0d: iomem range 0xfec00000-0xfec00fff could no=
t=20
be reserved
[    0.512518] system 00:0d: iomem range 0xfed10000-0xfed1dfff could no=
t=20
be reserved
[    0.512574] system 00:0d: iomem range 0xfed20000-0xfed8ffff could no=
t=20
be reserved
[    0.512629] system 00:0d: iomem range 0xfee00000-0xfee00fff could no=
t=20
be reserved
[    0.512685] system 00:0d: iomem range 0xffb00000-0xffb7ffff could no=
t=20
be reserved
[    0.512740] system 00:0d: iomem range 0xfff00000-0xffffffff could no=
t=20
be reserved
[    0.512796] system 00:0d: iomem range 0xe0000-0xeffff has been reser=
ved
[    0.512840] system 00:0d: driver attached
[    0.514344] Switched to high resolution mode on CPU 2
[    0.518409] Switched to high resolution mode on CPU 1
[    0.518419] Switched to high resolution mode on CPU 3
[    0.522417] PCI: Bridge: 0000:00:01.0
[    0.522417]   IO window: disabled.
[    0.522417]   MEM window: 0xe4000000-0xe6ffffff
[    0.522417]   PREFETCH window: 0x00000000d0000000-0x00000000dfffffff
[    0.522417] PCI: Bridge: 0000:00:1c.0
[    0.522417]   IO window: disabled.
[    0.522417]   MEM window: disabled.
[    0.522417]   PREFETCH window: disabled.
[    0.522417] PCI: Bridge: 0000:00:1c.2
[    0.522417]   IO window: a000-afff
[    0.522417]   MEM window: 0xe7000000-0xe8ffffff
[    0.522417]   PREFETCH window: 0x00000000ec400000-0x00000000ec4fffff
[    0.522417] PCI: Bridge: 0000:00:1c.3
[    0.522417]   IO window: b000-bfff
[    0.522417]   MEM window: 0xe9000000-0xe9ffffff
[    0.522417]   PREFETCH window: disabled.
[    0.522417] PCI: Bridge: 0000:00:1c.4
[    0.522417]   IO window: c000-cfff
[    0.522417]   MEM window: 0xea000000-0xeaffffff
[    0.522417]   PREFETCH window: 0x00000000ec000000-0x00000000ec0fffff
[    0.522417] PCI: Bridge: 0000:00:1c.5
[    0.522417]   IO window: d000-dfff
[    0.522417]   MEM window: 0xeb000000-0xebffffff
[    0.522417]   PREFETCH window: 0x00000000ec100000-0x00000000ec1fffff
[    0.522417] PCI: Bridge: 0000:00:1e.0
[    0.522417]   IO window: disabled.
[    0.522417]   MEM window: 0xec200000-0xec2fffff
[    0.522417]   PREFETCH window: disabled.
[    0.522417] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level,=20
low) -> IRQ 16
[    0.522417] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    0.522417] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level,=20
low) -> IRQ 16
[    0.522417] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.522417] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level,=20
low) -> IRQ 18
[    0.522417] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.522417] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level,=20
low) -> IRQ 19
[    0.522417] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.522417] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level,=20
low) -> IRQ 16
[    0.522417] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    0.522417] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level,=20
low) -> IRQ 17
[    0.522417] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    0.522417] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.522417] NET: Registered protocol family 2
[    0.522688] Switched to high resolution mode on CPU 0
[    0.570387] IP route cache hash table entries: 131072 (order: 8,=20
1048576 bytes)
[    0.570387] TCP established hash table entries: 524288 (order: 11,=20
8388608 bytes)
[    0.570387] TCP bind hash table entries: 65536 (order: 8, 1048576 by=
tes)
[    0.570387] TCP: Hash tables configured (established 524288 bind 655=
36)
[    0.570387] TCP reno registered
[    0.586673] NET: Registered protocol family 1
[    0.586806] checking if image is initramfs... it is
[    1.052297] Freeing initrd memory: 8034k freed
[    1.055838] audit: initializing netlink socket (disabled)
[    1.055838] type=3D2000 audit(1220103307.032:1): initialized
[    1.065317] Total HugeTLB memory allocated, 0
[    1.065317] VFS: Disk quotas dquot_6.5.1
[    1.065317] Dquot-cache hash table entries: 512 (order 0, 4096 bytes=
)
[    1.065317] msgmni has been set to 7934
[    1.065317] Block layer SCSI generic (bsg) driver version 0.4 loaded=
=20
(major 253)
[    1.065317] io scheduler noop registered
[    1.065317] io scheduler anticipatory registered
[    1.065317] io scheduler deadline registered
[    1.065317] io scheduler cfq registered (default)
[    1.065317] pci 0000:01:00.0: Boot video device
[    1.065317] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    1.065317] assign_interrupt_mode Found MSI capability
[    1.065317] Allocate Port Service[0000:00:01.0:pcie00]
[    1.065317] Allocate Port Service[0000:00:01.0:pcie03]
[    1.065317] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    1.065317] assign_interrupt_mode Found MSI capability
[    1.065317] Allocate Port Service[0000:00:1c.0:pcie00]
[    1.065317] Allocate Port Service[0000:00:1c.0:pcie02]
[    1.065317] Allocate Port Service[0000:00:1c.0:pcie03]
[    1.065317] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    1.065317] assign_interrupt_mode Found MSI capability
[    1.065317] Allocate Port Service[0000:00:1c.2:pcie00]
[    1.065317] Allocate Port Service[0000:00:1c.2:pcie02]
[    1.065317] Allocate Port Service[0000:00:1c.2:pcie03]
[    1.065317] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    1.065317] assign_interrupt_mode Found MSI capability
[    1.065317] Allocate Port Service[0000:00:1c.3:pcie00]
[    1.065317] Allocate Port Service[0000:00:1c.3:pcie02]
[    1.065317] Allocate Port Service[0000:00:1c.3:pcie03]
[    1.065317] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    1.065317] assign_interrupt_mode Found MSI capability
[    1.065317] Allocate Port Service[0000:00:1c.4:pcie00]
[    1.065317] Allocate Port Service[0000:00:1c.4:pcie02]
[    1.065317] Allocate Port Service[0000:00:1c.4:pcie03]
[    1.065317] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    1.065317] assign_interrupt_mode Found MSI capability
[    1.065317] Allocate Port Service[0000:00:1c.5:pcie00]
[    1.065317] Allocate Port Service[0000:00:1c.5:pcie02]
[    1.065317] Allocate Port Service[0000:00:1c.5:pcie03]
[    1.069319] hpet_resources: 0xfed00000 is busy
[    1.069319] Linux agpgart interface v0.103
[    1.069319] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ=
=20
sharing enabled
[    1.069319] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.069319] pnp: the driver 'serial' has been registered
[    1.069319] 00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.069319] serial 00:08: driver attached
[    1.069428] brd: module loaded
[    1.069428] input: Macintosh mouse button emulation as=20
/class/input/input0
[    1.069428] pnp: the driver 'i8042 kbd' has been registered
[    1.069428] i8042 kbd 00:0a: driver attached
[    1.069428] pnp: the driver 'i8042 aux' has been registered
[    1.069428] i8042 aux 00:09: driver attached
[    1.069428] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at=20
0x60,0x64 irq 1,12
[    1.069618] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.069665] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.089410] mice: PS/2 mouse device common for all mice
[    1.089410] pnp: the driver 'rtc_cmos' has been registered
[    1.089410] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    1.089410] rtc0: alarms up to one month
[    1.089410] rtc_cmos 00:04: driver attached
[    1.089410] cpuidle: using governor ladder
[    1.089410] cpuidle: using governor menu
[    1.089410] No iBFT detected.
[    1.089410] TCP cubic registered
[    1.089410] NET: Registered protocol family 17
[    1.089410] registered taskstats version 1
[    1.089410] rtc_cmos 00:04: setting system clock to 2008-08-30=20
13:35:07 UTC (1220103307)
[    1.089410] Freeing unused kernel memory: 392k freed
[    1.105308] input: AT Translated Set 2 keyboard as /class/input/inpu=
t1
[    1.147295] ACPI: SSDT CFEE8000, 022A (r1  PmRef  Cpu0Ist     3000=20
INTL 20040311)
[    1.147295] ACPI: CPU0 (power states: C1[C1] C2[C2])
[    1.147295] ACPI: ACPI0007:00 is registered as cooling_device0
[    1.147295] ACPI: Processor [CPU0] (supports 8 throttling states)
[    1.147295] ACPI: SSDT CFEE84C0, 0152 (r1  PmRef  Cpu1Ist     3000=20
INTL 20040311)
[    1.147295] ACPI: CPU1 (power states: C1[C1] C2[C2])
[    1.147295] ACPI: ACPI0007:01 is registered as cooling_device1
[    1.147342] ACPI: Processor [CPU1] (supports 8 throttling states)
[    1.147584] ACPI: SSDT CFEE8620, 0152 (r1  PmRef  Cpu2Ist     3000=20
INTL 20040311)
[    1.151578] ACPI: CPU2 (power states: C1[C1] C2[C2])
[    1.151578] ACPI: ACPI0007:02 is registered as cooling_device2
[    1.151578] ACPI: Processor [CPU2] (supports 8 throttling states)
[    1.151578] ACPI: SSDT CFEE8780, 0152 (r1  PmRef  Cpu3Ist     3000=20
INTL 20040311)
[    1.152903] ACPI: CPU3 (power states: C1[C1] C2[C2])
[    1.153047] ACPI: ACPI0007:03 is registered as cooling_device3
[    1.153092] ACPI: Processor [CPU3] (supports 8 throttling states)
[    1.227512] USB Universal Host Controller Interface driver v3.0
[    1.227512] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level,=20
low) -> IRQ 16
[    1.227512] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[    1.227512] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.227512] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned=20
bus number 1
[    1.227512] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e200
[    1.227512] usb usb1: configuration #1 chosen from 1 choice
[    1.227512] hub 1-0:1.0: USB hub found
[    1.227512] hub 1-0:1.0: 2 ports detected
[    1.273381] No dock devices found.
[    1.277382] SCSI subsystem initialized
[    1.302287] libata version 3.00 loaded.
[    1.327883] Floppy drive(s): fd0 is 1.44M
[    1.346213] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    1.346213] FDC 0 is a post-1991 82077
[    1.346323] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.346378] usb usb1: Product: UHCI Host Controller
[    1.346421] usb usb1: Manufacturer: Linux 2.6.26-1-amd64 uhci_hcd
[    1.346466] usb usb1: SerialNumber: 0000:00:1a.0
[    1.354070] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level,=20
low) -> IRQ 21
[    1.358076] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[    1.358079] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.358154] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned=20
bus number 2
[    1.358231] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000e000
[    1.358324] usb usb2: configuration #1 chosen from 1 choice
[    1.358384] hub 2-0:1.0: USB hub found
[    1.358427] hub 2-0:1.0: 2 ports detected
[    1.463368] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    1.463375] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.463375] usb usb2: Product: UHCI Host Controller
[    1.463375] usb usb2: Manufacturer: Linux 2.6.26-1-amd64 uhci_hcd
[    1.463375] usb usb2: SerialNumber: 0000:00:1a.1
[    1.463375] ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level,=20
low) -> IRQ 18
[    1.463375] PCI: Setting latency timer of device 0000:00:1a.2 to 64
[    1.463375] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    1.463375] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned=20
bus number 3
[    1.463375] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000e100
[    1.463375] usb usb3: configuration #1 chosen from 1 choice
[    1.463375] hub 3-0:1.0: USB hub found
[    1.463375] hub 3-0:1.0: 2 ports detected
[    1.585999] usb usb3: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    1.586061] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.586116] usb usb3: Product: UHCI Host Controller
[    1.586158] usb usb3: Manufacturer: Linux 2.6.26-1-amd64 uhci_hcd
[    1.586201] usb usb3: SerialNumber: 0000:00:1a.2
[    1.586201] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level,=20
low) -> IRQ 18
[    1.586201] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[    1.586201] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    1.586201] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned=20
bus number 4
[    1.658195] PCI: cache line size of 32 is not supported by device=20
0000:00:1a.7
[    1.658195] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xec305000
[    1.675202] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, drive=
r=20
10 Dec 2004
[    1.675316] usb usb4: configuration #1 chosen from 1 choice
[    1.675378] hub 4-0:1.0: USB hub found
[    1.675423] hub 4-0:1.0: 6 ports detected
[    1.777768] usb usb4: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    1.777821] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.777875] usb usb4: Product: EHCI Host Controller
[    1.777917] usb usb4: Manufacturer: Linux 2.6.26-1-amd64 ehci_hcd
[    1.777961] usb usb4: SerialNumber: 0000:00:1a.7
[    1.778207] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level,=20
low) -> IRQ 23
[    1.778207] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    1.778207] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.778207] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned=20
bus number 5
[    1.778207] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000e300
[    1.778207] usb usb5: configuration #1 chosen from 1 choice
[    1.778207] hub 5-0:1.0: USB hub found
[    1.778207] hub 5-0:1.0: 2 ports detected
[    1.887153] usb usb5: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    1.887196] usb usb5: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.887196] usb usb5: Product: UHCI Host Controller
[    1.887196] usb usb5: Manufacturer: Linux 2.6.26-1-amd64 uhci_hcd
[    1.887196] usb usb5: SerialNumber: 0000:00:1d.0
[    1.887196] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level,=20
low) -> IRQ 19
[    1.887196] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    1.887196] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.887196] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned=20
bus number 6
[    1.887196] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e400
[    1.887196] usb usb6: configuration #1 chosen from 1 choice
[    1.887196] hub 6-0:1.0: USB hub found
[    1.887196] hub 6-0:1.0: 2 ports detected
[    2.083222] usb usb6: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    2.083283] usb usb6: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    2.083338] usb usb6: Product: UHCI Host Controller
[    2.083380] usb usb6: Manufacturer: Linux 2.6.26-1-amd64 uhci_hcd
[    2.083423] usb usb6: SerialNumber: 0000:00:1d.1
[    2.085264] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level,=20
low) -> IRQ 18
[    2.085264] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    2.085264] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.085264] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned=20
bus number 7
[    2.085264] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e500
[    2.085264] usb usb7: configuration #1 chosen from 1 choice
[    2.085264] hub 7-0:1.0: USB hub found
[    2.085264] hub 7-0:1.0: 2 ports detected
[    2.221219] usb usb7: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    2.221281] usb usb7: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    2.221336] usb usb7: Product: UHCI Host Controller
[    2.221378] usb usb7: Manufacturer: Linux 2.6.26-1-amd64 uhci_hcd
[    2.221421] usb usb7: SerialNumber: 0000:00:1d.2
[    2.221421] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level,=20
low) -> IRQ 23
[    2.221421] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    2.221421] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    2.221421] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned=20
bus number 8
[    2.261419] PCI: cache line size of 32 is not supported by device=20
0000:00:1d.7
[    2.261419] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xec304000
[    2.285422] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, drive=
r=20
10 Dec 2004
[    2.285533] usb usb8: configuration #1 chosen from 1 choice
[    2.285594] hub 8-0:1.0: USB hub found
[    2.285637] hub 8-0:1.0: 6 ports detected
[    2.387996] usb usb8: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    2.388048] usb usb8: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    2.388103] usb usb8: Product: EHCI Host Controller
[    2.388145] usb usb8: Manufacturer: Linux 2.6.26-1-amd64 ehci_hcd
[    2.388188] usb usb8: SerialNumber: 0000:00:1d.7
[    2.393416] ahci 0000:00:1f.2: version 3.0
[    2.393416] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level,=20
low) -> IRQ 19
[    3.843630] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbp=
s=20
0x3f impl SATA mode
[    3.843693] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo=
=20
pmp pio slum part
[    3.843754] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    3.847601] scsi0 : ahci
[    3.847601] scsi1 : ahci
[    3.847601] scsi2 : ahci
[    3.847601] scsi3 : ahci
[    3.847601] scsi4 : ahci
[    3.847601] scsi5 : ahci
[    3.847680] ata1: SATA max UDMA/133 abar m2048@0xec306000 port=20
0xec306100 irq 1273
[    3.847736] ata2: SATA max UDMA/133 abar m2048@0xec306000 port=20
0xec306180 irq 1273
[    3.847792] ata3: SATA max UDMA/133 abar m2048@0xec306000 port=20
0xec306200 irq 1273
[    3.847848] ata4: SATA max UDMA/133 abar m2048@0xec306000 port=20
0xec306280 irq 1273
[    3.847903] ata5: SATA max UDMA/133 abar m2048@0xec306000 port=20
0xec306300 irq 1273
[    3.847959] ata6: SATA max UDMA/133 abar m2048@0xec306000 port=20
0xec306380 irq 1273
[    4.671777] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.671767] ata1.00: ATA-8: WDC WD7501AALS-00J7B0, 05.00K05, max UDM=
A/133
[    4.671767] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32)
[    4.672094] ata1.00: configured for UDMA/133
[    5.558790] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.558781] ata2.00: ATA-8: WDC WD7501AALS-00J7B0, 05.00K05, max UDM=
A/133
[    5.558781] ata2.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32)
[    5.563197] ata2.00: configured for UDMA/133
[    6.042309] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.131806] ata3.00: ATA-8: WDC WD7501AALS-00J7B0, 05.00K05, max UDM=
A/133
[    6.131806] ata3.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32)
[    6.131806] ata3.00: configured for UDMA/133
[    6.607219] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.608423] ata4.00: ATA-8: WDC WD7501AALS-00J7B0, 05.00K05, max UDM=
A/133
[    6.608470] ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32)
[    6.608423] ata4.00: configured for UDMA/133
[    7.090884] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.151506] ata5.00: ATA-8: WDC WD7501AALS-00J7B0, 05.00K05, max UDM=
A/133
[    7.151506] ata5.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32)
[    7.151506] ata5.00: configured for UDMA/133
[    8.109286] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.118160] ata6.00: ATA-8: WDC WD7501AALS-00J7B0, 05.00K05, max UDM=
A/133
[    8.118160] ata6.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32)
[    8.122478] ata6.00: configured for UDMA/133
[    7.151506] scsi 0:0:0:0: Direct-Access     ATA      WDC WD7501AALS-=
0=20
05.0 PQ: 0 ANSI: 5
[    7.151506] scsi 1:0:0:0: Direct-Access     ATA      WDC WD7501AALS-=
0=20
05.0 PQ: 0 ANSI: 5
[    7.151506] scsi 2:0:0:0: Direct-Access     ATA      WDC WD7501AALS-=
0=20
05.0 PQ: 0 ANSI: 5
[    7.151506] scsi 3:0:0:0: Direct-Access     ATA      WDC WD7501AALS-=
0=20
05.0 PQ: 0 ANSI: 5
[    7.151506] scsi 4:0:0:0: Direct-Access     ATA      WDC WD7501AALS-=
0=20
05.0 PQ: 0 ANSI: 5
[    7.151506] scsi 5:0:0:0: Direct-Access     ATA      WDC WD7501AALS-=
0=20
05.0 PQ: 0 ANSI: 5
[    8.429006] r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
[    8.429006] sata_sil24 0000:03:00.0: version 1.1
[    8.429006] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level,=20
low) -> IRQ 18
[    8.429006] PCI: Setting latency timer of device 0000:03:00.0 to 64
[    8.429006] ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 17 (level,=20
low) -> IRQ 17
[    8.429006] PCI: Setting latency timer of device 0000:06:00.0 to 64
[    8.429006] scsi6 : sata_sil24
[    8.429006] eth0: RTL8168c/8111c at 0xffffc20000632000,=20
00:1f:d0:23:89:fe, XID 3c4000c0 IRQ 1272
[    8.429006] scsi7 : sata_sil24
[    8.429006] ata7: SATA max UDMA/100 host m128@0xe8004000 port=20
0xe8000000 irq 18
[    8.429006] ata8: SATA max UDMA/100 host m128@0xe8004000 port=20
0xe8002000 irq 18
[   10.840394] ata7: SATA link down (SStatus 0 SControl 0)
[   13.704354] ata8: SATA link down (SStatus 0 SControl 0)
[   14.716334] ACPI: PCI Interrupt 0000:07:07.0[A] -> GSI 23 (level,=20
low) -> IRQ 23
[   14.846759] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[23] =20
MMIO=3D[ec204000-ec2047ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
[   14.846759] Uniform Multi-Platform E-IDE driver
[   14.846804] ide: Assuming 33MHz system bus speed for PIO modes;=20
override with idebus=3Dxx
[   14.847185] JMB: IDE controller (0x197b:0x2368 rev 0x00) at  PCI slo=
t=20
0000:04:00.0
[   14.847185] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 19 (level,=20
low) -> IRQ 19
[   14.847185] JMB: 100% native mode on irq 19
[   14.847185]     ide0: BM-DMA at 0xb400-0xb407
[   14.847185]     ide1: BM-DMA at 0xb408-0xb40f
[   14.847185] Probing IDE interface ide0...
[   14.856760] Driver 'sd' needs updating - please use bus_type methods
[   14.856881] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.856949] sd 0:0:0:0: [sda] Write Protect is off
[   14.860461] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   14.860461] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.860461] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.860461] sd 0:0:0:0: [sda] Write Protect is off
[   14.860461] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   14.860461] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.860461]  sda: sda1 sda2 sda3
[   14.881341] sd 0:0:0:0: [sda] Attached SCSI disk
[   14.881341] sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.881341] sd 1:0:0:0: [sdb] Write Protect is off
[   14.881341] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   14.881341] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.881341] sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.881341] sd 1:0:0:0: [sdb] Write Protect is off
[   14.881341] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   14.881341] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.881341]  sdb: sdb1 sdb2 sdb3
[   14.906515] sd 1:0:0:0: [sdb] Attached SCSI disk
[   14.906515] sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.906515] sd 2:0:0:0: [sdc] Write Protect is off
[   14.906515] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   14.906515] sd 2:0:0:0: [sdc] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.906515] sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.906515] sd 2:0:0:0: [sdc] Write Protect is off
[   14.906515] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   14.906515] sd 2:0:0:0: [sdc] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.906515]  sdc: sdc1 sdc2 sdc3
[   14.928338] sd 2:0:0:0: [sdc] Attached SCSI disk
[   14.928338] sd 3:0:0:0: [sdd] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.928338] sd 3:0:0:0: [sdd] Write Protect is off
[   14.928338] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   14.928338] sd 3:0:0:0: [sdd] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.928338] sd 3:0:0:0: [sdd] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.928338] sd 3:0:0:0: [sdd] Write Protect is off
[   14.928338] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   14.928338] sd 3:0:0:0: [sdd] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.928338]  sdd: sdd1 sdd2 sdd3
[   14.952282] sd 3:0:0:0: [sdd] Attached SCSI disk
[   14.952282] sd 4:0:0:0: [sde] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.952282] sd 4:0:0:0: [sde] Write Protect is off
[   14.952282] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   14.952282] sd 4:0:0:0: [sde] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.954288] sd 4:0:0:0: [sde] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.954288] sd 4:0:0:0: [sde] Write Protect is off
[   14.954288] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   14.954288] sd 4:0:0:0: [sde] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.954288]  sde: sde1 sde2 sde3
[   14.976122] sd 4:0:0:0: [sde] Attached SCSI disk
[   14.976202] sd 5:0:0:0: [sdf] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.976265] sd 5:0:0:0: [sdf] Write Protect is off
[   14.976308] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   14.976323] sd 5:0:0:0: [sdf] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.976408] sd 5:0:0:0: [sdf] 1465149168 512-byte hardware sectors=20
(750156 MB)
[   14.976472] sd 5:0:0:0: [sdf] Write Protect is off
[   14.976515] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   14.976530] sd 5:0:0:0: [sdf] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[   14.976587]  sdf: sdf1 sdf2 sdf3
[   14.994523] sd 5:0:0:0: [sdf] Attached SCSI disk
[   15.594725] hda: ASUS CRW-5232AS, ATAPI CD/DVD-ROM drive
[   16.145540] ieee1394: Host added: ID:BUS[0-00:1023] =20
GUID[002bcaee00001fd0]
[   16.706809] hdb: SAMSUNG CD-ROM SH-152A, ATAPI CD/DVD-ROM drive
[   16.762418] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO=
4
[   16.762501] hda: UDMA/33 mode selected
[   16.762660] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO=
4
[   16.762726] hdb: UDMA/33 mode selected
[   16.762869] Probing IDE interface ide1...
[   17.581059] ide0 at 0xb000-0xb007,0xb102 on irq 19
[   17.582203] ide1 at 0xb200-0xb207,0xb302 on irq 19
[   17.863689] hda: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
[   17.863689] Uniform CD-ROM driver Revision: 3.20
[   17.870292] hdb: ATAPI 52X CD-ROM drive, 128kB Cache
[   17.925104] md: raid1 personality registered for level 1
[   17.927090] md: raid10 personality registered for level 10
[   17.929410] md: md3 stopped.
[   17.960031] md: bind<sdb1>
[   17.960031] md: bind<sdd1>
[   17.960083] md: bind<sde1>
[   17.960031] md: bind<sdc1>
[   17.960732] md: bind<sdf1>
[   17.960732] md: bind<sda1>
[   17.971855] raid1: raid set md3 active with 6 out of 6 mirrors
[   17.971855] md: md4 stopped.
[   17.975859] md: bind<sdb3>
[   17.975859] md: bind<sdd3>
[   17.975859] md: bind<sde3>
[   17.976982] md: bind<sdc3>
[   17.975859] md: bind<sdf3>
[   17.975859] md: bind<sda3>
[   17.983851] raid10: raid set md4 active with 6 out of 6 devices
[   18.123469] device-mapper: uevent: version 1.0.3
[   18.123547] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18)=20
initialised: dm-devel@redhat.com
[   18.139475] PM: Starting manual resume from disk
[   18.189012] kjournald starting.  Commit interval 5 seconds
[   18.189660] EXT3-fs: mounted filesystem with ordered data mode.
[   20.026659] udevd version 125 started
[   20.332956] input: Power Button (FF) as /class/input/input2
[   20.414997] ACPI: Power Button (FF) [PWRF]
[   20.415079] input: Power Button (CM) as /class/input/input3
[   20.483338] ACPI: Power Button (CM) [PWRB]
[   20.496008] ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level,=20
low) -> IRQ 18
[   20.508008] input: PC Speaker as /class/input/input4
[   20.533768] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level,=20
low) -> IRQ 22
[   20.533768] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   20.543847] Error: Driver 'pcspkr' is already registered, aborting..=
=2E
[   21.112299] input: ImPS/2 Generic Wheel Mouse as /class/input/input5
[   21.476256] Error: Driver 'pcspkr' is already registered, aborting..=
=2E
[   23.959337] Adding 2931852k swap on /dev/sda2.  Priority:-1 extents:=
1=20
across:2931852k
[   23.963712] Adding 2931852k swap on /dev/sdd2.  Priority:-2 extents:=
1=20
across:2931852k
[   24.455456] EXT3 FS on md3, internal journal
[   24.534056] loop: module loaded
[   24.574483] it87: Found IT8718F chip at 0x290, revision 5
[   24.574483] it87: in3 is VCC (+5V)
[   24.596260] coretemp coretemp.0: Using relative temperature scale!
[   24.596290] coretemp coretemp.1: Using relative temperature scale!
[   24.596360] coretemp coretemp.2: Using relative temperature scale!
[   24.596427] coretemp coretemp.3: Using relative temperature scale!
[   25.379749] SGI XFS with ACLs, security attributes, realtime, large=20
block/inode numbers, no debug enabled
[   25.379749] SGI XFS Quota Management subsystem
[   25.379749] Filesystem "dm-0": Disabling barriers, not supported by=20
the underlying device
[   25.379749] XFS mounting filesystem dm-0
[   25.589938] Ending clean XFS mount for filesystem: dm-0
[   25.589938] Filesystem "dm-1": Disabling barriers, not supported by=20
the underlying device
[   25.589938] XFS mounting filesystem dm-1
[   25.808033] Ending clean XFS mount for filesystem: dm-1
[   25.982767] ReiserFS: dm-2: found reiserfs format "3.6" with standar=
d=20
journal
[   25.982767] ReiserFS: dm-2: using ordered data mode
[   25.997390] ReiserFS: dm-2: journal params: device dm-2, size 8192,=20
journal first block 18, max trans len 1024, max batch 900, max commit=20
age 30, max trans age 30
[   25.997390] ReiserFS: dm-2: checking transaction log (dm-2)
[   26.049615] ReiserFS: dm-2: Using r5 hash to sort names
[   27.356049] fuse init (API version 7.9)
[   30.872983] r8169: eth0: link up
[   30.872983] r8169: eth0: link up
[   36.793363] NET: Registered protocol family 10
[   36.793725] lo: Disabled Privacy Extensions
[   51.030543] eth0: no IPv6 routers present
[  137.906238] md: md4 still in use.
[  457.735609] md: md4 stopped.
[  457.735609] md: unbind<sda3>
[  457.735609] md: export_rdev(sda3)
[  457.735609] md: unbind<sdf3>
[  457.735609] md: export_rdev(sdf3)
[  457.735609] md: unbind<sdc3>
[  457.735609] md: export_rdev(sdc3)
[  457.735609] md: unbind<sde3>
[  457.735609] md: export_rdev(sde3)
[  457.735609] md: unbind<sdd3>
[  457.735609] md: export_rdev(sdd3)
[  457.735609] md: unbind<sdb3>
[  457.735609] md: export_rdev(sdb3)
[  765.553777] dmesg(4322): dirtied inode 10440 (dmesg_next) on tmpfs
[  765.558443] lm-profiler(4317): READ block 8913752 on md3
[  765.594108] lm-profiler(4323): READ block 9124536 on md3
[  765.594908] lm-profiler(4317): READ block 8913824 on md3
[  765.607814] lm-profiler(4317): READ block 8914648 on md3
[  765.607819] lm-profiler(4327): READ block 9768168 on md3
[  765.610108] lm-profiler(4317): READ block 8913608 on md3
[  765.610108] diff(4323): READ block 9124568 on md3
[  765.610108] diff(4323): READ block 9124576 on md3
[  765.610108] diff(4323): READ block 9124584 on md3
[  765.610108] diff(4323): READ block 9124592 on md3
[  765.610108] diff(4323): READ block 9124600 on md3
[  765.610108] diff(4323): READ block 9124608 on md3
[  765.610108] diff(4323): READ block 9124616 on md3
[  765.610108] diff(4323): READ block 9124624 on md3
[  765.610108] diff(4323): READ block 9124632 on md3
[  765.611819] lm-profiler(4317): READ block 8913624 on md3
[  765.617081] lm-profiler(4330): READ block 9096920 on md3
[  765.618311] diff(4323): READ block 9124640 on md3
[  765.620603] awk(4327): READ block 9768264 on md3
[  765.621243] awk(4327): READ block 9768696 on md3
[  765.624595] sort(4330): READ block 9096952 on md3
[  765.624595] sort(4330): READ block 9096960 on md3
[  765.624595] sort(4330): READ block 9096968 on md3
[  765.624595] sort(4330): READ block 9096976 on md3
[  765.624595] sort(4330): READ block 9096984 on md3
[  765.624595] sort(4330): READ block 9096992 on md3
[  765.624595] sort(4330): READ block 9097000 on md3
[  765.624595] sort(4330): READ block 9097008 on md3
[  765.624595] sort(4330): READ block 9097016 on md3
[  765.628836] lm-profiler(4331): READ block 9098960 on md3
[  765.629947] sort(4330): READ block 9097024 on md3
[  765.632836] awk(4327): READ block 9768200 on md3
[  765.632843] awk(4327): READ block 9768208 on md3
[  765.632846] awk(4327): READ block 9768216 on md3
[  765.632849] awk(4327): READ block 9768224 on md3
[  765.632851] awk(4327): READ block 9768232 on md3
[  765.632854] awk(4327): READ block 9768240 on md3
[  765.632857] awk(4327): READ block 9768248 on md3
[  765.632860] awk(4327): READ block 9768256 on md3
[  765.632868] awk(4327): READ block 9768272 on md3
[  765.636835] uniq(4331): READ block 9098992 on md3
[  765.639739] awk(4327): READ block 9768544 on md3
[  765.649084] awk(4327): READ block 9768432 on md3
[  765.656835] awk(4327): READ block 8398752 on md3
[  765.656835] awk(4327): READ block 8398760 on md3
[  765.656835] awk(4327): READ block 8398768 on md3
[  765.656835] awk(4327): READ block 8398784 on md3
[  765.665084] awk(4327): READ block 8399360 on md3
[  765.680840] cat(4342): dirtied inode 10449 (write_accesses_1) on tmp=
fs
[  766.695642] diff(4355): dirtied inode 10463 (dmesg_next) on tmpfs
[  766.699643] cat(4365): dirtied inode 10472 (write_accesses_2) on tmp=
fs
[  766.699851] cat(4366): dirtied inode 10480 (read_accesses_2) on tmpf=
s
[  768.243779] diff(4378): dirtied inode 10486 (dmesg_next) on tmpfs
[  768.247780] cat(4388): dirtied inode 10495 (write_accesses_3) on tmp=
fs
[  769.244968] diff(4392): dirtied inode 10509 (dmesg_next) on tmpfs
[  769.341001] cat(4412): dirtied inode 10527 (read_accesses_4) on tmpf=
s
[  770.341032] dmesg(4414): dirtied inode 10532 (dmesg_next) on tmpfs
[  770.350000] cat(4434): dirtied inode 10541 (write_accesses_5) on tmp=
fs
[  771.530834] dmesg(4437): dirtied inode 10555 (dmesg_next) on tmpfs
[  771.934699] cat(4457): dirtied inode 10564 (write_accesses_6) on tmp=
fs
[  772.937772] dmesg(4460): dirtied inode 10578 (dmesg_next) on tmpfs
[  773.133573] cat(4480): dirtied inode 10587 (write_accesses_7) on tmp=
fs
[  773.133573] cat(4481): dirtied inode 10596 (read_accesses_7) on tmpf=
s
[  774.141215] dmesg(4483): dirtied inode 10601 (dmesg_next) on tmpfs
[  774.564704] cat(4503): dirtied inode 10610 (write_accesses_8) on tmp=
fs
[  774.564704] cat(4504): dirtied inode 10619 (read_accesses_8) on tmpf=
s
[  775.596162] dmesg(4506): dirtied inode 10624 (dmesg_next) on tmpfs
[  775.603904] cat(4526): dirtied inode 10633 (write_accesses_9) on tmp=
fs
[  776.796494] diff(4539): dirtied inode 10647 (dmesg_next) on tmpfs
[  776.796494] cat(4549): dirtied inode 10656 (write_accesses_10) on tm=
pfs
[  778.228980] diff(4553): dirtied inode 10670 (dmesg_next) on tmpfs
[  778.242555] cat(4573): dirtied inode 10688 (read_accesses_11) on tmp=
fs
[  779.420481] dmesg(4575): dirtied inode 10693 (dmesg_next) on tmpfs
[  779.876449] cat(4595): dirtied inode 10702 (write_accesses_12) on tm=
pfs
[  779.876449] cat(4596): dirtied inode 10711 (read_accesses_12) on tmp=
fs
[  780.873748] dmesg(4598): dirtied inode 10716 (dmesg_next) on tmpfs
[  780.885388] cat(4618): dirtied inode 10725 (write_accesses_13) on tm=
pfs
[  780.885388] cat(4619): dirtied inode 10734 (read_accesses_13) on tmp=
fs
[  782.061382] dmesg(4621): dirtied inode 10739 (dmesg_next) on tmpfs
[  782.073537] cat(4641): dirtied inode 10748 (write_accesses_14) on tm=
pfs
[  783.097230] dmesg(4644): dirtied inode 10762 (dmesg_next) on tmpfs
[  783.289200] cat(4664): dirtied inode 10771 (write_accesses_15) on tm=
pfs
[  783.289200] cat(4665): dirtied inode 10780 (read_accesses_15) on tmp=
fs
[  784.297200] dmesg(4667): dirtied inode 10785 (dmesg_next) on tmpfs
[  784.792721] cat(4687): dirtied inode 10794 (write_accesses_16) on tm=
pfs
[  784.792721] cat(4688): dirtied inode 10803 (read_accesses_16) on tmp=
fs
[  785.793032] dmesg(4690): dirtied inode 10808 (dmesg_next) on tmpfs
[  785.800721] cat(4710): dirtied inode 10817 (write_accesses_17) on tm=
pfs
[  786.809821] diff(4723): dirtied inode 10831 (dmesg_next) on tmpfs
[  786.815006] cat(4733): dirtied inode 10840 (write_accesses_18) on tm=
pfs
[  787.815777] dmesg(4736): dirtied inode 10854 (dmesg_next) on tmpfs
[  787.837475] cat(4756): dirtied inode 10863 (write_accesses_19) on tm=
pfs
[  788.833007] dmesg(4759): dirtied inode 10877 (dmesg_next) on tmpfs
[  788.860578] cat(4779): dirtied inode 10886 (write_accesses_20) on tm=
pfs
[  789.894393] dmesg(4782): dirtied inode 10900 (dmesg_next) on tmpfs
[  789.898205] cat(4802): dirtied inode 10909 (write_accesses_21) on tm=
pfs
[  790.915619] diff(4815): dirtied inode 10923 (dmesg_next) on tmpfs
[  790.915619] cat(4825): dirtied inode 10932 (write_accesses_22) on tm=
pfs
[  791.975208] diff(4838): dirtied inode 10946 (dmesg_next) on tmpfs
[  791.979256] cat(4848): dirtied inode 10955 (write_accesses_23) on tm=
pfs
[  791.979257] cat(4849): dirtied inode 10964 (read_accesses_23) on tmp=
fs
[  792.980171] dmesg(4851): dirtied inode 10969 (dmesg_next) on tmpfs
[  793.045383] cat(4871): dirtied inode 10978 (write_accesses_24) on tm=
pfs
[  794.116424] dmesg(4874): dirtied inode 10992 (dmesg_next) on tmpfs
[  794.123047] cat(4894): dirtied inode 11001 (write_accesses_25) on tm=
pfs
[  794.123047] cat(4895): dirtied inode 11010 (read_accesses_25) on tmp=
fs
[  795.132837] diff(4907): dirtied inode 11015 (dmesg_next) on tmpfs
[  795.136607] cat(4917): dirtied inode 11024 (write_accesses_26) on tm=
pfs
[  796.137000] diff(4921): dirtied inode 11038 (dmesg_next) on tmpfs
[  796.146300] cat(4940): dirtied inode 11047 (write_accesses_27) on tm=
pfs
[  796.146300] cat(4941): dirtied inode 11056 (read_accesses_27) on tmp=
fs
[  797.146859] dmesg(4943): dirtied inode 11061 (dmesg_next) on tmpfs
[  797.246607] cat(4963): dirtied inode 11070 (write_accesses_28) on tm=
pfs
[  798.350273] dmesg(4966): dirtied inode 11084 (dmesg_next) on tmpfs
[  798.359815] cat(4986): dirtied inode 11093 (write_accesses_29) on tm=
pfs
[  799.363984] dmesg(4989): dirtied inode 11107 (dmesg_next) on tmpfs
[  799.477241] cat(5009): dirtied inode 11116 (write_accesses_30) on tm=
pfs
[  800.481322] diff(5013): dirtied inode 11130 (dmesg_next) on tmpfs
[  801.658319] diff(5036): dirtied inode 11153 (dmesg_next) on tmpfs
[  801.795692] cat(5055): dirtied inode 11162 (write_accesses_32) on tm=
pfs
[  801.795692] cat(5056): dirtied inode 11171 (read_accesses_32) on tmp=
fs
[  802.797730] dmesg(5058): dirtied inode 11176 (dmesg_next) on tmpfs
[  802.805720] cat(5078): dirtied inode 11185 (write_accesses_33) on tm=
pfs
[  803.807576] dmesg(5081): dirtied inode 11199 (dmesg_next) on tmpfs
[  803.959161] cat(5101): dirtied inode 11208 (write_accesses_34) on tm=
pfs
[  803.959402] cat(5102): dirtied inode 11217 (read_accesses_34) on tmp=
fs
[  804.968707] diff(5114): dirtied inode 11222 (dmesg_next) on tmpfs
[  805.126067] cat(5124): dirtied inode 11231 (write_accesses_35) on tm=
pfs
[  806.129210] dmesg(5127): dirtied inode 11245 (dmesg_next) on tmpfs
[  806.303108] cat(5147): dirtied inode 11254 (write_accesses_36) on tm=
pfs
[  806.303108] cat(5148): dirtied inode 11263 (read_accesses_36) on tmp=
fs
[  807.303998] dmesg(5150): dirtied inode 11268 (dmesg_next) on tmpfs
[  807.313250] cat(5170): dirtied inode 11277 (write_accesses_37) on tm=
pfs
[  807.313250] cat(5171): dirtied inode 11286 (read_accesses_37) on tmp=
fs
[  808.310769] dmesg(5173): dirtied inode 11291 (dmesg_next) on tmpfs
[  808.498329] cat(5193): dirtied inode 11300 (write_accesses_38) on tm=
pfs
[  809.692708] dmesg(5196): dirtied inode 11314 (dmesg_next) on tmpfs
[  809.699467] cat(5216): dirtied inode 11323 (write_accesses_39) on tm=
pfs
[  809.700497] cat(5217): dirtied inode 11332 (read_accesses_39) on tmp=
fs
[  810.703486] diff(5220): dirtied inode 11337 (dmesg_next) on tmpfs
[  810.716479] cat(5239): dirtied inode 11346 (write_accesses_40) on tm=
pfs
[  810.716479] cat(5240): dirtied inode 11355 (read_accesses_40) on tmp=
fs
[  811.717030] dmesg(5242): dirtied inode 11360 (dmesg_next) on tmpfs
[  811.725017] cat(5262): dirtied inode 11369 (write_accesses_41) on tm=
pfs
[  812.951791] diff(5275): dirtied inode 11383 (dmesg_next) on tmpfs
[  812.955735] cat(5285): dirtied inode 11392 (write_accesses_42) on tm=
pfs
[  812.955735] cat(5286): dirtied inode 11401 (read_accesses_42) on tmp=
fs
[  813.956266] dmesg(5288): dirtied inode 11406 (dmesg_next) on tmpfs
[  813.966776] cat(5308): dirtied inode 11415 (write_accesses_43) on tm=
pfs
[  814.971793] dmesg(5311): dirtied inode 11429 (dmesg_next) on tmpfs
[  815.216769] cat(5331): dirtied inode 11438 (write_accesses_44) on tm=
pfs
[  816.230846] diff(5344): dirtied inode 11452 (dmesg_next) on tmpfs
[  816.230846] cat(5354): dirtied inode 11461 (write_accesses_45) on tm=
pfs
[  817.488744] diff(5367): dirtied inode 11475 (dmesg_next) on tmpfs
[  817.492976] cat(5378): dirtied inode 11493 (read_accesses_46) on tmp=
fs
[  818.489989] dmesg(5380): dirtied inode 11498 (dmesg_next) on tmpfs
[  818.760614] cat(5400): dirtied inode 11507 (write_accesses_47) on tm=
pfs
[  819.760802] dmesg(5403): dirtied inode 11521 (dmesg_next) on tmpfs
[  820.040758] cat(5423): dirtied inode 11530 (write_accesses_48) on tm=
pfs
[  821.325241] dmesg(5426): dirtied inode 11544 (dmesg_next) on tmpfs
[  821.331885] cat(5446): dirtied inode 11553 (write_accesses_49) on tm=
pfs
[  821.334812] cat(5447): dirtied inode 11562 (read_accesses_49) on tmp=
fs
[  822.340246] diff(5450): dirtied inode 11567 (dmesg_next) on tmpfs
[  822.637298] cat(5470): dirtied inode 11585 (read_accesses_50) on tmp=
fs
[  823.918483] dmesg(5472): dirtied inode 11590 (dmesg_next) on tmpfs
[  823.926455] cat(5492): dirtied inode 11599 (write_accesses_51) on tm=
pfs
[  824.927934] dmesg(5495): dirtied inode 11613 (dmesg_next) on tmpfs
[  825.240835] cat(5515): dirtied inode 11622 (write_accesses_52) on tm=
pfs
[  826.255144] diff(5528): dirtied inode 11636 (dmesg_next) on tmpfs
[  826.575172] cat(5538): dirtied inode 11645 (write_accesses_53) on tm=
pfs
[  827.578675] dmesg(5541): dirtied inode 11659 (dmesg_next) on tmpfs
[  827.921115] cat(5561): dirtied inode 11668 (write_accesses_54) on tm=
pfs
[  828.923620] dmesg(5564): dirtied inode 11682 (dmesg_next) on tmpfs
[  829.207516] cat(5584): dirtied inode 11691 (write_accesses_55) on tm=
pfs
[  830.212796] dmesg(5587): dirtied inode 11705 (dmesg_next) on tmpfs
[  830.563350] cat(5607): dirtied inode 11714 (write_accesses_56) on tm=
pfs
[  830.563555] cat(5608): dirtied inode 11723 (read_accesses_56) on tmp=
fs
[  831.577225] diff(5620): dirtied inode 11728 (dmesg_next) on tmpfs
[  831.932973] cat(5630): dirtied inode 11737 (write_accesses_57) on tm=
pfs
[  832.936478] dmesg(5633): dirtied inode 11751 (dmesg_next) on tmpfs
[  833.315593] cat(5653): dirtied inode 11760 (write_accesses_58) on tm=
pfs
[  834.317429] dmesg(5656): dirtied inode 11774 (dmesg_next) on tmpfs
[  834.599475] cat(5676): dirtied inode 11783 (write_accesses_59) on tm=
pfs
[  835.604747] dmesg(5679): dirtied inode 11797 (dmesg_next) on tmpfs
[  835.991417] cat(5699): dirtied inode 11806 (write_accesses_60) on tm=
pfs
[  835.993835] cat(5700): dirtied inode 11815 (read_accesses_60) on tmp=
fs
[  836.997441] diff(5703): dirtied inode 11820 (dmesg_next) on tmpfs
[  838.398422] dmesg(5725): dirtied inode 11843 (dmesg_next) on tmpfs
[  838.806655] cat(5745): dirtied inode 11852 (write_accesses_62) on tm=
pfs
[  840.091206] dmesg(5748): dirtied inode 11866 (dmesg_next) on tmpfs
[  840.099180] cat(5768): dirtied inode 11875 (write_accesses_63) on tm=
pfs
[  841.525732] diff(5781): dirtied inode 11889 (dmesg_next) on tmpfs
[  841.529731] cat(5791): dirtied inode 11898 (write_accesses_64) on tm=
pfs
[  841.529731] cat(5792): dirtied inode 11907 (read_accesses_64) on tmp=
fs
[  842.625119] dmesg(5794): dirtied inode 11912 (dmesg_next) on tmpfs
[  842.630735] cat(5814): dirtied inode 11921 (write_accesses_65) on tm=
pfs
[  844.085339] diff(5827): dirtied inode 11935 (dmesg_next) on tmpfs
[  844.089031] cat(5837): dirtied inode 11944 (write_accesses_66) on tm=
pfs
[  844.089031] cat(5838): dirtied inode 11953 (read_accesses_66) on tmp=
fs
[  845.089646] dmesg(5840): dirtied inode 11958 (dmesg_next) on tmpfs
[  845.375414] cat(5860): dirtied inode 11967 (write_accesses_67) on tm=
pfs
[  846.380161] dmesg(5863): dirtied inode 11981 (dmesg_next) on tmpfs
[  846.845163] cat(5883): dirtied inode 11990 (write_accesses_68) on tm=
pfs
[  848.319810] diff(5896): dirtied inode 12004 (dmesg_next) on tmpfs
[  848.326074] cat(5906): dirtied inode 12013 (write_accesses_69) on tm=
pfs
[  848.326074] cat(5907): dirtied inode 12022 (read_accesses_69) on tmp=
fs
[  849.323542] dmesg(5909): dirtied inode 12027 (dmesg_next) on tmpfs
[  849.339261] cat(5929): dirtied inode 12036 (write_accesses_70) on tm=
pfs
[  849.808701] cat(5930): dirtied inode 12045 (read_accesses_70) on tmp=
fs
[  851.088737] dmesg(5932): dirtied inode 12050 (dmesg_next) on tmpfs
[  851.096428] cat(5952): dirtied inode 12059 (write_accesses_71) on tm=
pfs
[  852.098491] dmesg(5955): dirtied inode 12073 (dmesg_next) on tmpfs
[  852.588340] cat(5975): dirtied inode 12082 (write_accesses_72) on tm=
pfs
[  853.592372] diff(5979): dirtied inode 12096 (dmesg_next) on tmpfs
[  854.044575] cat(5999): dirtied inode 12114 (read_accesses_73) on tmp=
fs
[  855.047932] dmesg(6001): dirtied inode 12119 (dmesg_next) on tmpfs
[  855.334101] cat(6021): dirtied inode 12128 (write_accesses_74) on tm=
pfs
[  856.576762] dmesg(6024): dirtied inode 12142 (dmesg_next) on tmpfs
[  856.584729] cat(6044): dirtied inode 12151 (write_accesses_75) on tm=
pfs
[  857.870720] diff(6048): dirtied inode 12165 (dmesg_next) on tmpfs
[  857.911306] cat(6068): dirtied inode 12183 (read_accesses_76) on tmp=
fs
[  859.120374] dmesg(6070): dirtied inode 12188 (dmesg_next) on tmpfs
[  859.168321] cat(6090): dirtied inode 12197 (write_accesses_77) on tm=
pfs
[  859.168321] cat(6091): dirtied inode 12206 (read_accesses_77) on tmp=
fs
[  860.570929] dmesg(6093): dirtied inode 12211 (dmesg_next) on tmpfs
[  860.627646] cat(6113): dirtied inode 12220 (write_accesses_78) on tm=
pfs
[  861.812753] diff(6117): dirtied inode 12234 (dmesg_next) on tmpfs
[  861.882667] cat(6136): dirtied inode 12243 (write_accesses_79) on tm=
pfs
[  863.103014] dmesg(6139): dirtied inode 12257 (dmesg_next) on tmpfs
[  863.183005] cat(6159): dirtied inode 12266 (write_accesses_80) on tm=
pfs
[  864.180480] diff(6163): dirtied inode 12280 (dmesg_next) on tmpfs
[  864.358076] cat(6183): dirtied inode 12298 (read_accesses_81) on tmp=
fs
[  865.358151] dmesg(6185): dirtied inode 12303 (dmesg_next) on tmpfs
[  865.562082] cat(6205): dirtied inode 12312 (write_accesses_82) on tm=
pfs
[  867.010309] dmesg(6208): dirtied inode 12326 (dmesg_next) on tmpfs
[  867.018271] cat(6228): dirtied inode 12335 (write_accesses_83) on tm=
pfs
[  867.022277] cat(6229): dirtied inode 12344 (read_accesses_83) on tmp=
fs
[  868.221770] dmesg(6231): dirtied inode 12349 (dmesg_next) on tmpfs
[  868.335430] cat(6251): dirtied inode 12358 (write_accesses_84) on tm=
pfs
[  869.466367] dmesg(6254): dirtied inode 12372 (dmesg_next) on tmpfs
[  869.474329] cat(6274): dirtied inode 12381 (write_accesses_85) on tm=
pfs
[  870.753724] dmesg(6277): dirtied inode 12395 (dmesg_next) on tmpfs
[  870.765056] cat(6297): dirtied inode 12404 (write_accesses_86) on tm=
pfs
[  870.766373] cat(6298): dirtied inode 12413 (read_accesses_86) on tmp=
fs
[  871.877232] dmesg(6300): dirtied inode 12418 (dmesg_next) on tmpfs
[  871.886709] cat(6320): dirtied inode 12427 (write_accesses_87) on tm=
pfs
[  873.336407] dmesg(6323): dirtied inode 12441 (dmesg_next) on tmpfs
[  873.350087] cat(6343): dirtied inode 12450 (write_accesses_88) on tm=
pfs
[  874.583197] diff(6356): dirtied inode 12464 (dmesg_next) on tmpfs
[  874.587686] cat(6366): dirtied inode 12473 (write_accesses_89) on tm=
pfs
[  875.865436] dmesg(6369): dirtied inode 12487 (dmesg_next) on tmpfs
[  876.035963] cat(6389): dirtied inode 12496 (write_accesses_90) on tm=
pfs
[  877.119425] dmesg(6392): dirtied inode 12510 (dmesg_next) on tmpfs
[  877.127382] cat(6412): dirtied inode 12519 (write_accesses_91) on tm=
pfs
[  878.406763] dmesg(6415): dirtied inode 12533 (dmesg_next) on tmpfs
[  878.414927] cat(6436): dirtied inode 12551 (read_accesses_92) on tmp=
fs
[  879.681431] diff(6448): dirtied inode 12556 (dmesg_next) on tmpfs
[  879.685437] cat(6459): dirtied inode 12574 (read_accesses_93) on tmp=
fs
[  880.681493] dmesg(6461): dirtied inode 12579 (dmesg_next) on tmpfs
[  880.781694] cat(6481): dirtied inode 12588 (write_accesses_94) on tm=
pfs
[  881.826690] dmesg(6484): dirtied inode 12602 (dmesg_next) on tmpfs
[  881.833445] cat(6504): dirtied inode 12611 (write_accesses_95) on tm=
pfs
[  883.120460] diff(6508): dirtied inode 12625 (dmesg_next) on tmpfs
[  883.313029] cat(6528): dirtied inode 12643 (read_accesses_96) on tmp=
fs
[  884.333892] dmesg(6530): dirtied inode 12648 (dmesg_next) on tmpfs
[  884.565845] cat(6550): dirtied inode 12657 (write_accesses_97) on tm=
pfs
[  884.565845] cat(6551): dirtied inode 12666 (read_accesses_97) on tmp=
fs
[  885.567901] dmesg(6553): dirtied inode 12671 (dmesg_next) on tmpfs
[  885.975728] cat(6573): dirtied inode 12680 (write_accesses_98) on tm=
pfs
[  886.978005] dmesg(6576): dirtied inode 12694 (dmesg_next) on tmpfs
[  888.451842] diff(6609): dirtied inode 12717 (dmesg_next) on tmpfs
[  888.455842] cat(6619): dirtied inode 12726 (write_accesses_100) on t=
mpfs
[  889.455889] dmesg(6622): dirtied inode 12740 (dmesg_next) on tmpfs
[  889.465359] cat(6642): dirtied inode 12749 (write_accesses_101) on t=
mpfs
[  890.743429] dmesg(6645): dirtied inode 12763 (dmesg_next) on tmpfs
[  890.749394] cat(6665): dirtied inode 12772 (write_accesses_102) on t=
mpfs
[  891.923889] diff(6678): dirtied inode 12786 (dmesg_next) on tmpfs
[  891.928369] cat(6688): dirtied inode 12795 (write_accesses_103) on t=
mpfs
[  892.953018] diff(6692): dirtied inode 12809 (dmesg_next) on tmpfs
[  892.961148] cat(6711): dirtied inode 12818 (write_accesses_104) on t=
mpfs
[  892.961148] cat(6712): dirtied inode 12827 (read_accesses_104) on tm=
pfs
[  894.148519] dmesg(6714): dirtied inode 12832 (dmesg_next) on tmpfs
[  894.454351] cat(6734): dirtied inode 12841 (write_accesses_105) on t=
mpfs
[  895.463549] diff(6747): dirtied inode 12855 (dmesg_next) on tmpfs
[  895.469747] cat(6757): dirtied inode 12864 (write_accesses_106) on t=
mpfs
[  895.471447] cat(6758): dirtied inode 12873 (read_accesses_106) on tm=
pfs
[  896.475375] dmesg(6760): dirtied inode 12878 (dmesg_next) on tmpfs
[  896.488842] cat(6780): dirtied inode 12887 (write_accesses_107) on t=
mpfs
[  897.932945] dmesg(6783): dirtied inode 12901 (dmesg_next) on tmpfs
[  897.942429] cat(6803): dirtied inode 12910 (write_accesses_108) on t=
mpfs
[  899.129500] diff(6807): dirtied inode 12924 (dmesg_next) on tmpfs
[  900.478084] dmesg(6829): dirtied inode 12947 (dmesg_next) on tmpfs
[  900.668040] cat(6849): dirtied inode 12956 (write_accesses_110) on t=
mpfs
[  901.674425] dmesg(6852): dirtied inode 12970 (dmesg_next) on tmpfs
[  902.036836] cat(6872): dirtied inode 12979 (write_accesses_111) on t=
mpfs
[  902.037410] cat(6873): dirtied inode 12988 (read_accesses_111) on tm=
pfs
[  903.224855] dmesg(6875): dirtied inode 12993 (dmesg_next) on tmpfs
[  903.237365] cat(6895): dirtied inode 13002 (write_accesses_112) on t=
mpfs
[  903.237365] cat(6896): dirtied inode 13011 (read_accesses_112) on tm=
pfs
[  904.313117] dmesg(6898): dirtied inode 13016 (dmesg_next) on tmpfs
[  904.323475] cat(6918): dirtied inode 13025 (write_accesses_113) on t=
mpfs
[  905.528059] diff(6931): dirtied inode 13039 (dmesg_next) on tmpfs
[  905.532054] cat(6941): dirtied inode 13048 (write_accesses_114) on t=
mpfs
[  905.532054] cat(6942): dirtied inode 13057 (read_accesses_114) on tm=
pfs
[  906.532110] dmesg(6944): dirtied inode 13062 (dmesg_next) on tmpfs
[  906.540591] cat(6964): dirtied inode 13071 (write_accesses_115) on t=
mpfs
[  907.942817] dmesg(6967): dirtied inode 13085 (dmesg_next) on tmpfs
[  908.134791] cat(6987): dirtied inode 13094 (write_accesses_116) on t=
mpfs
[  909.141043] diff(6991): dirtied inode 13108 (dmesg_next) on tmpfs
[  909.569009] cat(7011): dirtied inode 13126 (read_accesses_117) on tm=
pfs
[  910.598250] dmesg(7013): dirtied inode 13131 (dmesg_next) on tmpfs
[  910.790223] cat(7033): dirtied inode 13140 (write_accesses_118) on t=
mpfs
[  911.792613] dmesg(7036): dirtied inode 13154 (dmesg_next) on tmpfs
[  911.798593] cat(7057): dirtied inode 13172 (read_accesses_119) on tm=
pfs
[  913.238549] diff(7060): dirtied inode 13177 (dmesg_next) on tmpfs
[  913.430521] cat(7080): dirtied inode 13195 (read_accesses_120) on tm=
pfs
[  914.431044] dmesg(7082): dirtied inode 13200 (dmesg_next) on tmpfs
[  914.444501] cat(7102): dirtied inode 13209 (write_accesses_121) on t=
mpfs
[  915.896874] dmesg(7105): dirtied inode 13223 (dmesg_next) on tmpfs
[  916.089267] cat(7125): dirtied inode 13232 (write_accesses_122) on t=
mpfs
[  917.092028] diff(7129): dirtied inode 13246 (dmesg_next) on tmpfs
[  918.116772] dmesg(7151): dirtied inode 13269 (dmesg_next) on tmpfs
[  918.180452] cat(7171): dirtied inode 13278 (write_accesses_124) on t=
mpfs
[  919.186799] dmesg(7174): dirtied inode 13292 (dmesg_next) on tmpfs
[  919.193987] cat(7194): dirtied inode 13301 (write_accesses_125) on t=
mpfs
[  920.682462] diff(7198): dirtied inode 13315 (dmesg_next) on tmpfs
[  920.695417] cat(7218): dirtied inode 13333 (read_accesses_126) on tm=
pfs
[  921.690950] dmesg(7220): dirtied inode 13338 (dmesg_next) on tmpfs
[  921.707828] cat(7240): dirtied inode 13347 (write_accesses_127) on t=
mpfs
[  922.729878] dmesg(7243): dirtied inode 13361 (dmesg_next) on tmpfs
[  922.740940] cat(7263): dirtied inode 13370 (write_accesses_128) on t=
mpfs
[  923.741165] dmesg(7266): dirtied inode 13384 (dmesg_next) on tmpfs
[  923.776489] cat(7286): dirtied inode 13393 (write_accesses_129) on t=
mpfs
[  924.820556] dmesg(7289): dirtied inode 13407 (dmesg_next) on tmpfs
[  924.826641] cat(7309): dirtied inode 13416 (write_accesses_130) on t=
mpfs
[  924.826986] cat(7310): dirtied inode 13425 (read_accesses_130) on tm=
pfs
[  925.838566] diff(7313): dirtied inode 13430 (dmesg_next) on tmpfs
[  925.847562] cat(7332): dirtied inode 13439 (write_accesses_131) on t=
mpfs
[  925.847562] cat(7333): dirtied inode 13448 (read_accesses_131) on tm=
pfs
[  926.849577] dmesg(7335): dirtied inode 13453 (dmesg_next) on tmpfs
[  926.859048] cat(7355): dirtied inode 13462 (write_accesses_132) on t=
mpfs
[  927.866588] diff(7359): dirtied inode 13476 (dmesg_next) on tmpfs
[  928.872937] dmesg(7381): dirtied inode 13499 (dmesg_next) on tmpfs
[  928.957813] cat(7401): dirtied inode 13508 (write_accesses_134) on t=
mpfs
[  929.960702] dmesg(7404): dirtied inode 13522 (dmesg_next) on tmpfs
[  930.049203] cat(7424): dirtied inode 13531 (write_accesses_135) on t=
mpfs
[  931.055243] diff(7428): dirtied inode 13545 (dmesg_next) on tmpfs
[  931.159261] cat(7447): dirtied inode 13554 (write_accesses_136) on t=
mpfs
[  931.165926] cat(7448): dirtied inode 13563 (read_accesses_136) on tm=
pfs
[  932.163431] dmesg(7450): dirtied inode 13568 (dmesg_next) on tmpfs
[  932.276573] cat(7470): dirtied inode 13577 (write_accesses_137) on t=
mpfs
[  933.280961] dmesg(7473): dirtied inode 13591 (dmesg_next) on tmpfs
[  934.295069] diff(7497): dirtied inode 13614 (dmesg_next) on tmpfs
[  934.304461] cat(7517): dirtied inode 13632 (read_accesses_139) on tm=
pfs
[  935.306745] dmesg(7519): dirtied inode 13637 (dmesg_next) on tmpfs
[  935.318188] cat(7539): dirtied inode 13646 (write_accesses_140) on t=
mpfs
[  936.464208] dmesg(7542): dirtied inode 13660 (dmesg_next) on tmpfs
[  936.472676] cat(7562): dirtied inode 13669 (write_accesses_141) on t=
mpfs
[  936.474973] cat(7563): dirtied inode 13678 (read_accesses_141) on tm=
pfs
[  937.475219] dmesg(7565): dirtied inode 13683 (dmesg_next) on tmpfs
[  937.485535] cat(7585): dirtied inode 13692 (write_accesses_142) on t=
mpfs
[  938.654128] diff(7598): dirtied inode 13706 (dmesg_next) on tmpfs
[  938.658362] cat(7608): dirtied inode 13715 (write_accesses_143) on t=
mpfs
[  938.658362] cat(7609): dirtied inode 13724 (read_accesses_143) on tm=
pfs
[  939.655484] dmesg(7611): dirtied inode 13729 (dmesg_next) on tmpfs
[  939.837764] cat(7631): dirtied inode 13738 (write_accesses_144) on t=
mpfs
[  940.840540] dmesg(7634): dirtied inode 13752 (dmesg_next) on tmpfs
[  941.024787] cat(7654): dirtied inode 13761 (write_accesses_145) on t=
mpfs
[  942.032292] diff(7658): dirtied inode 13775 (dmesg_next) on tmpfs
[  942.226107] cat(7677): dirtied inode 13784 (write_accesses_146) on t=
mpfs
[  942.227445] cat(7678): dirtied inode 13793 (read_accesses_146) on tm=
pfs
[  943.228417] dmesg(7680): dirtied inode 13798 (dmesg_next) on tmpfs
[  943.437244] cat(7700): dirtied inode 13807 (write_accesses_147) on t=
mpfs
[  944.446942] diff(7713): dirtied inode 13821 (dmesg_next) on tmpfs
[  944.450943] cat(7723): dirtied inode 13830 (write_accesses_148) on t=
mpfs
[  944.451191] cat(7724): dirtied inode 13839 (read_accesses_148) on tm=
pfs
[  945.451350] dmesg(7726): dirtied inode 13844 (dmesg_next) on tmpfs
[  945.679542] cat(7746): dirtied inode 13853 (write_accesses_149) on t=
mpfs
[  946.682674] dmesg(7749): dirtied inode 13867 (dmesg_next) on tmpfs
[  946.694959] cat(7769): dirtied inode 13876 (write_accesses_150) on t=
mpfs
[  946.694959] cat(7770): dirtied inode 13885 (read_accesses_150) on tm=
pfs
[  947.696845] dmesg(7772): dirtied inode 13890 (dmesg_next) on tmpfs
[  947.944206] cat(7792): dirtied inode 13899 (write_accesses_151) on t=
mpfs
[  949.199015] dmesg(7795): dirtied inode 13913 (dmesg_next) on tmpfs
[  949.208325] cat(7815): dirtied inode 13922 (write_accesses_152) on t=
mpfs
[  949.209994] cat(7816): dirtied inode 13931 (read_accesses_152) on tm=
pfs
[  950.210718] dmesg(7818): dirtied inode 13936 (dmesg_next) on tmpfs
[  950.479007] cat(7838): dirtied inode 13945 (write_accesses_153) on t=
mpfs
[  951.483535] dmesg(7841): dirtied inode 13959 (dmesg_next) on tmpfs
[  951.500419] cat(7861): dirtied inode 13968 (write_accesses_154) on t=
mpfs
[  951.501328] cat(7862): dirtied inode 13977 (read_accesses_154) on tm=
pfs
[  952.499141] dmesg(7864): dirtied inode 13982 (dmesg_next) on tmpfs
[  952.791099] cat(7884): dirtied inode 13991 (write_accesses_155) on t=
mpfs
[  953.792088] dmesg(7887): dirtied inode 14005 (dmesg_next) on tmpfs
[  954.086120] cat(7907): dirtied inode 14014 (write_accesses_156) on t=
mpfs
[  954.086120] cat(7908): dirtied inode 14023 (read_accesses_156) on tm=
pfs
[  955.083730] dmesg(7910): dirtied inode 14028 (dmesg_next) on tmpfs
[  955.395695] cat(7930): dirtied inode 14037 (write_accesses_157) on t=
mpfs
[  956.403171] diff(7934): dirtied inode 14051 (dmesg_next) on tmpfs
[  957.718911] dmesg(7956): dirtied inode 14074 (dmesg_next) on tmpfs
[  958.047199] cat(7976): dirtied inode 14083 (write_accesses_159) on t=
mpfs
[  959.384644] dmesg(7979): dirtied inode 14097 (dmesg_next) on tmpfs
[  959.393293] cat(7999): dirtied inode 14106 (write_accesses_160) on t=
mpfs
[  959.393293] cat(8000): dirtied inode 14115 (read_accesses_160) on tm=
pfs
[  960.397808] dmesg(8002): dirtied inode 14120 (dmesg_next) on tmpfs
[  960.749437] cat(8022): dirtied inode 14129 (write_accesses_161) on t=
mpfs
[  961.749474] dmesg(8025): dirtied inode 14143 (dmesg_next) on tmpfs
[  962.036495] cat(8045): dirtied inode 14152 (write_accesses_162) on t=
mpfs
[  963.045838] diff(8049): dirtied inode 14166 (dmesg_next) on tmpfs
[  963.369862] cat(8069): dirtied inode 14184 (read_accesses_163) on tm=
pfs
[  964.369917] dmesg(8071): dirtied inode 14189 (dmesg_next) on tmpfs
[  964.650787] cat(8091): dirtied inode 14198 (write_accesses_164) on t=
mpfs
[  966.041304] diff(8104): dirtied inode 14212 (dmesg_next) on tmpfs
[  966.044662] cat(8114): dirtied inode 14221 (write_accesses_165) on t=
mpfs
[  966.044662] cat(8115): dirtied inode 14230 (read_accesses_165) on tm=
pfs
[  967.327417] dmesg(8117): dirtied inode 14235 (dmesg_next) on tmpfs
[  967.336909] cat(8137): dirtied inode 14244 (write_accesses_166) on t=
mpfs
[  968.738523] dmesg(8140): dirtied inode 14258 (dmesg_next) on tmpfs
[  968.750517] cat(8160): dirtied inode 14267 (write_accesses_167) on t=
mpfs
[  968.750518] cat(8161): dirtied inode 14276 (read_accesses_167) on tm=
pfs
[  970.160950] dmesg(8163): dirtied inode 14281 (dmesg_next) on tmpfs
[  970.167859] cat(8183): dirtied inode 14290 (write_accesses_168) on t=
mpfs
[  970.167859] cat(8184): dirtied inode 14299 (read_accesses_168) on tm=
pfs
[  971.176979] diff(8187): dirtied inode 14304 (dmesg_next) on tmpfs
[  971.493459] cat(8206): dirtied inode 14313 (write_accesses_169) on t=
mpfs
[  971.494797] cat(8207): dirtied inode 14322 (read_accesses_169) on tm=
pfs
[  972.494708] dmesg(8209): dirtied inode 14327 (dmesg_next) on tmpfs
[  972.779455] cat(8229): dirtied inode 14336 (write_accesses_170) on t=
mpfs
[  974.221475] dmesg(8232): dirtied inode 14350 (dmesg_next) on tmpfs
[  974.232225] cat(8252): dirtied inode 14359 (write_accesses_171) on t=
mpfs
[  975.234989] dmesg(8255): dirtied inode 14373 (dmesg_next) on tmpfs
[  975.521707] cat(8275): dirtied inode 14382 (write_accesses_172) on t=
mpfs
[  975.525291] cat(8276): dirtied inode 14391 (read_accesses_172) on tm=
pfs
[  976.525295] dmesg(8278): dirtied inode 14396 (dmesg_next) on tmpfs
[  976.533286] cat(8298): dirtied inode 14405 (write_accesses_173) on t=
mpfs
[  978.133621] dmesg(8301): dirtied inode 14419 (dmesg_next) on tmpfs
[  978.137822] cat(8321): dirtied inode 14428 (write_accesses_174) on t=
mpfs
[  978.146712] cat(8322): dirtied inode 14436 (read_accesses_174) on tm=
pfs
[  979.156111] dmesg(8324): dirtied inode 14442 (dmesg_next) on tmpfs
[  979.644117] cat(8344): dirtied inode 14451 (write_accesses_175) on t=
mpfs
[  979.644117] cat(8345): dirtied inode 14460 (read_accesses_175) on tm=
pfs
[  980.647899] dmesg(8347): dirtied inode 14465 (dmesg_next) on tmpfs
[  980.928226] cat(8367): dirtied inode 14474 (write_accesses_176) on t=
mpfs
[  982.389789] dmesg(8370): dirtied inode 14488 (dmesg_next) on tmpfs
[  982.396784] cat(8391): dirtied inode 14506 (read_accesses_177) on tm=
pfs
[  983.640010] dmesg(8393): dirtied inode 14511 (dmesg_next) on tmpfs
[  983.648527] cat(8413): dirtied inode 14520 (write_accesses_178) on t=
mpfs
[  984.928878] diff(8417): dirtied inode 14534 (dmesg_next) on tmpfs
[  984.953420] cat(8436): dirtied inode 14543 (write_accesses_179) on t=
mpfs
[  984.953420] cat(8437): dirtied inode 14552 (read_accesses_179) on tm=
pfs
[  986.179928] dmesg(8439): dirtied inode 14557 (dmesg_next) on tmpfs
[  986.224383] cat(8459): dirtied inode 14566 (write_accesses_180) on t=
mpfs
[  987.472835] dmesg(8462): dirtied inode 14580 (dmesg_next) on tmpfs
[  987.521909] cat(8483): dirtied inode 14598 (read_accesses_181) on tm=
pfs
[  988.928533] diff(8486): dirtied inode 14603 (dmesg_next) on tmpfs
[  988.937100] cat(8505): dirtied inode 14612 (write_accesses_182) on t=
mpfs
[  988.937100] cat(8506): dirtied inode 14621 (read_accesses_182) on tm=
pfs
[  990.184049] dmesg(8508): dirtied inode 14626 (dmesg_next) on tmpfs
[  990.248815] cat(8528): dirtied inode 14635 (write_accesses_183) on t=
mpfs
[  990.248815] cat(8529): dirtied inode 14644 (read_accesses_183) on tm=
pfs
[  991.255227] diff(8532): dirtied inode 14649 (dmesg_next) on tmpfs
[  991.335832] cat(8551): dirtied inode 14658 (write_accesses_184) on t=
mpfs
[  991.335832] cat(8552): dirtied inode 14667 (read_accesses_184) on tm=
pfs
[  992.547850] dmesg(8554): dirtied inode 14672 (dmesg_next) on tmpfs
[  992.632049] cat(8574): dirtied inode 14681 (write_accesses_185) on t=
mpfs
[  993.801989] diff(8578): dirtied inode 14695 (dmesg_next) on tmpfs
[  993.901940] cat(8597): dirtied inode 14704 (write_accesses_186) on t=
mpfs
[  993.901941] cat(8598): dirtied inode 14713 (read_accesses_186) on tm=
pfs
[  995.256871] dmesg(8600): dirtied inode 14718 (dmesg_next) on tmpfs
[  995.361070] cat(8620): dirtied inode 14727 (write_accesses_187) on t=
mpfs
[  995.364675] cat(8621): dirtied inode 14736 (read_accesses_187) on tm=
pfs
[  996.508669] dmesg(8623): dirtied inode 14741 (dmesg_next) on tmpfs
[  996.522148] cat(8643): dirtied inode 14750 (write_accesses_188) on t=
mpfs
[  997.800277] dmesg(8646): dirtied inode 14764 (dmesg_next) on tmpfs
[  997.928756] cat(8667): dirtied inode 14782 (read_accesses_189) on tm=
pfs
[  999.050046] diff(8670): dirtied inode 14787 (dmesg_next) on tmpfs
[  999.058544] cat(8689): dirtied inode 14796 (write_accesses_190) on t=
mpfs
[  999.058544] cat(8690): dirtied inode 14805 (read_accesses_190) on tm=
pfs
[ 1000.340517] dmesg(8692): dirtied inode 14810 (dmesg_next) on tmpfs
[ 1000.485140] cat(8712): dirtied inode 14819 (write_accesses_191) on t=
mpfs
[ 1001.792331] diff(8716): dirtied inode 14833 (dmesg_next) on tmpfs
[ 1001.803447] cat(8735): dirtied inode 14842 (write_accesses_192) on t=
mpfs
[ 1001.803447] cat(8736): dirtied inode 14851 (read_accesses_192) on tm=
pfs
[ 1002.807779] dmesg(8738): dirtied inode 14856 (dmesg_next) on tmpfs
[ 1003.105616] cat(8758): dirtied inode 14865 (write_accesses_193) on t=
mpfs
[ 1004.356278] diff(8762): dirtied inode 14879 (dmesg_next) on tmpfs
[ 1004.364209] cat(8781): dirtied inode 14888 (write_accesses_194) on t=
mpfs
[ 1004.364209] cat(8782): dirtied inode 14897 (read_accesses_194) on tm=
pfs
[ 1005.483712] dmesg(8784): dirtied inode 14902 (dmesg_next) on tmpfs
[ 1005.668700] cat(8804): dirtied inode 14911 (write_accesses_195) on t=
mpfs
[ 1005.668700] cat(8805): dirtied inode 14920 (read_accesses_195) on tm=
pfs
[ 1006.676699] dmesg(8807): dirtied inode 14925 (dmesg_next) on tmpfs
[ 1006.927200] cat(8827): dirtied inode 14934 (write_accesses_196) on t=
mpfs
[ 1008.188428] diff(8831): dirtied inode 14948 (dmesg_next) on tmpfs
[ 1008.376763] cat(8850): dirtied inode 14957 (write_accesses_197) on t=
mpfs
[ 1008.377992] cat(8851): dirtied inode 14966 (read_accesses_197) on tm=
pfs
[ 1009.421522] dmesg(8853): dirtied inode 14971 (dmesg_next) on tmpfs
[ 1009.430030] cat(8873): dirtied inode 14980 (write_accesses_198) on t=
mpfs
[ 1010.711071] diff(8877): dirtied inode 14994 (dmesg_next) on tmpfs
[ 1010.899186] cat(8896): dirtied inode 15003 (write_accesses_199) on t=
mpfs
[ 1010.900412] cat(8897): dirtied inode 15012 (read_accesses_199) on tm=
pfs
[ 1011.922168] dmesg(8899): dirtied inode 15017 (dmesg_next) on tmpfs
[ 1012.160934] cat(8919): dirtied inode 15026 (write_accesses_200) on t=
mpfs
[ 1013.211452] diff(8923): dirtied inode 15040 (dmesg_next) on tmpfs
[ 1013.403982] cat(8942): dirtied inode 15049 (write_accesses_201) on t=
mpfs
[ 1013.403982] cat(8943): dirtied inode 15058 (read_accesses_201) on tm=
pfs
[ 1014.599561] dmesg(8945): dirtied inode 15063 (dmesg_next) on tmpfs
[ 1014.605093] cat(8965): dirtied inode 15072 (write_accesses_202) on t=
mpfs
[ 1015.653317] dmesg(8968): dirtied inode 15086 (dmesg_next) on tmpfs
[ 1015.660059] cat(8988): dirtied inode 15095 (write_accesses_203) on t=
mpfs
[ 1015.665106] cat(8989): dirtied inode 15104 (read_accesses_203) on tm=
pfs
[ 1016.665570] dmesg(8991): dirtied inode 15109 (dmesg_next) on tmpfs
[ 1016.675081] cat(9011): dirtied inode 15118 (write_accesses_204) on t=
mpfs
[ 1017.956111] dmesg(9014): dirtied inode 15132 (dmesg_next) on tmpfs
[ 1017.962127] cat(9034): dirtied inode 15141 (write_accesses_205) on t=
mpfs
[ 1017.963895] cat(9035): dirtied inode 15150 (read_accesses_205) on tm=
pfs
[ 1018.969674] diff(9038): dirtied inode 15155 (dmesg_next) on tmpfs
[ 1018.976266] cat(9057): dirtied inode 15164 (write_accesses_206) on t=
mpfs
[ 1018.976266] cat(9058): dirtied inode 15173 (read_accesses_206) on tm=
pfs
[ 1020.426869] dmesg(9060): dirtied inode 15178 (dmesg_next) on tmpfs
[ 1020.618849] cat(9081): dirtied inode 15196 (read_accesses_207) on tm=
pfs
[ 1021.626849] dmesg(9083): dirtied inode 15201 (dmesg_next) on tmpfs
[ 1021.942813] cat(9103): dirtied inode 15210 (write_accesses_208) on t=
mpfs
[ 1021.942813] cat(9104): dirtied inode 15219 (read_accesses_208) on tm=
pfs
[ 1022.945266] dmesg(9106): dirtied inode 15224 (dmesg_next) on tmpfs
[ 1022.953861] cat(9126): dirtied inode 15233 (write_accesses_209) on t=
mpfs
[ 1022.957645] cat(9127): dirtied inode 15242 (read_accesses_209) on tm=
pfs
[ 1023.963691] diff(9130): dirtied inode 15247 (dmesg_next) on tmpfs
[ 1023.970181] cat(9149): dirtied inode 15256 (write_accesses_210) on t=
mpfs
[ 1023.970181] cat(9150): dirtied inode 15265 (read_accesses_210) on tm=
pfs
[ 1025.301905] dmesg(9152): dirtied inode 15270 (dmesg_next) on tmpfs
[ 1026.620938] diff(9176): dirtied inode 15293 (dmesg_next) on tmpfs
[ 1026.628590] cat(9195): dirtied inode 15302 (write_accesses_212) on t=
mpfs
[ 1026.628590] cat(9196): dirtied inode 15311 (read_accesses_212) on tm=
pfs
[ 1027.629981] dmesg(9198): dirtied inode 15316 (dmesg_next) on tmpfs
[ 1027.823194] cat(9218): dirtied inode 15325 (write_accesses_213) on t=
mpfs
[ 1027.823562] cat(9219): dirtied inode 15334 (read_accesses_213) on tm=
pfs
[ 1028.831105] dmesg(9221): dirtied inode 15339 (dmesg_next) on tmpfs
[ 1029.206013] cat(9241): dirtied inode 15348 (write_accesses_214) on t=
mpfs
[ 1029.206038] cat(9242): dirtied inode 15357 (read_accesses_214) on tm=
pfs
[ 1030.396448] dmesg(9244): dirtied inode 15362 (dmesg_next) on tmpfs
[ 1030.401416] cat(9264): dirtied inode 15371 (write_accesses_215) on t=
mpfs
[ 1030.401416] cat(9265): dirtied inode 15380 (read_accesses_215) on tm=
pfs
[ 1031.403869] dmesg(9267): dirtied inode 15385 (dmesg_next) on tmpfs
[ 1031.415660] cat(9287): dirtied inode 15394 (write_accesses_216) on t=
mpfs
[ 1031.415660] cat(9288): dirtied inode 15403 (read_accesses_216) on tm=
pfs
[ 1032.804163] dmesg(9290): dirtied inode 15408 (dmesg_next) on tmpfs
[ 1033.055856] cat(9310): dirtied inode 15417 (write_accesses_217) on t=
mpfs
[ 1034.471872] dmesg(9313): dirtied inode 15431 (dmesg_next) on tmpfs
[ 1034.477084] cat(9333): dirtied inode 15440 (write_accesses_218) on t=
mpfs
[ 1034.484714] cat(9334): dirtied inode 15449 (read_accesses_218) on tm=
pfs
[ 1035.486685] dmesg(9336): dirtied inode 15454 (dmesg_next) on tmpfs
[ 1035.679219] cat(9356): dirtied inode 15463 (write_accesses_219) on t=
mpfs
[ 1036.681651] diff(9360): dirtied inode 15477 (dmesg_next) on tmpfs
[ 1037.122902] cat(9379): dirtied inode 15486 (write_accesses_220) on t=
mpfs
[ 1189.246874] md: md4 stopped.
[ 1189.840012] md: bind<sdb3>
[ 1189.840354] md: bind<sdd3>
[ 1189.840354] md: bind<sde3>
[ 1189.842512] md: bind<sdc3>
[ 1189.842512] md: bind<sdf3>
[ 1189.844013] md: bind<sda3>
[ 1189.875071] raid10: raid set md4 active with 6 out of 6 devices
[ 1198.982375] Filesystem "dm-0": Disabling barriers, not supported by=20
the underlying device
[ 1198.987373] XFS mounting filesystem dm-0
[ 1200.519856] Ending clean XFS mount for filesystem: dm-0
[ 1200.535852] Filesystem "dm-1": Disabling barriers, not supported by=20
the underlying device
[ 1200.587852] XFS mounting filesystem dm-1
[ 1200.977207] Ending clean XFS mount for filesystem: dm-1
[ 1200.987164] ReiserFS: dm-2: found reiserfs format "3.6" with standar=
d=20
journal
[ 1200.987164] ReiserFS: dm-2: using ordered data mode
[ 1201.071161] ReiserFS: dm-2: journal params: device dm-2, size 8192,=20
journal first block 18, max trans len 1024, max batch 900, max commit=20
age 30, max trans age 30
[ 1201.071640] ReiserFS: dm-2: checking transaction log (dm-2)
[ 1201.125097] ReiserFS: dm-2: Using r5 hash to sort names
[ 1281.909362] mtrr: type mismatch for d0000000,8000000 old: write-back=
=20
new: write-combining
[ 1374.622166] r8169: eth0: link up
[ 1385.653696] eth0: no IPv6 routers present
[ 2162.274814] mtrr: type mismatch for d0000000,8000000 old: write-back=
=20
new: write-combining
[ 2277.379373] md: md4 stopped.
[ 2277.379428] md: unbind<sda3>
[ 2277.379473] md: export_rdev(sda3)
[ 2277.379522] md: unbind<sdf3>
[ 2277.379565] md: export_rdev(sdf3)
[ 2277.379612] md: unbind<sdc3>
[ 2277.379656] md: export_rdev(sdc3)
[ 2277.379702] md: unbind<sde3>
[ 2277.379745] md: export_rdev(sde3)
[ 2277.379792] md: unbind<sdd3>
[ 2277.379842] md: export_rdev(sdd3)
[ 2277.379890] md: unbind<sdb3>
[ 2277.379933] md: export_rdev(sdb3)
[ 2304.355772] ata6.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.355772] ata4.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.355772] ata4.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.355772] ata4: SError: { PHYRdyChg CommWake }
[ 2304.355772] ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.355772]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.355772] ata4.00: status: { DRDY }
[ 2304.355772] ata4: hard resetting link
[ 2304.896743] ata5.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.896743] ata5.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.896743] ata5: SError: { PHYRdyChg CommWake }
[ 2304.896743] ata5.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.896743]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.896743] ata5.00: status: { DRDY }
[ 2304.896743] ata5: hard resetting link
[ 2304.896743] ata6.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.896789] ata6: SError: { PHYRdyChg CommWake }
[ 2304.896835] ata6.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.896836]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.896939] ata6.00: status: { DRDY }
[ 2304.896984] ata6: hard resetting link
[ 2304.897035] ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.897093] ata3.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.897138] ata3: SError: { PHYRdyChg CommWake }
[ 2304.897184] ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.897185]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.897288] ata3.00: status: { DRDY }
[ 2304.897332] ata3: hard resetting link
[ 2304.897381] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 2304.897439] ata2.00: irq_stat 0x00400001, PHY RDY changed
[ 2304.897485] ata2: SError: { PHYRdyChg CommWake }
[ 2304.897530] ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2304.897531]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 2304.897634] ata2.00: status: { DRDY }
[ 2304.897679] ata2: hard resetting link
[ 2305.832653] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.832656] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.837489] ata4.00: configured for UDMA/133
[ 2305.837489] ata4: EH complete
[ 2305.837489] ata5.00: configured for UDMA/133
[ 2305.837489] sd 3:0:0:0: [sdd] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.837489] sd 3:0:0:0: [sdd] Write Protect is off
[ 2305.837489] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2305.837489] sd 3:0:0:0: [sdd] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.837489] ata5: EH complete
[ 2305.837489] sd 4:0:0:0: [sde] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.837489] sd 4:0:0:0: [sde] Write Protect is off
[ 2305.837489] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2305.837489] sd 4:0:0:0: [sde] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.841497] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.841556] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.841615] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2305.841615] ata3.00: configured for UDMA/133
[ 2305.841615] ata3: EH complete
[ 2305.841615] ata2.00: configured for UDMA/133
[ 2305.841615] sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.841615] sd 2:0:0:0: [sdc] Write Protect is off
[ 2305.841615] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2305.841615] sd 2:0:0:0: [sdc] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.845240] ata6.00: configured for UDMA/133
[ 2305.845240] ata6: EH complete
[ 2305.841615] ata2: EH complete
[ 2305.841615] sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.841615] sd 1:0:0:0: [sdb] Write Protect is off
[ 2305.841615] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2305.841615] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.841694] sd 5:0:0:0: [sdf] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2305.845240] sd 5:0:0:0: [sdf] Write Protect is off
[ 2305.845284] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2305.845299] sd 5:0:0:0: [sdf] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2305.852738] end_request: I/O error, dev sdd, sector 19534911
[ 2305.852738] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.852738] raid1: Disk failure on sdd1, disabling device.
[ 2305.852738] raid1: Operation continuing on 5 devices.
[ 2305.852738] end_request: I/O error, dev sdf, sector 19534911
[ 2305.852738] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.852738] raid1: Disk failure on sdf1, disabling device.
[ 2305.852738] raid1: Operation continuing on 4 devices.
[ 2305.853240] end_request: I/O error, dev sdc, sector 19534911
[ 2305.853240] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.853240] raid1: Disk failure on sdc1, disabling device.
[ 2305.853240] raid1: Operation continuing on 3 devices.
[ 2305.841615] end_request: I/O error, dev sde, sector 19534911
[ 2305.841615] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.841615] raid1: Disk failure on sde1, disabling device.
[ 2305.841615] raid1: Operation continuing on 2 devices.
[ 2305.857144] end_request: I/O error, dev sdb, sector 19534911
[ 2305.857144] md: super_written gets error=3D-5, uptodate=3D0
[ 2305.857144] raid1: Disk failure on sdb1, disabling device.
[ 2305.857144] raid1: Operation continuing on 1 devices.
[ 2305.872898] RAID1 conf printout:
[ 2305.872898]  --- wd:1 rd:6
[ 2305.872898]  disk 0, wo:0, o:1, dev:sda1
[ 2305.872898]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.872898]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.872898]  disk 3, wo:1, o:0, dev:sde1
[ 2305.872898]  disk 4, wo:1, o:0, dev:sdc1
[ 2305.872898]  disk 5, wo:1, o:0, dev:sdf1
[ 2305.881242] RAID1 conf printout:
[ 2305.881286]  --- wd:1 rd:6
[ 2305.881330]  disk 0, wo:0, o:1, dev:sda1
[ 2305.881379]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.881423]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.881466]  disk 3, wo:1, o:0, dev:sde1
[ 2305.881510]  disk 4, wo:1, o:0, dev:sdc1
[ 2305.881557] RAID1 conf printout:
[ 2305.881599]  --- wd:1 rd:6
[ 2305.881641]  disk 0, wo:0, o:1, dev:sda1
[ 2305.881684]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.881728]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.881772]  disk 3, wo:1, o:0, dev:sde1
[ 2305.881815]  disk 4, wo:1, o:0, dev:sdc1
[ 2305.893241] RAID1 conf printout:
[ 2305.893285]  --- wd:1 rd:6
[ 2305.893328]  disk 0, wo:0, o:1, dev:sda1
[ 2305.893376]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.893418]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.893462]  disk 3, wo:1, o:0, dev:sde1
[ 2305.893506] RAID1 conf printout:
[ 2305.893548]  --- wd:1 rd:6
[ 2305.893589]  disk 0, wo:0, o:1, dev:sda1
[ 2305.893633]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.893676]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.893719]  disk 3, wo:1, o:0, dev:sde1
[ 2305.905242] RAID1 conf printout:
[ 2305.905285]  --- wd:1 rd:6
[ 2305.905329]  disk 0, wo:0, o:1, dev:sda1
[ 2305.905376]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.905418]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.905463] RAID1 conf printout:
[ 2305.905505]  --- wd:1 rd:6
[ 2305.905546]  disk 0, wo:0, o:1, dev:sda1
[ 2305.905590]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.905633]  disk 2, wo:1, o:0, dev:sdd1
[ 2305.917241] RAID1 conf printout:
[ 2305.917284]  --- wd:1 rd:6
[ 2305.917328]  disk 0, wo:0, o:1, dev:sda1
[ 2305.917374]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.917417] RAID1 conf printout:
[ 2305.917460]  --- wd:1 rd:6
[ 2305.917501]  disk 0, wo:0, o:1, dev:sda1
[ 2305.917544]  disk 1, wo:1, o:0, dev:sdb1
[ 2305.929241] RAID1 conf printout:
[ 2305.929284]  --- wd:1 rd:6
[ 2305.929328]  disk 0, wo:0, o:1, dev:sda1
[ 2505.989204] md: md3 still in use.
[ 2521.148651] md: unbind<sdc1>
[ 2521.148651] md: export_rdev(sdc1)
[ 2537.045017] md: unbind<sdf1>
[ 2537.045017] md: export_rdev(sdf1)
[ 2537.070370] md: unbind<sde1>
[ 2537.070370] md: export_rdev(sde1)
[ 2537.812473] md: unbind<sdd1>
[ 2537.812524] md: export_rdev(sdd1)
[ 2537.822335] md: unbind<sdb1>
[ 2537.822335] md: export_rdev(sdb1)
[ 2565.680914] md: bind<sdf1>
[ 2565.722761] RAID1 conf printout:
[ 2565.722761]  --- wd:1 rd:6
[ 2565.722761]  disk 0, wo:0, o:1, dev:sda1
[ 2565.722761]  disk 1, wo:1, o:1, dev:sdf1
[ 2565.724253] md: recovery of RAID array md3
[ 2565.724253] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[ 2565.724253] md: using maximum available idle IO bandwidth (but not=20
more than 200000 KB/sec) for recovery.
[ 2565.724253] md: using 128k window, over a total of 9767424 blocks.
[ 2565.876674] md: bind<sde1>
[ 2565.995415] md: bind<sdd1>
[ 2566.057634] md: bind<sdb1>
[ 2566.101549] md: bind<sdc1>
[ 2782.657615] md: md3: recovery done.
[ 2783.368035] RAID1 conf printout:
[ 2783.368035]  --- wd:2 rd:6
[ 2783.368035]  disk 0, wo:0, o:1, dev:sda1
[ 2783.368035]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.555376] RAID1 conf printout:
[ 2783.555423]  --- wd:2 rd:6
[ 2783.555467]  disk 0, wo:0, o:1, dev:sda1
[ 2783.555533]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.555576]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.555625] RAID1 conf printout:
[ 2783.555667]  --- wd:2 rd:6
[ 2783.555708]  disk 0, wo:0, o:1, dev:sda1
[ 2783.555751]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.555794]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.555837]  disk 3, wo:1, o:1, dev:sdb1
[ 2783.555882] RAID1 conf printout:
[ 2783.555924]  --- wd:2 rd:6
[ 2783.555966]  disk 0, wo:0, o:1, dev:sda1
[ 2783.559532]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.559532]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.559532]  disk 3, wo:1, o:1, dev:sdb1
[ 2783.559532]  disk 4, wo:1, o:1, dev:sdd1
[ 2783.559532] RAID1 conf printout:
[ 2783.559532]  --- wd:2 rd:6
[ 2783.559532]  disk 0, wo:0, o:1, dev:sda1
[ 2783.559532]  disk 1, wo:0, o:1, dev:sdf1
[ 2783.559532]  disk 2, wo:1, o:1, dev:sdc1
[ 2783.559532]  disk 3, wo:1, o:1, dev:sdb1
[ 2783.559532]  disk 4, wo:1, o:1, dev:sdd1
[ 2783.559532]  disk 5, wo:1, o:1, dev:sde1
[ 2783.559532] md: recovery of RAID array md3
[ 2783.559532] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[ 2783.559532] md: using maximum available idle IO bandwidth (but not=20
more than 200000 KB/sec) for recovery.
[ 2783.559532] md: using 128k window, over a total of 9767424 blocks.
[ 2977.087799] ata1.00: exception Emask 0x10 SAct 0x7 SErr 0x50000=20
action 0xe frozen
[ 2977.087860] ata1.00: irq_stat 0x00400008, PHY RDY changed
[ 2977.087908] ata1: SError: { PHYRdyChg CommWake }
[ 2977.087957] ata1.00: cmd 60/80:00:bf:d8:dc/00:00:00:00:00/40 tag 0=20
ncq 65536 in
[ 2977.087958]          res 40/00:14:bf:d9:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2977.088077] ata1.00: status: { DRDY }
[ 2977.088123] ata1.00: cmd 60/80:08:3f:d9:dc/00:00:00:00:00/40 tag 1=20
ncq 65536 in
[ 2977.088124]          res 40/00:14:bf:d9:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2977.088245] ata1.00: status: { DRDY }
[ 2977.088292] ata1.00: cmd 60/80:10:bf:d9:dc/00:00:00:00:00/40 tag 2=20
ncq 65536 in
[ 2977.088293]          res 40/00:14:bf:d9:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2977.088412] ata1.00: status: { DRDY }
[ 2977.088462] ata1: hard resetting link
[ 2977.107904] ata4.00: exception Emask 0x10 SAct 0x20 SErr 0x10000=20
action 0xe frozen
[ 2977.107904] ata4.00: irq_stat 0x00400008, PHY RDY changed
[ 2977.107904] ata4: SError: { PHYRdyChg }
[ 2977.107904] ata4.00: cmd 61/00:28:bf:d7:dc/01:00:00:00:00/40 tag 5=20
ncq 131072 out
[ 2977.107904]          res 40/00:2c:bf:d7:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2977.107904] ata4.00: status: { DRDY }
[ 2977.107904] ata4: hard resetting link
[ 2977.973953] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2977.973943] ata1.00: configured for UDMA/133
[ 2977.973943] ata1: EH complete
[ 2977.978160] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2977.978160] sd 0:0:0:0: [sda] Write Protect is off
[ 2977.978160] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 2977.978160] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2977.978160] ata5.00: exception Emask 0x10 SAct 0x3 SErr 0x50000=20
action 0xe frozen
[ 2978.028686] ata3.00: exception Emask 0x10 SAct 0x3 SErr 0x50000=20
action 0xe frozen
[ 2978.028686] ata3.00: irq_stat 0x00400008, PHY RDY changed
[ 2978.028686] ata3: SError: { PHYRdyChg CommWake }
[ 2978.028686] ata3.00: cmd 61/80:00:bf:d8:dc/00:00:00:00:00/40 tag 0=20
ncq 65536 out
[ 2978.028686]          res 40/00:0c:3f:d9:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2978.028686] ata3.00: status: { DRDY }
[ 2978.028686] ata3.00: cmd 61/80:08:3f:d9:dc/00:00:00:00:00/40 tag 1=20
ncq 65536 out
[ 2978.028686]          res 40/00:0c:3f:d9:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2978.028686] ata3.00: status: { DRDY }
[ 2978.028686] ata3: hard resetting link
[ 2977.978160] ata5.00: irq_stat 0x00400008, PHY RDY changed
[ 2977.978160] ata5: SError: { PHYRdyChg CommWake }
[ 2977.978160] ata5.00: cmd 61/80:00:bf:d8:dc/00:00:00:00:00/40 tag 0=20
ncq 65536 out
[ 2977.978160]          res 40/00:0c:3f:d9:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2977.978160] ata5.00: status: { DRDY }
[ 2977.978160] ata5.00: cmd 61/80:08:3f:d9:dc/00:00:00:00:00/40 tag 1=20
ncq 65536 out
[ 2977.978160]          res 40/00:0c:3f:d9:dc/00:00:00:00:00/40 Emask=20
0x10 (ATA bus error)
[ 2977.978160] ata5.00: status: { DRDY }
[ 2977.978160] ata5: hard resetting link
[ 2978.034941] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2978.039874] ata4.00: configured for UDMA/133
[ 2978.039874] ata4: EH complete
[ 2978.039874] sd 3:0:0:0: [sdd] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2978.039874] sd 3:0:0:0: [sdd] Write Protect is off
[ 2978.039874] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2978.039874] sd 3:0:0:0: [sdd] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2978.914449] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2978.915221] ata5.00: configured for UDMA/133
[ 2978.915221] ata5: EH complete
[ 2978.915221] sd 4:0:0:0: [sde] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2978.915221] sd 4:0:0:0: [sde] Write Protect is off
[ 2978.915221] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2978.915221] sd 4:0:0:0: [sde] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 2978.922939] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2978.922929] ata3.00: configured for UDMA/133
[ 2978.922929] ata3: EH complete
[ 2978.915221] sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 2978.915221] sd 2:0:0:0: [sdc] Write Protect is off
[ 2978.915221] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2978.915221] sd 2:0:0:0: [sdc] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 3046.343693] md: md3: recovery done.
[ 3046.387694] ata6.00: exception Emask 0x10 SAct 0x0 SErr 0x50000=20
action 0xe frozen
[ 3046.387694] ata6.00: irq_stat 0x00400001, PHY RDY changed
[ 3046.387694] ata6: SError: { PHYRdyChg CommWake }
[ 3046.387694] ata6.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 3046.387694]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask=20
0x10 (ATA bus error)
[ 3046.387694] ata6.00: status: { DRDY }
[ 3046.387694] ata6: hard resetting link
[ 3047.561017] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3047.613497] ata6.00: configured for UDMA/133
[ 3047.613497] ata6: EH complete
[ 3047.613497] sd 5:0:0:0: [sdf] 1465149168 512-byte hardware sectors=20
(750156 MB)
[ 3047.613497] sd 5:0:0:0: [sdf] Write Protect is off
[ 3047.613497] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 3047.613497] sd 5:0:0:0: [sdf] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[ 3047.613497] end_request: I/O error, dev sdf, sector 19534911
[ 3047.613497] md: super_written gets error=3D-5, uptodate=3D0
[ 3047.613497] raid1: Disk failure on sdf1, disabling device.
[ 3047.613497] raid1: Operation continuing on 1 devices.
[ 3047.645706] RAID1 conf printout:
[ 3047.645706]  --- wd:1 rd:6
[ 3047.645706]  disk 0, wo:0, o:1, dev:sda1
[ 3047.645706]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.645706]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.645706]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.645706]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.645733]  disk 5, wo:1, o:1, dev:sde1
[ 3047.646775] RAID1 conf printout:
[ 3047.646817]  --- wd:1 rd:6
[ 3047.646858]  disk 0, wo:0, o:1, dev:sda1
[ 3047.646902]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.646945]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.646988]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.647031]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.647074]  disk 5, wo:1, o:1, dev:sde1
[ 3047.647117] RAID1 conf printout:
[ 3047.647159]  --- wd:1 rd:6
[ 3047.654048]  disk 0, wo:0, o:1, dev:sda1
[ 3047.654091]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.654134]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.654177]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.654220]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.654263]  disk 5, wo:1, o:1, dev:sde1
[ 3047.654306] RAID1 conf printout:
[ 3047.654348]  --- wd:1 rd:6
[ 3047.654390]  disk 0, wo:0, o:1, dev:sda1
[ 3047.654433]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.654476]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.654519]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.654568]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.654611]  disk 5, wo:1, o:1, dev:sde1
[ 3047.654654] RAID1 conf printout:
[ 3047.654696]  --- wd:1 rd:6
[ 3047.654738]  disk 0, wo:0, o:1, dev:sda1
[ 3047.654781]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.654825]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.654867]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.654911]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.654953]  disk 5, wo:1, o:1, dev:sde1
[ 3047.654996] RAID1 conf printout:
[ 3047.655039]  --- wd:1 rd:6
[ 3047.655080]  disk 0, wo:0, o:1, dev:sda1
[ 3047.655123]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.655167]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.655209]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.655252]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.655296]  disk 5, wo:1, o:1, dev:sde1
[ 3047.655338] RAID1 conf printout:
[ 3047.655380]  --- wd:1 rd:6
[ 3047.655422]  disk 0, wo:0, o:1, dev:sda1
[ 3047.655465]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.655508]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.655551]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.655594]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.655637]  disk 5, wo:1, o:1, dev:sde1
[ 3047.655637] RAID1 conf printout:
[ 3047.655637]  --- wd:1 rd:6
[ 3047.655637]  disk 0, wo:0, o:1, dev:sda1
[ 3047.655637]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.655637]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.655637]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.655637]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.655637]  disk 5, wo:1, o:1, dev:sde1
[ 3047.655637] RAID1 conf printout:
[ 3047.655637]  --- wd:1 rd:6
[ 3047.655637]  disk 0, wo:0, o:1, dev:sda1
[ 3047.655637]  disk 1, wo:1, o:0, dev:sdf1
[ 3047.655637]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.655637]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.655637]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.655637]  disk 5, wo:1, o:1, dev:sde1
[ 3047.664791] RAID1 conf printout:
[ 3047.664835]  --- wd:1 rd:6
[ 3047.664878]  disk 0, wo:0, o:1, dev:sda1
[ 3047.664926]  disk 2, wo:1, o:1, dev:sdc1
[ 3047.664969]  disk 3, wo:1, o:1, dev:sdb1
[ 3047.665011]  disk 4, wo:1, o:1, dev:sdd1
[ 3047.665055]  disk 5, wo:1, o:1, dev:sde1
[ 3047.666439] md: recovery of RAID array md3
[ 3047.666439] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[ 3047.666439] md: using maximum available idle IO bandwidth (but not=20
more than 200000 KB/sec) for recovery.
[ 3047.666439] md: using 128k window, over a total of 9767424 blocks.
[ 3047.666439] md: resuming recovery of md3 from checkpoint.
[ 3047.666439] md: md3: recovery done.
[ 3047.677522] RAID1 conf printout:
[ 3047.681637]  --- wd:5 rd:6
[ 3047.681679]  disk 0, wo:0, o:1, dev:sda1
[ 3047.681722]  disk 2, wo:0, o:1, dev:sdc1
[ 3047.681765]  disk 3, wo:0, o:1, dev:sdb1
[ 3047.681808]  disk 4, wo:0, o:1, dev:sdd1
[ 3047.681851]  disk 5, wo:0, o:1, dev:sde1

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.26
# Thu Aug 28 10:24:09 2008
#
CONFIG_64BIT=3Dy
# CONFIG_X86_32 is not set
CONFIG_X86_64=3Dy
CONFIG_X86=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
# CONFIG_GENERIC_LOCKBREAK is not set
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_FAST_CMPXCHG_LOCAL=3Dy
CONFIG_MMU=3Dy
CONFIG_ZONE_DMA=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
# CONFIG_GENERIC_GPIO is not set
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_ARCH_HAS_CPU_RELAX=3Dy
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_HAVE_CPUMASK_OF_CPU_MAP=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
CONFIG_ZONE_DMA32=3Dy
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_ARCH_SUPPORTS_AOUT=3Dy
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy
CONFIG_X86_SMP=3Dy
CONFIG_X86_64_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_X86_TRAMPOLINE=3Dy
# CONFIG_KTIME_SCALAR is not set
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_AUDIT_TREE=3Dy
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=3D17
CONFIG_CGROUPS=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_NS=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
CONFIG_GROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_USER_SCHED is not set
CONFIG_CGROUP_SCHED=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
# CONFIG_RESOURCE_COUNTERS is not set
CONFIG_SYSFS_DEPRECATED=3Dy
CONFIG_SYSFS_DEPRECATED_V2=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_RELAY=3Dy
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_USER_NS=3Dy
CONFIG_PID_NS=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_UID16=3Dy
CONFIG_SYSCTL_SYSCALL=3Dy
CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
# CONFIG_COMPAT_BRK is not set
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_PROFILING=3Dy
# CONFIG_MARKERS is not set
CONFIG_OPROFILE=3Dm
CONFIG_HAVE_OPROFILE=3Dy
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
# CONFIG_HAVE_DMA_ATTRS is not set
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_DEV_IO_TRACE=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLOCK_COMPAT=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_PREEMPT_NOTIFIERS=3Dy
CONFIG_CLASSIC_RCU=3Dy

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_SMP=3Dy
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_VSMP is not set
CONFIG_PARAVIRT_GUEST=3Dy
CONFIG_KVM_CLOCK=3Dy
CONFIG_KVM_GUEST=3Dy
CONFIG_PARAVIRT=3Dy
CONFIG_PARAVIRT_CLOCK=3Dy
CONFIG_MEMTEST_BOOTPARAM=3Dy
CONFIG_MEMTEST_BOOTPARAM_VALUE=3D0
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
CONFIG_GENERIC_CPU=3Dy
CONFIG_X86_CPU=3Dy
CONFIG_X86_L1_CACHE_BYTES=3D128
CONFIG_X86_INTERNODE_CACHE_BYTES=3D128
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_CMOV=3Dy
CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DMI=3Dy
CONFIG_GART_IOMMU=3Dy
CONFIG_CALGARY_IOMMU=3Dy
CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=3Dy
CONFIG_SWIOTLB=3Dy
CONFIG_IOMMU_HELPER=3Dy
CONFIG_NR_CPUS=3D32
CONFIG_SCHED_SMT=3Dy
CONFIG_SCHED_MC=3Dy
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_INTEL=3Dy
CONFIG_X86_MCE_AMD=3Dy
CONFIG_I8K=3Dm
CONFIG_MICROCODE=3Dm
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_NUMA=3Dy
CONFIG_K8_NUMA=3Dy
CONFIG_X86_64_ACPI_NUMA=3Dy
CONFIG_NODES_SPAN_OTHER_NODES=3Dy
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=3D6
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
# CONFIG_FLATMEM_MANUAL is not set
# CONFIG_DISCONTIGMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_NEED_MULTIPLE_NODES=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy

#
# Memory hotplug is currently incompatible with Software Suspend
#
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_MIGRATION=3Dy
CONFIG_RESOURCES_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_MTRR=3Dy
# CONFIG_X86_PAT is not set
CONFIG_EFI=3Dy
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
CONFIG_SCHED_HRTICK=3Dy
CONFIG_KEXEC=3Dy
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=3D0x200000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=3D0x200000
CONFIG_HOTPLUG_CPU=3Dy
# CONFIG_COMPAT_VDSO is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=3Dy

#
# Power management options
#
CONFIG_ARCH_HIBERNATION_HEADER=3Dy
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SLEEP_SMP=3Dy
CONFIG_PM_SLEEP=3Dy
CONFIG_SUSPEND=3Dy
CONFIG_SUSPEND_FREEZER=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_PM_STD_PARTITION=3D""
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_PROCFS=3Dy
CONFIG_ACPI_PROCFS_POWER=3Dy
CONFIG_ACPI_SYSFS_POWER=3Dy
CONFIG_ACPI_PROC_EVENT=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_VIDEO=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_DOCK=3Dm
CONFIG_ACPI_BAY=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_HOTPLUG_CPU=3Dy
CONFIG_ACPI_THERMAL=3Dm
CONFIG_ACPI_NUMA=3Dy
CONFIG_ACPI_WMI=3Dm
CONFIG_ACPI_ASUS=3Dm
CONFIG_ACPI_TOSHIBA=3Dm
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
CONFIG_ACPI_CONTAINER=3Dm
CONFIG_ACPI_SBS=3Dm

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dm
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dm
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=3Dm
CONFIG_X86_POWERNOW_K8=3Dm
CONFIG_X86_POWERNOW_K8_ACPI=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO=3Dm
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_DOMAINS=3Dy
# CONFIG_DMAR is not set
CONFIG_PCIEPORTBUS=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dm
CONFIG_PCIEAER=3Dy
# CONFIG_PCIEASPM is not set
CONFIG_ARCH_SUPPORTS_MSI=3Dy
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_LEGACY=3Dy
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=3Dy
CONFIG_ISA_DMA_API=3Dy
CONFIG_K8_NB=3Dy
CONFIG_PCCARD=3Dm
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=3Dm
CONFIG_PCMCIA_LOAD_CIS=3Dy
CONFIG_PCMCIA_IOCTL=3Dy
CONFIG_CARDBUS=3Dy

#
# PC-card bridges
#
CONFIG_YENTA=3Dm
CONFIG_YENTA_O2=3Dy
CONFIG_YENTA_RICOH=3Dy
CONFIG_YENTA_TI=3Dy
CONFIG_YENTA_ENE_TUNE=3Dy
CONFIG_YENTA_TOSHIBA=3Dy
CONFIG_PD6729=3Dm
CONFIG_I82092=3Dm
CONFIG_PCCARD_NONSTATIC=3Dm
CONFIG_HOTPLUG_PCI=3Dm
CONFIG_HOTPLUG_PCI_FAKE=3Dm
CONFIG_HOTPLUG_PCI_ACPI=3Dm
CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
CONFIG_HOTPLUG_PCI_CPCI=3Dy
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dm
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dm
CONFIG_HOTPLUG_PCI_SHPC=3Dm

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_IA32_EMULATION=3Dy
CONFIG_IA32_AOUT=3Dy
CONFIG_COMPAT=3Dy
CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=3Dm
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_ASK_IP_FIB_HASH=3Dy
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dm
CONFIG_INET_LRO=3Dm
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_TCP_CONG_WESTWOOD=3Dm
CONFIG_TCP_CONG_HTCP=3Dm
CONFIG_TCP_CONG_HSTCP=3Dm
CONFIG_TCP_CONG_HYBLA=3Dm
CONFIG_TCP_CONG_VEGAS=3Dm
CONFIG_TCP_CONG_SCALABLE=3Dm
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_CONG_VENO=3Dm
CONFIG_TCP_CONG_YEAH=3Dm
CONFIG_TCP_CONG_ILLINOIS=3Dm
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IP_VS=3Dm
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=3D12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=3Dy
CONFIG_IP_VS_PROTO_UDP=3Dy
CONFIG_IP_VS_PROTO_ESP=3Dy
CONFIG_IP_VS_PROTO_AH=3Dy

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=3Dm
CONFIG_IPV6=3Dm
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dm
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_BEET=3Dm
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=3Dy
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_CT_ACCT=3Dy
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
CONFIG_NF_CT_PROTO_DCCP=3Dm
CONFIG_NF_CT_PROTO_GRE=3Dm
CONFIG_NF_CT_PROTO_SCTP=3Dm
CONFIG_NF_CT_PROTO_UDPLITE=3Dm
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
CONFIG_NETFILTER_XTABLES=3Dm
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
CONFIG_NETFILTER_XT_MATCH_U32=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV4=3Dm
CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_NF_NAT_SNMP_BASIC=3Dm
CONFIG_NF_NAT_PROTO_DCCP=3Dm
CONFIG_NF_NAT_PROTO_GRE=3Dm
CONFIG_NF_NAT_PROTO_UDPLITE=3Dm
CONFIG_NF_NAT_PROTO_SCTP=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_PPTP=3Dm
CONFIG_NF_NAT_H323=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV6=3Dm
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_HL=3Dm
CONFIG_IP6_NF_RAW=3Dm

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=3Dm

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_ULOG=3Dm
CONFIG_BRIDGE_EBT_NFLOG=3Dm
CONFIG_IP_DCCP=3Dm
CONFIG_INET_DCCP_DIAG=3Dm
CONFIG_IP_DCCP_ACKVEC=3Dy

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
CONFIG_IP_DCCP_CCID2=3Dm
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=3Dm
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_CCID3_RTO=3D100
CONFIG_IP_DCCP_TFRC_LIB=3Dm

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=3Dy
CONFIG_TIPC=3Dm
CONFIG_TIPC_ADVANCED=3Dy
CONFIG_TIPC_ZONES=3D3
CONFIG_TIPC_CLUSTERS=3D1
CONFIG_TIPC_NODES=3D255
CONFIG_TIPC_SLAVE_NODES=3D0
CONFIG_TIPC_PORTS=3D8191
CONFIG_TIPC_LOG=3D0
# CONFIG_TIPC_DEBUG is not set
CONFIG_ATM=3Dm
CONFIG_ATM_CLIP=3Dm
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=3Dm
CONFIG_ATM_MPOA=3Dm
CONFIG_ATM_BR2684=3Dm
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=3Dm
CONFIG_VLAN_8021Q=3Dm
CONFIG_DECNET=3Dm
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=3Dy
CONFIG_LLC2=3Dm
CONFIG_IPX=3Dm
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=3Dm
CONFIG_DEV_APPLETALK=3Dm
CONFIG_IPDDP=3Dm
CONFIG_IPDDP_ENCAP=3Dy
CONFIG_IPDDP_DECAP=3Dy
CONFIG_X25=3Dm
CONFIG_LAPB=3Dm
CONFIG_ECONET=3Dm
CONFIG_ECONET_AUNUDP=3Dy
CONFIG_ECONET_NATIVE=3Dy
CONFIG_WAN_ROUTER=3Dm
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_ATM=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_INGRESS=3Dm

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_PERF=3Dy
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_FLOW=3Dm
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK=3D32
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
CONFIG_GACT_PROB=3Dy
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_SCH_FIFO=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
CONFIG_HAMRADIO=3Dy

#
# Packet Radio protocols
#
CONFIG_AX25=3Dm
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=3Dm
CONFIG_ROSE=3Dm

#
# AX.25 network device drivers
#
CONFIG_MKISS=3Dm
CONFIG_6PACK=3Dm
CONFIG_BPQETHER=3Dm
CONFIG_BAYCOM_SER_FDX=3Dm
CONFIG_BAYCOM_SER_HDX=3Dm
CONFIG_BAYCOM_PAR=3Dm
CONFIG_CAN=3Dm
CONFIG_CAN_RAW=3Dm
CONFIG_CAN_BCM=3Dm

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=3Dm
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
CONFIG_DONGLE=3Dy
CONFIG_ESI_DONGLE=3Dm
CONFIG_ACTISYS_DONGLE=3Dm
CONFIG_TEKRAM_DONGLE=3Dm
CONFIG_TOIM3232_DONGLE=3Dm
CONFIG_LITELINK_DONGLE=3Dm
CONFIG_MA600_DONGLE=3Dm
CONFIG_GIRBIL_DONGLE=3Dm
CONFIG_MCP2120_DONGLE=3Dm
CONFIG_OLD_BELKIN_DONGLE=3Dm
CONFIG_ACT200L_DONGLE=3Dm
CONFIG_KINGSUN_DONGLE=3Dm
CONFIG_KSDAZZLE_DONGLE=3Dm
CONFIG_KS959_DONGLE=3Dm

#
# FIR device drivers
#
CONFIG_USB_IRDA=3Dm
CONFIG_SIGMATEL_FIR=3Dm
CONFIG_NSC_FIR=3Dm
CONFIG_WINBOND_FIR=3Dm
CONFIG_SMC_IRCC_FIR=3Dm
CONFIG_ALI_FIR=3Dm
CONFIG_VLSI_FIR=3Dm
CONFIG_VIA_FIR=3Dm
CONFIG_MCS_FIR=3Dm
CONFIG_BT=3Dm
CONFIG_BT_L2CAP=3Dm
CONFIG_BT_SCO=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_CMTP=3Dm
CONFIG_BT_HIDP=3Dm

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=3Dm
CONFIG_BT_HCIUSB_SCO=3Dy
CONFIG_BT_HCIBTSDIO=3Dm
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_LL=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIDTL1=3Dm
CONFIG_BT_HCIBT3C=3Dm
CONFIG_BT_HCIBLUECARD=3Dm
CONFIG_BT_HCIBTUART=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_AF_RXRPC=3Dm
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=3Dm
CONFIG_FIB_RULES=3Dy

#
# Wireless
#
CONFIG_CFG80211=3Dm
CONFIG_NL80211=3Dy
CONFIG_WIRELESS_EXT=3Dy
CONFIG_MAC80211=3Dm

#
# Rate control algorithm selection
#
CONFIG_MAC80211_RC_DEFAULT_PID=3Dy
# CONFIG_MAC80211_RC_DEFAULT_NONE is not set

#
# Selecting 'y' for an algorithm will
#

#
# build the algorithm into mac80211.
#
CONFIG_MAC80211_RC_DEFAULT=3D"pid"
CONFIG_MAC80211_RC_PID=3Dy
CONFIG_MAC80211_MESH=3Dy
CONFIG_MAC80211_LEDS=3Dy
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_DEBUG_PACKET_ALIGNMENT is not set
# CONFIG_MAC80211_DEBUG is not set
CONFIG_IEEE80211=3Dm
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=3Dm
CONFIG_IEEE80211_CRYPT_CCMP=3Dm
CONFIG_IEEE80211_CRYPT_TKIP=3Dm
CONFIG_RFKILL=3Dm
CONFIG_RFKILL_INPUT=3Dm
CONFIG_RFKILL_LEDS=3Dy
CONFIG_NET_9P=3Dm
CONFIG_NET_9P_VIRTIO=3Dm
# CONFIG_NET_9P_DEBUG is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=3Dm
CONFIG_MTD=3Dm
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=3Dm
CONFIG_MTD_PARTITIONS=3Dy
CONFIG_MTD_REDBOOT_PARTS=3Dm
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_AR7_PARTS=3Dm

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dm
CONFIG_MTD_BLKDEVS=3Dm
CONFIG_MTD_BLOCK=3Dm
CONFIG_MTD_BLOCK_RO=3Dm
CONFIG_FTL=3Dm
CONFIG_NFTL=3Dm
CONFIG_NFTL_RW=3Dy
CONFIG_INFTL=3Dm
CONFIG_RFD_FTL=3Dm
CONFIG_SSFDC=3Dm
CONFIG_MTD_OOPS=3Dm

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dm
CONFIG_MTD_JEDECPROBE=3Dm
CONFIG_MTD_GEN_PROBE=3Dm
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=3Dm
CONFIG_MTD_CFI_AMDSTD=3Dm
CONFIG_MTD_CFI_STAA=3Dm
CONFIG_MTD_CFI_UTIL=3Dm
CONFIG_MTD_RAM=3Dm
CONFIG_MTD_ROM=3Dm
CONFIG_MTD_ABSENT=3Dm

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
CONFIG_MTD_PHYSMAP=3Dm
CONFIG_MTD_PHYSMAP_START=3D0x8000000
CONFIG_MTD_PHYSMAP_LEN=3D0x4000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D2
CONFIG_MTD_SC520CDP=3Dm
CONFIG_MTD_NETSC520=3Dm
CONFIG_MTD_TS5500=3Dm
CONFIG_MTD_SBC_GXX=3Dm
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=3Dm
CONFIG_MTD_DILNETPC=3Dm
CONFIG_MTD_DILNETPC_BOOTSIZE=3D0x80000
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_PCI=3Dm
CONFIG_MTD_INTEL_VR_NOR=3Dm
CONFIG_MTD_PLATRAM=3Dm

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=3Dm
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=3Dm
CONFIG_MTD_M25P80=3Dm
CONFIG_M25PXX_USE_FAST_READ=3Dy
CONFIG_MTD_SLRAM=3Dm
CONFIG_MTD_PHRAM=3Dm
CONFIG_MTD_MTDRAM=3Dm
CONFIG_MTDRAM_TOTAL_SIZE=3D4096
CONFIG_MTDRAM_ERASE_SIZE=3D128
CONFIG_MTD_BLOCK2MTD=3Dm

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=3Dm
CONFIG_MTD_DOC2001=3Dm
CONFIG_MTD_DOC2001PLUS=3Dm
CONFIG_MTD_DOCPROBE=3Dm
CONFIG_MTD_DOCECC=3Dm
# CONFIG_MTD_DOCPROBE_ADVANCED is not set
CONFIG_MTD_DOCPROBE_ADDRESS=3D0
CONFIG_MTD_NAND=3Dm
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
# CONFIG_MTD_NAND_ECC_SMC is not set
# CONFIG_MTD_NAND_MUSEUM_IDS is not set
CONFIG_MTD_NAND_IDS=3Dm
CONFIG_MTD_NAND_DISKONCHIP=3Dm
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=3D0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_NAND_CAFE=3Dm
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_PLATFORM=3Dm
CONFIG_MTD_ALAUDA=3Dm
CONFIG_MTD_ONENAND=3Dm
CONFIG_MTD_ONENAND_VERIFY_WRITE=3Dy
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=3Dy
CONFIG_MTD_ONENAND_SIM=3Dm

#
# UBI - Unsorted block images
#
CONFIG_MTD_UBI=3Dm
CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
CONFIG_MTD_UBI_BEB_RESERVE=3D1
# CONFIG_MTD_UBI_GLUEBI is not set

#
# UBI debugging options
#
# CONFIG_MTD_UBI_DEBUG is not set
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_SERIAL=3Dm
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=3Dm
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=3Dm
CONFIG_PARPORT_1284=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_PNP=3Dy
CONFIG_PNP_DEBUG=3Dy

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
CONFIG_BLK_DEV_FD=3Dm
CONFIG_PARIDE=3Dm

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=3Dm
CONFIG_PARIDE_PCD=3Dm
CONFIG_PARIDE_PF=3Dm
CONFIG_PARIDE_PT=3Dm
CONFIG_PARIDE_PG=3Dm

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=3Dm
CONFIG_PARIDE_BPCK=3Dm
CONFIG_PARIDE_COMM=3Dm
CONFIG_PARIDE_DSTR=3Dm
CONFIG_PARIDE_FIT2=3Dm
CONFIG_PARIDE_FIT3=3Dm
CONFIG_PARIDE_EPAT=3Dm
# CONFIG_PARIDE_EPATC8 is not set
CONFIG_PARIDE_EPIA=3Dm
CONFIG_PARIDE_FRIQ=3Dm
CONFIG_PARIDE_FRPW=3Dm
CONFIG_PARIDE_KBIC=3Dm
CONFIG_PARIDE_KTTI=3Dm
CONFIG_PARIDE_ON20=3Dm
CONFIG_PARIDE_ON26=3Dm
CONFIG_BLK_CPQ_DA=3Dm
CONFIG_BLK_CPQ_CISS_DA=3Dm
CONFIG_CISS_SCSI_TAPE=3Dy
CONFIG_BLK_DEV_DAC960=3Dm
CONFIG_BLK_DEV_UMEM=3Dm
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_SX8=3Dm
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D65536
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=3Dm
CONFIG_VIRTIO_BLK=3Dm
CONFIG_MISC_DEVICES=3Dy
CONFIG_IBM_ASM=3Dm
CONFIG_PHANTOM=3Dm
CONFIG_EEPROM_93CX6=3Dm
CONFIG_SGI_IOC4=3Dm
CONFIG_TIFM_CORE=3Dm
CONFIG_TIFM_7XX1=3Dm
CONFIG_ACER_WMI=3Dm
CONFIG_ASUS_LAPTOP=3Dm
CONFIG_FUJITSU_LAPTOP=3Dm
CONFIG_MSI_LAPTOP=3Dm
CONFIG_SONY_LAPTOP=3Dm
CONFIG_SONYPI_COMPAT=3Dy
CONFIG_THINKPAD_ACPI=3Dm
# CONFIG_THINKPAD_ACPI_DEBUG is not set
CONFIG_THINKPAD_ACPI_BAY=3Dy
CONFIG_THINKPAD_ACPI_VIDEO=3Dy
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=3Dm
CONFIG_ENCLOSURE_SERVICES=3Dm
CONFIG_HP_ILO=3Dm
CONFIG_HAVE_IDE=3Dy
CONFIG_IDE=3Dm
CONFIG_BLK_DEV_IDE=3Dm

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=3Dm
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECS=3Dm
CONFIG_BLK_DEV_DELKIN=3Dm
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=3Dy
CONFIG_BLK_DEV_IDETAPE=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_BLK_DEV_IDEACPI=3Dy
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=3Dy

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dm
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=3Dm
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=3Dm
CONFIG_BLK_DEV_IDEDMA_SFF=3Dy

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=3Dm
CONFIG_BLK_DEV_OPTI621=3Dm
CONFIG_BLK_DEV_RZ1000=3Dm
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_AEC62XX=3Dm
CONFIG_BLK_DEV_ALI15X3=3Dm
CONFIG_BLK_DEV_AMD74XX=3Dm
CONFIG_BLK_DEV_ATIIXP=3Dm
CONFIG_BLK_DEV_CMD64X=3Dm
CONFIG_BLK_DEV_TRIFLEX=3Dm
CONFIG_BLK_DEV_CY82C693=3Dm
CONFIG_BLK_DEV_CS5520=3Dm
CONFIG_BLK_DEV_CS5530=3Dm
CONFIG_BLK_DEV_HPT34X=3Dm
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=3Dm
CONFIG_BLK_DEV_JMICRON=3Dm
CONFIG_BLK_DEV_SC1200=3Dm
CONFIG_BLK_DEV_PIIX=3Dm
CONFIG_BLK_DEV_IT8213=3Dm
CONFIG_BLK_DEV_IT821X=3Dm
CONFIG_BLK_DEV_NS87415=3Dm
CONFIG_BLK_DEV_PDC202XX_OLD=3Dm
CONFIG_BLK_DEV_PDC202XX_NEW=3Dm
CONFIG_BLK_DEV_SVWKS=3Dm
CONFIG_BLK_DEV_SIIMAGE=3Dm
CONFIG_BLK_DEV_SIS5513=3Dm
CONFIG_BLK_DEV_SLC90E66=3Dm
CONFIG_BLK_DEV_TRM290=3Dm
CONFIG_BLK_DEV_VIA82CXXX=3Dm
CONFIG_BLK_DEV_TC86C001=3Dm
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_BLK_DEV_HD_ONLY is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_RAID_ATTRS=3Dm
CONFIG_SCSI=3Dm
CONFIG_SCSI_DMA=3Dy
CONFIG_SCSI_TGT=3Dm
CONFIG_SCSI_NETLINK=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy
CONFIG_SCSI_WAIT_SCAN=3Dm

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_FC_TGT_ATTRS=3Dy
CONFIG_SCSI_ISCSI_ATTRS=3Dm
CONFIG_SCSI_SAS_ATTRS=3Dm
CONFIG_SCSI_SAS_LIBSAS=3Dm
CONFIG_SCSI_SAS_ATA=3Dy
CONFIG_SCSI_SAS_HOST_SMP=3Dy
# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
CONFIG_SCSI_SRP_ATTRS=3Dm
CONFIG_SCSI_SRP_TGT_ATTRS=3Dy
CONFIG_SCSI_LOWLEVEL=3Dy
CONFIG_ISCSI_TCP=3Dm
CONFIG_BLK_DEV_3W_XXXX_RAID=3Dm
CONFIG_SCSI_3W_9XXX=3Dm
CONFIG_SCSI_ACARD=3Dm
CONFIG_SCSI_AACRAID=3Dm
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D8
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC7XXX_OLD=3Dm
CONFIG_SCSI_AIC79XX=3Dm
CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
CONFIG_AIC79XX_DEBUG_ENABLE=3Dy
CONFIG_AIC79XX_DEBUG_MASK=3D0
CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC94XX=3Dm
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_DPT_I2O=3Dm
CONFIG_SCSI_ADVANSYS=3Dm
CONFIG_SCSI_ARCMSR=3Dm
# CONFIG_SCSI_ARCMSR_AER is not set
CONFIG_MEGARAID_NEWGEN=3Dy
CONFIG_MEGARAID_MM=3Dm
CONFIG_MEGARAID_MAILBOX=3Dm
CONFIG_MEGARAID_LEGACY=3Dm
CONFIG_MEGARAID_SAS=3Dm
CONFIG_SCSI_HPTIOP=3Dm
CONFIG_SCSI_BUSLOGIC=3Dm
CONFIG_SCSI_DMX3191D=3Dm
CONFIG_SCSI_EATA=3Dm
CONFIG_SCSI_EATA_TAGGED_QUEUE=3Dy
CONFIG_SCSI_EATA_LINKED_COMMANDS=3Dy
CONFIG_SCSI_EATA_MAX_TAGS=3D16
CONFIG_SCSI_FUTURE_DOMAIN=3Dm
CONFIG_SCSI_GDTH=3Dm
CONFIG_SCSI_IPS=3Dm
CONFIG_SCSI_INITIO=3Dm
CONFIG_SCSI_INIA100=3Dm
CONFIG_SCSI_PPA=3Dm
CONFIG_SCSI_IMM=3Dm
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_MVSAS=3Dm
CONFIG_SCSI_STEX=3Dm
CONFIG_SCSI_SYM53C8XX_2=3Dm
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
CONFIG_SCSI_IPR=3Dm
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_1280=3Dm
CONFIG_SCSI_QLA_FC=3Dm
CONFIG_SCSI_QLA_ISCSI=3Dm
CONFIG_SCSI_LPFC=3Dm
CONFIG_SCSI_DC395x=3Dm
CONFIG_SCSI_DC390T=3Dm
CONFIG_SCSI_DEBUG=3Dm
CONFIG_SCSI_SRP=3Dm
CONFIG_SCSI_LOWLEVEL_PCMCIA=3Dy
CONFIG_PCMCIA_FDOMAIN=3Dm
CONFIG_PCMCIA_QLOGIC=3Dm
CONFIG_PCMCIA_SYM53C500=3Dm
CONFIG_ATA=3Dm
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_ACPI=3Dy
CONFIG_SATA_PMP=3Dy
CONFIG_SATA_AHCI=3Dm
CONFIG_SATA_SIL24=3Dm
CONFIG_ATA_SFF=3Dy
CONFIG_SATA_SVW=3Dm
CONFIG_ATA_PIIX=3Dm
CONFIG_SATA_MV=3Dm
CONFIG_SATA_NV=3Dm
CONFIG_PDC_ADMA=3Dm
CONFIG_SATA_QSTOR=3Dm
CONFIG_SATA_PROMISE=3Dm
CONFIG_SATA_SX4=3Dm
CONFIG_SATA_SIL=3Dm
# CONFIG_SATA_SIS is not set
CONFIG_SATA_ULI=3Dm
CONFIG_SATA_VIA=3Dm
CONFIG_SATA_VITESSE=3Dm
CONFIG_SATA_INIC162X=3Dm
# CONFIG_PATA_ACPI is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARTOP=3Dm
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_ATA_GENERIC=3Dm
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_MARVELL=3Dm
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=3Dm
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
CONFIG_PATA_SCH=3Dm
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
CONFIG_MD_RAID5_RESHAPE=3Dy
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
CONFIG_BLK_DEV_DM=3Dm
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_EMC=3Dm
CONFIG_DM_MULTIPATH_RDAC=3Dm
CONFIG_DM_MULTIPATH_HP=3Dm
CONFIG_DM_DELAY=3Dm
CONFIG_DM_UEVENT=3Dy
CONFIG_FUSION=3Dy
CONFIG_FUSION_SPI=3Dm
CONFIG_FUSION_FC=3Dm
CONFIG_FUSION_SAS=3Dm
CONFIG_FUSION_MAX_SGE=3D40
CONFIG_FUSION_CTL=3Dm
CONFIG_FUSION_LAN=3Dm
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#

#
# Enable only one of the two stacks, unless you know what you are doing
#
# CONFIG_FIREWIRE is not set
CONFIG_IEEE1394=3Dm
CONFIG_IEEE1394_OHCI1394=3Dm
CONFIG_IEEE1394_PCILYNX=3Dm
CONFIG_IEEE1394_SBP2=3Dm
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394_ROM_ENTRY=3Dy
CONFIG_IEEE1394_ETH1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_DV1394=3Dm
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_I2O=3Dm
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=3Dy
CONFIG_I2O_EXT_ADAPTEC=3Dy
CONFIG_I2O_EXT_ADAPTEC_DMA64=3Dy
CONFIG_I2O_CONFIG=3Dm
CONFIG_I2O_CONFIG_OLD_IOCTL=3Dy
CONFIG_I2O_BUS=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm
CONFIG_MACINTOSH_DRIVERS=3Dy
CONFIG_MAC_EMUMOUSEBTN=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_NETDEVICES_MULTIQUEUE=3Dy
CONFIG_IFB=3Dm
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
# CONFIG_MACVLAN is not set
CONFIG_EQUALIZER=3Dm
CONFIG_TUN=3Dm
CONFIG_VETH=3Dm
CONFIG_NET_SB1000=3Dm
CONFIG_ARCNET=3Dm
CONFIG_ARCNET_1201=3Dm
CONFIG_ARCNET_1051=3Dm
CONFIG_ARCNET_RAW=3Dm
CONFIG_ARCNET_CAP=3Dm
CONFIG_ARCNET_COM90xx=3Dm
CONFIG_ARCNET_COM90xxIO=3Dm
CONFIG_ARCNET_RIM_I=3Dm
CONFIG_ARCNET_COM20020=3Dm
CONFIG_ARCNET_COM20020_PCI=3Dm
CONFIG_PHYLIB=3Dm

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=3Dm
CONFIG_DAVICOM_PHY=3Dm
CONFIG_QSEMI_PHY=3Dm
CONFIG_LXT_PHY=3Dm
CONFIG_CICADA_PHY=3Dm
CONFIG_VITESSE_PHY=3Dm
CONFIG_SMSC_PHY=3Dm
CONFIG_BROADCOM_PHY=3Dm
CONFIG_ICPLUS_PHY=3Dm
CONFIG_REALTEK_PHY=3Dm
CONFIG_MDIO_BITBANG=3Dm
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dm
CONFIG_HAPPYMEAL=3Dm
CONFIG_SUNGEM=3Dm
CONFIG_CASSINI=3Dm
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_VORTEX=3Dm
CONFIG_TYPHOON=3Dm
CONFIG_ENC28J60=3Dm
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_NET_TULIP=3Dy
CONFIG_DE2104X=3Dm
CONFIG_TULIP=3Dm
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_TULIP_NAPI=3Dy
CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy
CONFIG_DE4X5=3Dm
CONFIG_WINBOND_840=3Dm
CONFIG_DM9102=3Dm
CONFIG_ULI526X=3Dm
CONFIG_PCMCIA_XIRCOM=3Dm
CONFIG_HP100=3Dm
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
CONFIG_NET_PCI=3Dy
CONFIG_PCNET32=3Dm
CONFIG_AMD8111_ETH=3Dm
CONFIG_AMD8111E_NAPI=3Dy
CONFIG_ADAPTEC_STARFIRE=3Dm
CONFIG_ADAPTEC_STARFIRE_NAPI=3Dy
CONFIG_B44=3Dm
CONFIG_B44_PCI_AUTOSELECT=3Dy
CONFIG_B44_PCICORE_AUTOSELECT=3Dy
CONFIG_B44_PCI=3Dy
CONFIG_FORCEDETH=3Dm
# CONFIG_FORCEDETH_NAPI is not set
CONFIG_EEPRO100=3Dm
CONFIG_E100=3Dm
CONFIG_FEALNX=3Dm
CONFIG_NATSEMI=3Dm
CONFIG_NE2K_PCI=3Dm
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=3Dy
CONFIG_8139TOO_8129=3Dy
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R6040=3Dm
CONFIG_SIS900=3Dm
CONFIG_EPIC100=3Dm
CONFIG_SUNDANCE=3Dm
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_VIA_RHINE=3Dm
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_VIA_RHINE_NAPI=3Dy
CONFIG_SC92031=3Dm
# CONFIG_NET_POCKET is not set
CONFIG_NETDEV_1000=3Dy
CONFIG_ACENIC=3Dm
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=3Dm
CONFIG_E1000=3Dm
CONFIG_E1000_NAPI=3Dy
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
CONFIG_E1000E=3Dm
CONFIG_E1000E_ENABLED=3Dy
CONFIG_IP1000=3Dm
CONFIG_IGB=3Dm
CONFIG_NS83820=3Dm
CONFIG_HAMACHI=3Dm
CONFIG_YELLOWFIN=3Dm
CONFIG_R8169=3Dm
CONFIG_R8169_NAPI=3Dy
CONFIG_R8169_VLAN=3Dy
CONFIG_SIS190=3Dm
CONFIG_SKGE=3Dm
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKY2=3Dm
# CONFIG_SKY2_DEBUG is not set
CONFIG_VIA_VELOCITY=3Dm
CONFIG_TIGON3=3Dm
CONFIG_BNX2=3Dm
CONFIG_QLA3XXX=3Dm
CONFIG_ATL1=3Dm
CONFIG_ATL1E=3Dm
CONFIG_NETDEV_10000=3Dy
CONFIG_CHELSIO_T1=3Dm
CONFIG_CHELSIO_T1_1G=3Dy
CONFIG_CHELSIO_T1_NAPI=3Dy
CONFIG_CHELSIO_T3=3Dm
CONFIG_IXGBE=3Dm
CONFIG_IXGB=3Dm
CONFIG_IXGB_NAPI=3Dy
CONFIG_S2IO=3Dm
CONFIG_S2IO_NAPI=3Dy
CONFIG_MYRI10GE=3Dm
CONFIG_NETXEN_NIC=3Dm
CONFIG_NIU=3Dm
CONFIG_MLX4_CORE=3Dm
CONFIG_MLX4_DEBUG=3Dy
CONFIG_TEHUTI=3Dm
CONFIG_SFC=3Dm
CONFIG_TR=3Dy
CONFIG_IBMOL=3Dm
CONFIG_TMS380TR=3Dm
CONFIG_TMSPCI=3Dm
CONFIG_ABYSS=3Dm

#
# Wireless LAN
#
CONFIG_WLAN_PRE80211=3Dy
CONFIG_STRIP=3Dm
CONFIG_PCMCIA_WAVELAN=3Dm
CONFIG_PCMCIA_NETWAVE=3Dm
CONFIG_WLAN_80211=3Dy
CONFIG_PCMCIA_RAYCS=3Dm
# CONFIG_IPW2100 is not set
CONFIG_IPW2200=3Dm
CONFIG_IPW2200_MONITOR=3Dy
CONFIG_IPW2200_RADIOTAP=3Dy
CONFIG_IPW2200_PROMISCUOUS=3Dy
CONFIG_IPW2200_QOS=3Dy
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBERTAS=3Dm
CONFIG_LIBERTAS_USB=3Dm
CONFIG_LIBERTAS_CS=3Dm
CONFIG_LIBERTAS_SDIO=3Dm
# CONFIG_LIBERTAS_DEBUG is not set
CONFIG_AIRO=3Dm
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_TMD_HERMES=3Dm
CONFIG_NORTEL_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
CONFIG_PCMCIA_HERMES=3Dm
CONFIG_PCMCIA_SPECTRUM=3Dm
CONFIG_ATMEL=3Dm
CONFIG_PCI_ATMEL=3Dm
CONFIG_PCMCIA_ATMEL=3Dm
CONFIG_USB_ATMEL=3Dm
CONFIG_AIRO_CS=3Dm
CONFIG_PCMCIA_WL3501=3Dm
# CONFIG_PRISM54 is not set
CONFIG_USB_ZD1201=3Dm
CONFIG_USB_NET_RNDIS_WLAN=3Dm
CONFIG_RTL8180=3Dm
CONFIG_RTL8187=3Dm
CONFIG_ADM8211=3Dm
CONFIG_P54_COMMON=3Dm
CONFIG_P54_USB=3Dm
CONFIG_P54_PCI=3Dm
CONFIG_ATH5K=3Dm
# CONFIG_ATH5K_DEBUG is not set
CONFIG_IWLWIFI=3Dm
CONFIG_IWLCORE=3Dm
CONFIG_IWLWIFI_LEDS=3Dy
CONFIG_IWLWIFI_RFKILL=3Dy
CONFIG_IWL4965=3Dm
CONFIG_IWL4965_HT=3Dy
CONFIG_IWL4965_LEDS=3Dy
CONFIG_IWL4965_SPECTRUM_MEASUREMENT=3Dy
CONFIG_IWL4965_SENSITIVITY=3Dy
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWL3945=3Dm
CONFIG_IWL3945_SPECTRUM_MEASUREMENT=3Dy
CONFIG_IWL3945_LEDS=3Dy
# CONFIG_IWL3945_DEBUG is not set
CONFIG_HOSTAP=3Dm
CONFIG_HOSTAP_FIRMWARE=3Dy
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
CONFIG_HOSTAP_PLX=3Dm
CONFIG_HOSTAP_PCI=3Dm
CONFIG_HOSTAP_CS=3Dm
CONFIG_B43=3Dm
CONFIG_B43_PCI_AUTOSELECT=3Dy
CONFIG_B43_PCICORE_AUTOSELECT=3Dy
CONFIG_B43_PCMCIA=3Dy
CONFIG_B43_PIO=3Dy
CONFIG_B43_LEDS=3Dy
CONFIG_B43_RFKILL=3Dy
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=3Dm
CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
CONFIG_B43LEGACY_LEDS=3Dy
CONFIG_B43LEGACY_RFKILL=3Dy
CONFIG_B43LEGACY_DEBUG=3Dy
CONFIG_B43LEGACY_DMA=3Dy
CONFIG_B43LEGACY_PIO=3Dy
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_ZD1211RW=3Dm
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_RT2X00=3Dm
CONFIG_RT2X00_LIB=3Dm
CONFIG_RT2X00_LIB_PCI=3Dm
CONFIG_RT2X00_LIB_USB=3Dm
CONFIG_RT2X00_LIB_FIRMWARE=3Dy
CONFIG_RT2X00_LIB_RFKILL=3Dy
CONFIG_RT2X00_LIB_LEDS=3Dy
CONFIG_RT2400PCI=3Dm
CONFIG_RT2400PCI_RFKILL=3Dy
CONFIG_RT2400PCI_LEDS=3Dy
CONFIG_RT2500PCI=3Dm
CONFIG_RT2500PCI_RFKILL=3Dy
CONFIG_RT2500PCI_LEDS=3Dy
CONFIG_RT61PCI=3Dm
CONFIG_RT61PCI_RFKILL=3Dy
CONFIG_RT61PCI_LEDS=3Dy
CONFIG_RT2500USB=3Dm
CONFIG_RT2500USB_LEDS=3Dy
CONFIG_RT73USB=3Dm
CONFIG_RT73USB_LEDS=3Dy
# CONFIG_RT2X00_DEBUG is not set

#
# USB Network Adapters
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_CDCETHER=3Dm
CONFIG_USB_NET_DM9601=3Dm
CONFIG_USB_NET_GL620A=3Dm
CONFIG_USB_NET_NET1080=3Dm
CONFIG_USB_NET_PLUSB=3Dm
CONFIG_USB_NET_MCS7830=3Dm
CONFIG_USB_NET_RNDIS_HOST=3Dm
CONFIG_USB_NET_CDC_SUBSET=3Dm
CONFIG_USB_ALI_M5632=3Dy
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_KC2190=3Dy
CONFIG_USB_NET_ZAURUS=3Dm
CONFIG_NET_PCMCIA=3Dy
CONFIG_PCMCIA_3C589=3Dm
CONFIG_PCMCIA_3C574=3Dm
CONFIG_PCMCIA_FMVJ18X=3Dm
CONFIG_PCMCIA_PCNET=3Dm
CONFIG_PCMCIA_NMCLAN=3Dm
CONFIG_PCMCIA_SMC91C92=3Dm
CONFIG_PCMCIA_XIRC2PS=3Dm
CONFIG_PCMCIA_AXNET=3Dm
CONFIG_ARCNET_COM20020_CS=3Dm
CONFIG_WAN=3Dy
CONFIG_LANMEDIA=3Dm
CONFIG_HDLC=3Dm
CONFIG_HDLC_RAW=3Dm
CONFIG_HDLC_RAW_ETH=3Dm
CONFIG_HDLC_CISCO=3Dm
CONFIG_HDLC_FR=3Dm
CONFIG_HDLC_PPP=3Dm
CONFIG_HDLC_X25=3Dm
CONFIG_PCI200SYN=3Dm
CONFIG_WANXL=3Dm
CONFIG_PC300=3Dm
CONFIG_PC300_MLPPP=3Dy

#
# Cyclades-PC300 MLPPP support is disabled.
#

#
# Refer to the file README.mlppp, provided by PC300 package.
#
# CONFIG_PC300TOO is not set
CONFIG_FARSYNC=3Dm
CONFIG_DSCC4=3Dm
CONFIG_DSCC4_PCISYNC=3Dy
CONFIG_DSCC4_PCI_RST=3Dy
CONFIG_DLCI=3Dm
CONFIG_DLCI_MAX=3D8
CONFIG_WAN_ROUTER_DRIVERS=3Dm
CONFIG_CYCLADES_SYNC=3Dm
CONFIG_CYCLOMX_X25=3Dy
CONFIG_LAPBETHER=3Dm
CONFIG_X25_ASY=3Dm
CONFIG_SBNI=3Dm
# CONFIG_SBNI_MULTILINE is not set
CONFIG_ATM_DRIVERS=3Dy
CONFIG_ATM_DUMMY=3Dm
CONFIG_ATM_TCP=3Dm
CONFIG_ATM_LANAI=3Dm
CONFIG_ATM_ENI=3Dm
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=3Dm
CONFIG_ATM_ZATM=3Dm
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_IDT77252=3Dm
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=3Dy
CONFIG_ATM_HORIZON=3Dm
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=3Dm
CONFIG_ATM_HE=3Dm
CONFIG_ATM_HE_USE_SUNI=3Dy
CONFIG_FDDI=3Dy
CONFIG_DEFXX=3Dm
# CONFIG_DEFXX_MMIO is not set
CONFIG_SKFP=3Dm
CONFIG_HIPPI=3Dy
CONFIG_ROADRUNNER=3Dm
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPP_MPPE=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPPOATM=3Dm
CONFIG_PPPOL2TP=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLHC=3Dm
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
CONFIG_NET_FC=3Dy
CONFIG_NETCONSOLE=3Dm
CONFIG_NETCONSOLE_DYNAMIC=3Dy
CONFIG_NETPOLL=3Dy
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_VIRTIO_NET=3Dm
CONFIG_ISDN=3Dm
CONFIG_ISDN_I4L=3Dm
CONFIG_ISDN_PPP=3Dy
CONFIG_ISDN_PPP_VJ=3Dy
CONFIG_ISDN_MPP=3Dy
CONFIG_IPPP_FILTER=3Dy
CONFIG_ISDN_PPP_BSDCOMP=3Dm
CONFIG_ISDN_AUDIO=3Dy
CONFIG_ISDN_TTY_FAX=3Dy
CONFIG_ISDN_X25=3Dy

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=3Dm

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=3Dm

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=3Dy
CONFIG_DE_AOC=3Dy
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
CONFIG_HISAX_1TR6=3Dy
CONFIG_HISAX_NI1=3Dy
CONFIG_HISAX_MAX_CARDS=3D8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=3Dy
CONFIG_HISAX_TELESPCI=3Dy
CONFIG_HISAX_S0BOX=3Dy
CONFIG_HISAX_FRITZPCI=3Dy
CONFIG_HISAX_AVM_A1_PCMCIA=3Dy
CONFIG_HISAX_ELSA=3Dy
CONFIG_HISAX_DIEHLDIVA=3Dy
CONFIG_HISAX_SEDLBAUER=3Dy
CONFIG_HISAX_NETJET=3Dy
CONFIG_HISAX_NETJET_U=3Dy
CONFIG_HISAX_NICCY=3Dy
CONFIG_HISAX_BKM_A4T=3Dy
CONFIG_HISAX_SCT_QUADRO=3Dy
CONFIG_HISAX_GAZEL=3Dy
CONFIG_HISAX_HFC_PCI=3Dy
CONFIG_HISAX_W6692=3Dy
CONFIG_HISAX_HFC_SX=3Dy
CONFIG_HISAX_ENTERNOW_PCI=3Dy
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#
CONFIG_HISAX_SEDLBAUER_CS=3Dm
CONFIG_HISAX_ELSA_CS=3Dm
CONFIG_HISAX_AVM_A1_CS=3Dm
CONFIG_HISAX_TELES_CS=3Dm

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=3Dm
CONFIG_HISAX_HFCUSB=3Dm
CONFIG_HISAX_HFC4S8S=3Dm
CONFIG_HISAX_FRITZ_PCIPNP=3Dm
CONFIG_HISAX_HDLC=3Dy

#
# Active cards
#
CONFIG_HYSDN=3Dm
CONFIG_HYSDN_CAPI=3Dy
CONFIG_ISDN_DRV_GIGASET=3Dm
CONFIG_GIGASET_BASE=3Dm
CONFIG_GIGASET_M105=3Dm
CONFIG_GIGASET_M101=3Dm
# CONFIG_GIGASET_DEBUG is not set
# CONFIG_GIGASET_UNDOCREQ is not set
CONFIG_ISDN_CAPI=3Dm
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=3Dy
CONFIG_CAPI_TRACE=3Dy
CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
CONFIG_ISDN_CAPI_CAPI20=3Dm
CONFIG_ISDN_CAPI_CAPIFS_BOOL=3Dy
CONFIG_ISDN_CAPI_CAPIFS=3Dm
CONFIG_ISDN_CAPI_CAPIDRV=3Dm

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=3Dy
CONFIG_ISDN_DRV_AVMB1_B1PCI=3Dm
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=3Dy
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=3Dm
CONFIG_ISDN_DRV_AVMB1_AVM_CS=3Dm
CONFIG_ISDN_DRV_AVMB1_T1PCI=3Dm
CONFIG_ISDN_DRV_AVMB1_C4=3Dm
CONFIG_CAPI_EICON=3Dy
CONFIG_ISDN_DIVAS=3Dm
CONFIG_ISDN_DIVAS_BRIPCI=3Dy
CONFIG_ISDN_DIVAS_PRIPCI=3Dy
CONFIG_ISDN_DIVAS_DIVACAPI=3Dm
CONFIG_ISDN_DIVAS_USERIDI=3Dm
CONFIG_ISDN_DIVAS_MAINT=3Dm
CONFIG_PHONE=3Dm
CONFIG_PHONE_IXJ=3Dm
CONFIG_PHONE_IXJ_PCMCIA=3Dm

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm
CONFIG_INPUT_POLLDEV=3Dm

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_KEYBOARD_SUNKBD=3Dm
CONFIG_KEYBOARD_LKKBD=3Dm
CONFIG_KEYBOARD_XTKBD=3Dm
CONFIG_KEYBOARD_NEWTON=3Dm
CONFIG_KEYBOARD_STOWAWAY=3Dm
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dm
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_SERIAL=3Dm
CONFIG_MOUSE_APPLETOUCH=3Dm
CONFIG_MOUSE_VSXXXAA=3Dm
CONFIG_INPUT_JOYSTICK=3Dy
CONFIG_JOYSTICK_ANALOG=3Dm
CONFIG_JOYSTICK_A3D=3Dm
CONFIG_JOYSTICK_ADI=3Dm
CONFIG_JOYSTICK_COBRA=3Dm
CONFIG_JOYSTICK_GF2K=3Dm
CONFIG_JOYSTICK_GRIP=3Dm
CONFIG_JOYSTICK_GRIP_MP=3Dm
CONFIG_JOYSTICK_GUILLEMOT=3Dm
CONFIG_JOYSTICK_INTERACT=3Dm
CONFIG_JOYSTICK_SIDEWINDER=3Dm
CONFIG_JOYSTICK_TMDC=3Dm
CONFIG_JOYSTICK_IFORCE=3Dm
CONFIG_JOYSTICK_IFORCE_USB=3Dy
CONFIG_JOYSTICK_IFORCE_232=3Dy
CONFIG_JOYSTICK_WARRIOR=3Dm
CONFIG_JOYSTICK_MAGELLAN=3Dm
CONFIG_JOYSTICK_SPACEORB=3Dm
CONFIG_JOYSTICK_SPACEBALL=3Dm
CONFIG_JOYSTICK_STINGER=3Dm
CONFIG_JOYSTICK_TWIDJOY=3Dm
CONFIG_JOYSTICK_ZHENHUA=3Dm
CONFIG_JOYSTICK_DB9=3Dm
CONFIG_JOYSTICK_GAMECON=3Dm
CONFIG_JOYSTICK_TURBOGRAFX=3Dm
CONFIG_JOYSTICK_JOYDUMP=3Dm
CONFIG_JOYSTICK_XPAD=3Dm
CONFIG_JOYSTICK_XPAD_FF=3Dy
CONFIG_JOYSTICK_XPAD_LEDS=3Dy
CONFIG_INPUT_TABLET=3Dy
CONFIG_TABLET_USB_ACECAD=3Dm
CONFIG_TABLET_USB_AIPTEK=3Dm
CONFIG_TABLET_USB_GTCO=3Dm
CONFIG_TABLET_USB_KBTAB=3Dm
CONFIG_TABLET_USB_WACOM=3Dm
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_ADS7846=3Dm
CONFIG_TOUCHSCREEN_FUJITSU=3Dm
CONFIG_TOUCHSCREEN_GUNZE=3Dm
CONFIG_TOUCHSCREEN_ELO=3Dm
CONFIG_TOUCHSCREEN_MTOUCH=3Dm
CONFIG_TOUCHSCREEN_MK712=3Dm
CONFIG_TOUCHSCREEN_PENMOUNT=3Dm
CONFIG_TOUCHSCREEN_TOUCHRIGHT=3Dm
CONFIG_TOUCHSCREEN_TOUCHWIN=3Dm
CONFIG_TOUCHSCREEN_UCB1400=3Dm
CONFIG_TOUCHSCREEN_WM97XX=3Dm
CONFIG_TOUCHSCREEN_WM9705=3Dy
CONFIG_TOUCHSCREEN_WM9712=3Dy
CONFIG_TOUCHSCREEN_WM9713=3Dy
CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm
CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
CONFIG_TOUCHSCREEN_USB_3M=3Dy
CONFIG_TOUCHSCREEN_USB_ITM=3Dy
CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dm
CONFIG_INPUT_APANEL=3Dm
CONFIG_INPUT_ATLAS_BTNS=3Dm
CONFIG_INPUT_ATI_REMOTE=3Dm
CONFIG_INPUT_ATI_REMOTE2=3Dm
CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
CONFIG_INPUT_POWERMATE=3Dm
CONFIG_INPUT_YEALINK=3Dm
CONFIG_INPUT_UINPUT=3Dm

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dm
CONFIG_SERIO_CT82C710=3Dm
CONFIG_SERIO_PARKBD=3Dm
CONFIG_SERIO_PCIPS2=3Dm
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_SERIO_RAW=3Dm
CONFIG_GAMEPORT=3Dm
CONFIG_GAMEPORT_NS558=3Dm
CONFIG_GAMEPORT_L4=3Dm
CONFIG_GAMEPORT_EMU10K1=3Dm
CONFIG_GAMEPORT_FM801=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=3Dy
CONFIG_SERIAL_NONSTANDARD=3Dy
CONFIG_COMPUTONE=3Dm
CONFIG_ROCKETPORT=3Dm
CONFIG_CYCLADES=3Dm
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=3Dm
CONFIG_MOXA_INTELLIO=3Dm
CONFIG_MOXA_SMARTIO=3Dm
CONFIG_ISI=3Dm
CONFIG_SYNCLINK=3Dm
CONFIG_SYNCLINKMP=3Dm
CONFIG_SYNCLINK_GT=3Dm
CONFIG_N_HDLC=3Dm
CONFIG_RISCOM8=3Dm
CONFIG_SPECIALIX=3Dm
# CONFIG_SPECIALIX_RTSCTS is not set
CONFIG_SX=3Dm
CONFIG_RIO=3Dm
CONFIG_RIO_OLDPCI=3Dy
CONFIG_STALDRV=3Dy
CONFIG_NOZOMI=3Dm

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_PNP=3Dy
CONFIG_SERIAL_8250_CS=3Dm
CONFIG_SERIAL_8250_NR_UARTS=3D32
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=3Dy

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_JSM=3Dm
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
CONFIG_IPMI_HANDLER=3Dm
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_SI=3Dm
CONFIG_IPMI_WATCHDOG=3Dm
CONFIG_IPMI_POWEROFF=3Dm
CONFIG_HW_RANDOM=3Dm
CONFIG_HW_RANDOM_INTEL=3Dm
CONFIG_HW_RANDOM_AMD=3Dm
CONFIG_HW_RANDOM_VIRTIO=3Dm
CONFIG_NVRAM=3Dm
CONFIG_R3964=3Dm
CONFIG_APPLICOM=3Dm

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=3Dm
CONFIG_CARDMAN_4000=3Dm
CONFIG_CARDMAN_4040=3Dm
CONFIG_IPWIRELESS=3Dm
CONFIG_MWAVE=3Dm
CONFIG_PC8736x_GPIO=3Dm
CONFIG_NSC_GPIO=3Dm
CONFIG_RAW_DRIVER=3Dm
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HPET=3Dy
CONFIG_HPET_MMAP=3Dy
CONFIG_HANGCHECK_TIMER=3Dm
CONFIG_TCG_TPM=3Dm
CONFIG_TCG_TIS=3Dm
CONFIG_TCG_NSC=3Dm
CONFIG_TCG_ATMEL=3Dm
CONFIG_TCG_INFINEON=3Dm
CONFIG_TELCLOCK=3Dm
CONFIG_DEVPORT=3Dy
CONFIG_I2C=3Dm
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCA=3Dm

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI1563=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD756_S4882=3Dm
CONFIG_I2C_AMD8111=3Dm
CONFIG_I2C_I801=3Dm
CONFIG_I2C_I810=3Dm
CONFIG_I2C_PIIX4=3Dm
CONFIG_I2C_NFORCE2=3Dm
CONFIG_I2C_OCORES=3Dm
CONFIG_I2C_PARPORT=3Dm
CONFIG_I2C_PARPORT_LIGHT=3Dm
CONFIG_I2C_PROSAVAGE=3Dm
CONFIG_I2C_SAVAGE4=3Dm
CONFIG_I2C_SIMTEC=3Dm
CONFIG_I2C_SIS5595=3Dm
CONFIG_I2C_SIS630=3Dm
CONFIG_I2C_SIS96X=3Dm
CONFIG_I2C_TAOS_EVM=3Dm
CONFIG_I2C_STUB=3Dm
CONFIG_I2C_TINY_USB=3Dm
CONFIG_I2C_VIA=3Dm
CONFIG_I2C_VIAPRO=3Dm
CONFIG_I2C_VOODOO3=3Dm
CONFIG_I2C_PCA_PLATFORM=3Dm

#
# Miscellaneous I2C Chip support
#
CONFIG_DS1682=3Dm
CONFIG_SENSORS_EEPROM=3Dm
CONFIG_SENSORS_PCF8574=3Dm
CONFIG_PCF8575=3Dm
CONFIG_SENSORS_PCF8591=3Dm
CONFIG_SENSORS_MAX6875=3Dm
CONFIG_SENSORS_TSL2550=3Dm
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
CONFIG_SPI=3Dy
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=3Dy

#
# SPI Master Controller Drivers
#
CONFIG_SPI_BITBANG=3Dm
CONFIG_SPI_BUTTERFLY=3Dm
CONFIG_SPI_LM70_LLP=3Dm

#
# SPI Protocol Masters
#
CONFIG_SPI_AT25=3Dm
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=3Dm
CONFIG_W1=3Dm
CONFIG_W1_CON=3Dy

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=3Dm
CONFIG_W1_MASTER_DS2490=3Dm
CONFIG_W1_MASTER_DS2482=3Dm

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=3Dm
CONFIG_W1_SLAVE_SMEM=3Dm
CONFIG_W1_SLAVE_DS2433=3Dm
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2760=3Dm
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=3Dm
CONFIG_BATTERY_DS2760=3Dm
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dm
CONFIG_SENSORS_ABITUGURU=3Dm
CONFIG_SENSORS_ABITUGURU3=3Dm
CONFIG_SENSORS_AD7418=3Dm
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_ADM1025=3Dm
CONFIG_SENSORS_ADM1026=3Dm
CONFIG_SENSORS_ADM1029=3Dm
CONFIG_SENSORS_ADM1031=3Dm
CONFIG_SENSORS_ADM9240=3Dm
CONFIG_SENSORS_ADT7470=3Dm
CONFIG_SENSORS_ADT7473=3Dm
CONFIG_SENSORS_K8TEMP=3Dm
CONFIG_SENSORS_ASB100=3Dm
CONFIG_SENSORS_ATXP1=3Dm
CONFIG_SENSORS_DS1621=3Dm
CONFIG_SENSORS_I5K_AMB=3Dm
CONFIG_SENSORS_F71805F=3Dm
CONFIG_SENSORS_F71882FG=3Dm
CONFIG_SENSORS_F75375S=3Dm
CONFIG_SENSORS_FSCHER=3Dm
CONFIG_SENSORS_FSCPOS=3Dm
CONFIG_SENSORS_FSCHMD=3Dm
CONFIG_SENSORS_GL518SM=3Dm
CONFIG_SENSORS_GL520SM=3Dm
CONFIG_SENSORS_CORETEMP=3Dm
CONFIG_SENSORS_IBMAEM=3Dm
CONFIG_SENSORS_IBMPEX=3Dm
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_LM63=3Dm
CONFIG_SENSORS_LM70=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM77=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM80=3Dm
CONFIG_SENSORS_LM83=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_LM87=3Dm
CONFIG_SENSORS_LM90=3Dm
CONFIG_SENSORS_LM92=3Dm
CONFIG_SENSORS_LM93=3Dm
CONFIG_SENSORS_MAX1619=3Dm
CONFIG_SENSORS_MAX6650=3Dm
CONFIG_SENSORS_PC87360=3Dm
CONFIG_SENSORS_PC87427=3Dm
CONFIG_SENSORS_SIS5595=3Dm
CONFIG_SENSORS_DME1737=3Dm
CONFIG_SENSORS_SMSC47M1=3Dm
CONFIG_SENSORS_SMSC47M192=3Dm
CONFIG_SENSORS_SMSC47B397=3Dm
CONFIG_SENSORS_ADS7828=3Dm
CONFIG_SENSORS_THMC50=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_VT1211=3Dm
CONFIG_SENSORS_VT8231=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83791D=3Dm
CONFIG_SENSORS_W83792D=3Dm
CONFIG_SENSORS_W83793=3Dm
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_SENSORS_W83L786NG=3Dm
CONFIG_SENSORS_W83627HF=3Dm
CONFIG_SENSORS_W83627EHF=3Dm
CONFIG_SENSORS_HDAPS=3Dm
CONFIG_SENSORS_APPLESMC=3Dm
# CONFIG_HWMON_DEBUG_CHIP is not set
CONFIG_THERMAL=3Dm
CONFIG_THERMAL_HWMON=3Dy
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
CONFIG_ACQUIRE_WDT=3Dm
CONFIG_ADVANTECH_WDT=3Dm
CONFIG_ALIM1535_WDT=3Dm
CONFIG_ALIM7101_WDT=3Dm
CONFIG_SC520_WDT=3Dm
CONFIG_EUROTECH_WDT=3Dm
CONFIG_IB700_WDT=3Dm
CONFIG_IBMASR=3Dm
CONFIG_WAFER_WDT=3Dm
CONFIG_I6300ESB_WDT=3Dm
CONFIG_ITCO_WDT=3Dm
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=3Dm
CONFIG_HP_WATCHDOG=3Dm
CONFIG_SC1200_WDT=3Dm
CONFIG_PC87413_WDT=3Dm
CONFIG_60XX_WDT=3Dm
CONFIG_SBC8360_WDT=3Dm
CONFIG_CPU5_WDT=3Dm
CONFIG_SMSC37B787_WDT=3Dm
CONFIG_W83627HF_WDT=3Dm
CONFIG_W83697HF_WDT=3Dm
CONFIG_W83877F_WDT=3Dm
CONFIG_W83977F_WDT=3Dm
CONFIG_MACHZ_WDT=3Dm
CONFIG_SBC_EPX_C3_WATCHDOG=3Dm

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=3Dm
CONFIG_WDTPCI=3Dm
CONFIG_WDT_501_PCI=3Dy

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=3Dm

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=3Dy
CONFIG_SSB=3Dm
CONFIG_SSB_SPROM=3Dy
CONFIG_SSB_BLOCKIO=3Dy
CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
CONFIG_SSB_PCIHOST=3Dy
CONFIG_SSB_B43_PCI_BRIDGE=3Dy
CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy
CONFIG_SSB_PCMCIAHOST=3Dy
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
CONFIG_SSB_DRIVER_PCICORE=3Dy

#
# Multifunction device drivers
#
CONFIG_MFD_SM501=3Dm
CONFIG_HTC_PASIC3=3Dm

#
# Multimedia devices
#

#
# Multimedia core support
#
CONFIG_VIDEO_DEV=3Dm
CONFIG_VIDEO_V4L2_COMMON=3Dm
CONFIG_VIDEO_ALLOW_V4L1=3Dy
CONFIG_VIDEO_V4L1_COMPAT=3Dy
CONFIG_DVB_CORE=3Dm
CONFIG_VIDEO_MEDIA=3Dm

#
# Multimedia drivers
#
CONFIG_VIDEO_SAA7146=3Dm
CONFIG_VIDEO_SAA7146_VV=3Dm
CONFIG_MEDIA_ATTACH=3Dy
CONFIG_MEDIA_TUNER=3Dm
# CONFIG_MEDIA_TUNER_CUSTOMIZE is not set
CONFIG_MEDIA_TUNER_SIMPLE=3Dm
CONFIG_MEDIA_TUNER_TDA8290=3Dm
CONFIG_MEDIA_TUNER_TDA827X=3Dm
CONFIG_MEDIA_TUNER_TDA18271=3Dm
CONFIG_MEDIA_TUNER_TDA9887=3Dm
CONFIG_MEDIA_TUNER_TEA5761=3Dm
CONFIG_MEDIA_TUNER_TEA5767=3Dm
CONFIG_MEDIA_TUNER_MT20XX=3Dm
CONFIG_MEDIA_TUNER_MT2060=3Dm
CONFIG_MEDIA_TUNER_MT2266=3Dm
CONFIG_MEDIA_TUNER_MT2131=3Dm
CONFIG_MEDIA_TUNER_QT1010=3Dm
CONFIG_MEDIA_TUNER_XC2028=3Dm
CONFIG_MEDIA_TUNER_XC5000=3Dm
CONFIG_MEDIA_TUNER_MXL5005S=3Dm
CONFIG_VIDEO_V4L2=3Dm
CONFIG_VIDEO_V4L1=3Dm
CONFIG_VIDEOBUF_GEN=3Dm
CONFIG_VIDEOBUF_DMA_SG=3Dm
CONFIG_VIDEOBUF_VMALLOC=3Dm
CONFIG_VIDEOBUF_DVB=3Dm
CONFIG_VIDEO_BTCX=3Dm
CONFIG_VIDEO_IR_I2C=3Dm
CONFIG_VIDEO_IR=3Dm
CONFIG_VIDEO_TVEEPROM=3Dm
CONFIG_VIDEO_TUNER=3Dm
CONFIG_VIDEO_CAPTURE_DRIVERS=3Dy
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_HELPER_CHIPS_AUTO=3Dy
CONFIG_VIDEO_TVAUDIO=3Dm
CONFIG_VIDEO_TDA7432=3Dm
CONFIG_VIDEO_TDA9840=3Dm
CONFIG_VIDEO_TDA9875=3Dm
CONFIG_VIDEO_TEA6415C=3Dm
CONFIG_VIDEO_TEA6420=3Dm
CONFIG_VIDEO_MSP3400=3Dm
CONFIG_VIDEO_CS5345=3Dm
CONFIG_VIDEO_CS53L32A=3Dm
CONFIG_VIDEO_M52790=3Dm
CONFIG_VIDEO_WM8775=3Dm
CONFIG_VIDEO_WM8739=3Dm
CONFIG_VIDEO_VP27SMPX=3Dm
CONFIG_VIDEO_BT819=3Dm
CONFIG_VIDEO_BT856=3Dm
CONFIG_VIDEO_KS0127=3Dm
CONFIG_VIDEO_OV7670=3Dm
CONFIG_VIDEO_SAA7110=3Dm
CONFIG_VIDEO_SAA7111=3Dm
CONFIG_VIDEO_SAA7114=3Dm
CONFIG_VIDEO_SAA711X=3Dm
CONFIG_VIDEO_SAA717X=3Dm
CONFIG_VIDEO_TVP5150=3Dm
CONFIG_VIDEO_VPX3220=3Dm
CONFIG_VIDEO_CX25840=3Dm
CONFIG_VIDEO_CX2341X=3Dm
CONFIG_VIDEO_SAA7127=3Dm
CONFIG_VIDEO_SAA7185=3Dm
CONFIG_VIDEO_ADV7170=3Dm
CONFIG_VIDEO_ADV7175=3Dm
CONFIG_VIDEO_UPD64031A=3Dm
CONFIG_VIDEO_UPD64083=3Dm
CONFIG_VIDEO_VIVI=3Dm
CONFIG_VIDEO_BT848=3Dm
CONFIG_VIDEO_BT848_DVB=3Dy
CONFIG_VIDEO_SAA6588=3Dm
CONFIG_VIDEO_BWQCAM=3Dm
CONFIG_VIDEO_CQCAM=3Dm
CONFIG_VIDEO_W9966=3Dm
CONFIG_VIDEO_CPIA=3Dm
CONFIG_VIDEO_CPIA_PP=3Dm
CONFIG_VIDEO_CPIA_USB=3Dm
CONFIG_VIDEO_CPIA2=3Dm
CONFIG_VIDEO_SAA5246A=3Dm
CONFIG_VIDEO_SAA5249=3Dm
CONFIG_TUNER_3036=3Dm
CONFIG_VIDEO_STRADIS=3Dm
CONFIG_VIDEO_ZORAN_ZR36060=3Dm
CONFIG_VIDEO_ZORAN=3Dm
CONFIG_VIDEO_ZORAN_BUZ=3Dm
CONFIG_VIDEO_ZORAN_DC10=3Dm
CONFIG_VIDEO_ZORAN_DC30=3Dm
CONFIG_VIDEO_ZORAN_LML33=3Dm
CONFIG_VIDEO_ZORAN_LML33R10=3Dm
CONFIG_VIDEO_ZORAN_AVS6EYES=3Dm
CONFIG_VIDEO_MEYE=3Dm
CONFIG_VIDEO_SAA7134=3Dm
CONFIG_VIDEO_SAA7134_ALSA=3Dm
CONFIG_VIDEO_SAA7134_DVB=3Dm
CONFIG_VIDEO_MXB=3Dm
CONFIG_VIDEO_DPC=3Dm
CONFIG_VIDEO_HEXIUM_ORION=3Dm
CONFIG_VIDEO_HEXIUM_GEMINI=3Dm
CONFIG_VIDEO_CX88=3Dm
CONFIG_VIDEO_CX88_ALSA=3Dm
CONFIG_VIDEO_CX88_BLACKBIRD=3Dm
CONFIG_VIDEO_CX88_DVB=3Dm
CONFIG_VIDEO_CX88_VP3054=3Dm
CONFIG_VIDEO_CX23885=3Dm
CONFIG_VIDEO_AU0828=3Dm
CONFIG_VIDEO_IVTV=3Dm
CONFIG_VIDEO_FB_IVTV=3Dm
CONFIG_VIDEO_CX18=3Dm
CONFIG_VIDEO_CAFE_CCIC=3Dm
CONFIG_V4L_USB_DRIVERS=3Dy
CONFIG_USB_VIDEO_CLASS=3Dm
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
CONFIG_VIDEO_PVRUSB2=3Dm
CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
CONFIG_VIDEO_PVRUSB2_DVB=3Dy
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_EM28XX=3Dm
CONFIG_VIDEO_EM28XX_ALSA=3Dm
CONFIG_VIDEO_EM28XX_DVB=3Dm
CONFIG_VIDEO_USBVISION=3Dm
CONFIG_VIDEO_USBVIDEO=3Dm
CONFIG_USB_VICAM=3Dm
CONFIG_USB_IBMCAM=3Dm
CONFIG_USB_KONICAWC=3Dm
CONFIG_USB_QUICKCAM_MESSENGER=3Dm
CONFIG_USB_ET61X251=3Dm
CONFIG_VIDEO_OVCAMCHIP=3Dm
CONFIG_USB_W9968CF=3Dm
CONFIG_USB_OV511=3Dm
CONFIG_USB_SE401=3Dm
CONFIG_USB_SN9C102=3Dm
CONFIG_USB_STV680=3Dm
CONFIG_USB_ZC0301=3Dm
CONFIG_USB_PWC=3Dm
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_ZR364XX=3Dm
CONFIG_USB_STKWEBCAM=3Dm
CONFIG_SOC_CAMERA=3Dm
CONFIG_SOC_CAMERA_MT9M001=3Dm
CONFIG_SOC_CAMERA_MT9V022=3Dm
CONFIG_RADIO_ADAPTERS=3Dy
CONFIG_RADIO_GEMTEK_PCI=3Dm
CONFIG_RADIO_MAXIRADIO=3Dm
CONFIG_RADIO_MAESTRO=3Dm
CONFIG_USB_DSBR=3Dm
CONFIG_USB_SI470X=3Dm
CONFIG_DVB_CAPTURE_DRIVERS=3Dy

#
# Supported SAA7146 based PCI Adapters
#
CONFIG_TTPCI_EEPROM=3Dm
CONFIG_DVB_AV7110=3Dm
CONFIG_DVB_AV7110_OSD=3Dy
CONFIG_DVB_BUDGET_CORE=3Dm
CONFIG_DVB_BUDGET=3Dm
CONFIG_DVB_BUDGET_CI=3Dm
CONFIG_DVB_BUDGET_AV=3Dm
CONFIG_DVB_BUDGET_PATCH=3Dm

#
# Supported USB Adapters
#
CONFIG_DVB_USB=3Dm
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_A800=3Dm
CONFIG_DVB_USB_DIBUSB_MB=3Dm
CONFIG_DVB_USB_DIBUSB_MB_FAULTY=3Dy
CONFIG_DVB_USB_DIBUSB_MC=3Dm
CONFIG_DVB_USB_DIB0700=3Dm
CONFIG_DVB_USB_UMT_010=3Dm
CONFIG_DVB_USB_CXUSB=3Dm
CONFIG_DVB_USB_M920X=3Dm
CONFIG_DVB_USB_GL861=3Dm
CONFIG_DVB_USB_AU6610=3Dm
CONFIG_DVB_USB_DIGITV=3Dm
CONFIG_DVB_USB_VP7045=3Dm
CONFIG_DVB_USB_VP702X=3Dm
CONFIG_DVB_USB_GP8PSK=3Dm
CONFIG_DVB_USB_NOVA_T_USB2=3Dm
CONFIG_DVB_USB_TTUSB2=3Dm
CONFIG_DVB_USB_DTT200U=3Dm
CONFIG_DVB_USB_OPERA1=3Dm
CONFIG_DVB_USB_AF9005=3Dm
CONFIG_DVB_USB_AF9005_REMOTE=3Dm
CONFIG_DVB_TTUSB_DEC=3Dm
CONFIG_DVB_CINERGYT2=3Dm
# CONFIG_DVB_CINERGYT2_TUNING is not set

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_FLEXCOP=3Dm
CONFIG_DVB_B2C2_FLEXCOP_PCI=3Dm
CONFIG_DVB_B2C2_FLEXCOP_USB=3Dm
# CONFIG_DVB_B2C2_FLEXCOP_DEBUG is not set

#
# Supported BT878 Adapters
#
CONFIG_DVB_BT8XX=3Dm

#
# Supported Pluto2 Adapters
#
CONFIG_DVB_PLUTO2=3Dm

#
# Supported DVB Frontends
#

#
# Customise DVB Frontends
#
# CONFIG_DVB_FE_CUSTOMISE is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=3Dm
CONFIG_DVB_CX24123=3Dm
CONFIG_DVB_MT312=3Dm
CONFIG_DVB_S5H1420=3Dm
CONFIG_DVB_STV0299=3Dm
CONFIG_DVB_TDA8083=3Dm
CONFIG_DVB_TDA10086=3Dm
CONFIG_DVB_VES1X93=3Dm
CONFIG_DVB_TUNER_ITD1000=3Dm
CONFIG_DVB_TDA826X=3Dm
CONFIG_DVB_TUA6100=3Dm

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=3Dm
CONFIG_DVB_SP887X=3Dm
CONFIG_DVB_CX22700=3Dm
CONFIG_DVB_CX22702=3Dm
CONFIG_DVB_L64781=3Dm
CONFIG_DVB_TDA1004X=3Dm
CONFIG_DVB_NXT6000=3Dm
CONFIG_DVB_MT352=3Dm
CONFIG_DVB_ZL10353=3Dm
CONFIG_DVB_DIB3000MB=3Dm
CONFIG_DVB_DIB3000MC=3Dm
CONFIG_DVB_DIB7000M=3Dm
CONFIG_DVB_DIB7000P=3Dm
CONFIG_DVB_TDA10048=3Dm

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=3Dm
CONFIG_DVB_TDA10021=3Dm
CONFIG_DVB_TDA10023=3Dm
CONFIG_DVB_STV0297=3Dm

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=3Dm
CONFIG_DVB_OR51211=3Dm
CONFIG_DVB_OR51132=3Dm
CONFIG_DVB_BCM3510=3Dm
CONFIG_DVB_LGDT330X=3Dm
CONFIG_DVB_S5H1409=3Dm
CONFIG_DVB_AU8522=3Dm
CONFIG_DVB_S5H1411=3Dm

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=3Dm
CONFIG_DVB_TUNER_DIB0070=3Dm

#
# SEC control devices for DVB-S
#
CONFIG_DVB_LNBP21=3Dm
CONFIG_DVB_ISL6405=3Dm
CONFIG_DVB_ISL6421=3Dm
CONFIG_DAB=3Dy
CONFIG_USB_DABUSB=3Dm

#
# Graphics support
#
CONFIG_AGP=3Dy
CONFIG_AGP_AMD64=3Dy
CONFIG_AGP_INTEL=3Dm
CONFIG_AGP_SIS=3Dm
CONFIG_AGP_VIA=3Dm
CONFIG_DRM=3Dm
CONFIG_DRM_TDFX=3Dm
CONFIG_DRM_R128=3Dm
CONFIG_DRM_RADEON=3Dm
CONFIG_DRM_I810=3Dm
CONFIG_DRM_I830=3Dm
CONFIG_DRM_I915=3Dm
CONFIG_DRM_MGA=3Dm
CONFIG_DRM_SIS=3Dm
CONFIG_DRM_VIA=3Dm
CONFIG_DRM_SAVAGE=3Dm
CONFIG_VGASTATE=3Dm
CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB_DDC=3Dm
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=3Dm
CONFIG_FB_SYS_COPYAREA=3Dm
CONFIG_FB_SYS_IMAGEBLIT=3Dm
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=3Dm
CONFIG_FB_DEFERRED_IO=3Dy
CONFIG_FB_HECUBA=3Dm
CONFIG_FB_SVGALIB=3Dm
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=3Dm
CONFIG_FB_PM2=3Dm
CONFIG_FB_PM2_FIFO_DISCONNECT=3Dy
CONFIG_FB_CYBER2000=3Dm
CONFIG_FB_ARC=3Dm
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=3Dm
CONFIG_FB_UVESA=3Dm
CONFIG_FB_VESA=3Dy
CONFIG_FB_EFI=3Dy
# CONFIG_FB_IMAC is not set
CONFIG_FB_N411=3Dm
CONFIG_FB_HGA=3Dm
# CONFIG_FB_HGA_ACCEL is not set
CONFIG_FB_S1D13XXX=3Dm
CONFIG_FB_NVIDIA=3Dm
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=3Dy
# CONFIG_FB_RIVA is not set
CONFIG_FB_LE80578=3Dm
CONFIG_FB_CARILLO_RANCH=3Dm
CONFIG_FB_INTEL=3Dm
# CONFIG_FB_INTEL_DEBUG is not set
CONFIG_FB_INTEL_I2C=3Dy
CONFIG_FB_MATROX=3Dm
CONFIG_FB_MATROX_MILLENIUM=3Dy
CONFIG_FB_MATROX_MYSTIQUE=3Dy
CONFIG_FB_MATROX_G=3Dy
CONFIG_FB_MATROX_I2C=3Dm
CONFIG_FB_MATROX_MAVEN=3Dm
CONFIG_FB_MATROX_MULTIHEAD=3Dy
CONFIG_FB_RADEON=3Dm
CONFIG_FB_RADEON_I2C=3Dy
CONFIG_FB_RADEON_BACKLIGHT=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=3Dm
CONFIG_FB_ATY128_BACKLIGHT=3Dy
CONFIG_FB_ATY=3Dm
CONFIG_FB_ATY_CT=3Dy
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=3Dy
CONFIG_FB_ATY_BACKLIGHT=3Dy
CONFIG_FB_S3=3Dm
CONFIG_FB_SAVAGE=3Dm
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=3Dm
CONFIG_FB_SIS_300=3Dy
CONFIG_FB_SIS_315=3Dy
CONFIG_FB_NEOMAGIC=3Dm
CONFIG_FB_KYRO=3Dm
CONFIG_FB_3DFX=3Dm
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_VOODOO1=3Dm
CONFIG_FB_VT8623=3Dm
CONFIG_FB_TRIDENT=3Dm
# CONFIG_FB_TRIDENT_ACCEL is not set
CONFIG_FB_ARK=3Dm
CONFIG_FB_PM3=3Dm
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=3Dm
CONFIG_FB_VIRTUAL=3Dm
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_CORGI is not set
CONFIG_BACKLIGHT_PROGEAR=3Dm

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=3Dm

#
# Display hardware drivers
#

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=3Dy

#
# Generic devices
#
CONFIG_SND_PCSP=3Dm
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dm
CONFIG_SND_VX_LIB=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_MTS64=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm
CONFIG_SND_PORTMAN2X4=3Dm
CONFIG_SND_SB_COMMON=3Dm
CONFIG_SND_SB16_DSP=3Dm

#
# PCI devices
#
CONFIG_SND_AD1889=3Dm
CONFIG_SND_ALS300=3Dm
CONFIG_SND_ALS4000=3Dm
CONFIG_SND_ALI5451=3Dm
CONFIG_SND_ATIIXP=3Dm
CONFIG_SND_ATIIXP_MODEM=3Dm
CONFIG_SND_AU8810=3Dm
CONFIG_SND_AU8820=3Dm
CONFIG_SND_AU8830=3Dm
# CONFIG_SND_AW2 is not set
CONFIG_SND_AZT3328=3Dm
CONFIG_SND_BT87X=3Dm
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=3Dm
CONFIG_SND_CMIPCI=3Dm
CONFIG_SND_OXYGEN_LIB=3Dm
CONFIG_SND_OXYGEN=3Dm
CONFIG_SND_CS4281=3Dm
CONFIG_SND_CS5530=3Dm
CONFIG_SND_DARLA20=3Dm
CONFIG_SND_GINA20=3Dm
CONFIG_SND_LAYLA20=3Dm
CONFIG_SND_DARLA24=3Dm
CONFIG_SND_GINA24=3Dm
CONFIG_SND_LAYLA24=3Dm
CONFIG_SND_MONA=3Dm
CONFIG_SND_MIA=3Dm
CONFIG_SND_ECHO3G=3Dm
CONFIG_SND_INDIGO=3Dm
CONFIG_SND_INDIGOIO=3Dm
CONFIG_SND_INDIGODJ=3Dm
CONFIG_SND_EMU10K1=3Dm
CONFIG_SND_EMU10K1X=3Dm
CONFIG_SND_ENS1370=3Dm
CONFIG_SND_ENS1371=3Dm
CONFIG_SND_ES1938=3Dm
CONFIG_SND_ES1968=3Dm
CONFIG_SND_FM801=3Dm
CONFIG_SND_FM801_TEA575X_BOOL=3Dy
CONFIG_SND_FM801_TEA575X=3Dm
CONFIG_SND_HDA_INTEL=3Dm
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_CODEC_REALTEK=3Dy
CONFIG_SND_HDA_CODEC_ANALOG=3Dy
CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy
CONFIG_SND_HDA_CODEC_VIA=3Dy
CONFIG_SND_HDA_CODEC_ATIHDMI=3Dy
CONFIG_SND_HDA_CODEC_CONEXANT=3Dy
CONFIG_SND_HDA_CODEC_CMEDIA=3Dy
CONFIG_SND_HDA_CODEC_SI3054=3Dy
CONFIG_SND_HDA_GENERIC=3Dy
CONFIG_SND_HDA_POWER_SAVE=3Dy
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
CONFIG_SND_HDSP=3Dm
CONFIG_SND_HDSPM=3Dm
CONFIG_SND_HIFIER=3Dm
CONFIG_SND_ICE1712=3Dm
CONFIG_SND_ICE1724=3Dm
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_INTEL8X0M=3Dm
CONFIG_SND_KORG1212=3Dm
CONFIG_SND_MAESTRO3=3Dm
CONFIG_SND_MIXART=3Dm
CONFIG_SND_NM256=3Dm
CONFIG_SND_PCXHR=3Dm
CONFIG_SND_RIPTIDE=3Dm
CONFIG_SND_RME32=3Dm
CONFIG_SND_RME96=3Dm
CONFIG_SND_RME9652=3Dm
CONFIG_SND_SONICVIBES=3Dm
CONFIG_SND_TRIDENT=3Dm
CONFIG_SND_VIA82XX=3Dm
CONFIG_SND_VIA82XX_MODEM=3Dm
CONFIG_SND_VIRTUOSO=3Dm
CONFIG_SND_VX222=3Dm
CONFIG_SND_YMFPCI=3Dm
CONFIG_SND_AC97_POWER_SAVE=3Dy
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0

#
# SPI devices
#

#
# USB devices
#
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_USB_USX2Y=3Dm
CONFIG_SND_USB_CAIAQ=3Dm
CONFIG_SND_USB_CAIAQ_INPUT=3Dy

#
# PCMCIA devices
#
CONFIG_SND_VXPOCKET=3Dm
CONFIG_SND_PDAUDIOCF=3Dm

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# ALSA SoC audio for Freescale SOCs
#

#
# SoC Audio for the Texas Instruments OMAP
#

#
# Open Sound System
#
CONFIG_SOUND_PRIME=3Dm
CONFIG_SOUND_TRIDENT=3Dm
CONFIG_SOUND_OSS=3Dm
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
CONFIG_SOUND_SSCAPE=3Dm
CONFIG_SOUND_VMIDI=3Dm
CONFIG_SOUND_TRIX=3Dm
CONFIG_SOUND_MSS=3Dm
CONFIG_SOUND_MPU401=3Dm
CONFIG_SOUND_PAS=3Dm
CONFIG_SOUND_PSS=3Dm
CONFIG_PSS_MIXER=3Dy
CONFIG_SOUND_SB=3Dm
CONFIG_SOUND_YM3812=3Dm
CONFIG_SOUND_UART6850=3Dm
CONFIG_SOUND_AEDSP16=3Dm
CONFIG_SC6600=3Dy
CONFIG_SC6600_JOY=3Dy
CONFIG_SC6600_CDROM=3D4
CONFIG_SC6600_CDROMBASE=3D0x0
# CONFIG_AEDSP16_MSS is not set
# CONFIG_AEDSP16_SBPRO is not set
CONFIG_SOUND_KAHLUA=3Dm
CONFIG_AC97_BUS=3Dm
CONFIG_HID_SUPPORT=3Dy
CONFIG_HID=3Dm
# CONFIG_HID_DEBUG is not set
CONFIG_HIDRAW=3Dy

#
# USB Input Devices
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT_POWERBOOK=3Dy
CONFIG_HID_FF=3Dy
CONFIG_HID_PID=3Dy
CONFIG_LOGITECH_FF=3Dy
CONFIG_LOGIRUMBLEPAD2_FF=3Dy
CONFIG_PANTHERLORD_FF=3Dy
CONFIG_THRUSTMASTER_FF=3Dy
CONFIG_ZEROPLUS_FF=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=3Dm
CONFIG_USB_MOUSE=3Dm
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_DEVICE_CLASS=3Dy
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=3Dy
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=3Dm
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_ISP116X_HCD=3Dm
CONFIG_USB_ISP1760_HCD=3Dm
# CONFIG_USB_ISP1760_PCI is not set
CONFIG_USB_OHCI_HCD=3Dm
# CONFIG_USB_OHCI_HCD_SSB is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_U132_HCD=3Dm
CONFIG_USB_SL811_HCD=3Dm
CONFIG_USB_SL811_CS=3Dm
CONFIG_USB_R8A66597_HCD=3Dm

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_USBAT=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy
CONFIG_USB_STORAGE_ALAUDA=3Dy
CONFIG_USB_STORAGE_ONETOUCH=3Dy
CONFIG_USB_STORAGE_KARMA=3Dy
CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dy
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USB_MON=3Dy

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_EZUSB=3Dy
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_AIRCABLE=3Dm
CONFIG_USB_SERIAL_AIRPRIME=3Dm
CONFIG_USB_SERIAL_ARK3116=3Dm
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP2101=3Dm
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_FUNSOFT=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_GARMIN=3Dm
CONFIG_USB_SERIAL_IPW=3Dm
CONFIG_USB_SERIAL_IUU=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_MOS7720=3Dm
CONFIG_USB_SERIAL_MOS7840=3Dm
CONFIG_USB_SERIAL_MOTOROLA=3Dm
CONFIG_USB_SERIAL_NAVMAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_SPCP8X5=3Dm
CONFIG_USB_SERIAL_HP4X=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_SERIAL_DEBUG=3Dm

#
# USB Miscellaneous drivers
#
CONFIG_USB_ADUTUX=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_BERRY_CHARGE=3Dm
CONFIG_USB_LED=3Dm
CONFIG_USB_CYPRESS_CY7C63=3Dm
CONFIG_USB_CYTHERM=3Dm
CONFIG_USB_PHIDGET=3Dm
CONFIG_USB_PHIDGETKIT=3Dm
CONFIG_USB_PHIDGETMOTORCONTROL=3Dm
CONFIG_USB_PHIDGETSERVO=3Dm
CONFIG_USB_IDMOUSE=3Dm
CONFIG_USB_FTDI_ELAN=3Dm
CONFIG_USB_APPLEDISPLAY=3Dm
CONFIG_USB_SISUSBVGA=3Dm
CONFIG_USB_SISUSBVGA_CON=3Dy
CONFIG_USB_LD=3Dm
CONFIG_USB_TRANCEVIBRATOR=3Dm
CONFIG_USB_IOWARRIOR=3Dm
CONFIG_USB_TEST=3Dm
CONFIG_USB_ISIGHTFW=3Dm
CONFIG_USB_ATM=3Dm
CONFIG_USB_SPEEDTOUCH=3Dm
CONFIG_USB_CXACRU=3Dm
CONFIG_USB_UEAGLEATM=3Dm
CONFIG_USB_XUSBATM=3Dm
# CONFIG_USB_GADGET is not set
CONFIG_MMC=3Dm
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_UNSAFE_RESUME is not set

#
# MMC/SD Card Drivers
#
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_BLOCK_BOUNCE=3Dy
CONFIG_SDIO_UART=3Dm
# CONFIG_MMC_TEST is not set

#
# MMC/SD Host Controller Drivers
#
CONFIG_MMC_SDHCI=3Dm
CONFIG_MMC_RICOH_MMC=3Dm
CONFIG_MMC_WBSD=3Dm
CONFIG_MMC_TIFM_SD=3Dm
CONFIG_MMC_SPI=3Dm
CONFIG_MEMSTICK=3Dm
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=3Dm

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=3Dm
CONFIG_MEMSTICK_JMICRON_38X=3Dm
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dm

#
# LED drivers
#
CONFIG_LEDS_CLEVO_MAIL=3Dm

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=3Dy
CONFIG_LEDS_TRIGGER_TIMER=3Dm
CONFIG_LEDS_TRIGGER_IDE_DISK=3Dy
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
CONFIG_ACCESSIBILITY=3Dy
CONFIG_A11Y_BRAILLE_CONSOLE=3Dy
CONFIG_INFINIBAND=3Dm
CONFIG_INFINIBAND_USER_MAD=3Dm
CONFIG_INFINIBAND_USER_ACCESS=3Dm
CONFIG_INFINIBAND_USER_MEM=3Dy
CONFIG_INFINIBAND_ADDR_TRANS=3Dy
CONFIG_INFINIBAND_MTHCA=3Dm
CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
CONFIG_INFINIBAND_IPATH=3Dm
CONFIG_INFINIBAND_AMSO1100=3Dm
# CONFIG_INFINIBAND_AMSO1100_DEBUG is not set
CONFIG_INFINIBAND_CXGB3=3Dm
# CONFIG_INFINIBAND_CXGB3_DEBUG is not set
CONFIG_MLX4_INFINIBAND=3Dm
CONFIG_INFINIBAND_NES=3Dm
# CONFIG_INFINIBAND_NES_DEBUG is not set
CONFIG_INFINIBAND_IPOIB=3Dm
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=3Dm
CONFIG_INFINIBAND_ISER=3Dm
CONFIG_EDAC=3Dy

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=3Dm
CONFIG_EDAC_E752X=3Dm
CONFIG_EDAC_I82975X=3Dm
CONFIG_EDAC_I3000=3Dm
CONFIG_EDAC_I5000=3Dm
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=3Dm
CONFIG_RTC_DRV_DS1374=3Dm
CONFIG_RTC_DRV_DS1672=3Dm
CONFIG_RTC_DRV_MAX6900=3Dm
CONFIG_RTC_DRV_RS5C372=3Dm
CONFIG_RTC_DRV_ISL1208=3Dm
CONFIG_RTC_DRV_X1205=3Dm
CONFIG_RTC_DRV_PCF8563=3Dm
CONFIG_RTC_DRV_PCF8583=3Dm
CONFIG_RTC_DRV_M41T80=3Dm
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_S35390A=3Dm
CONFIG_RTC_DRV_FM3130=3Dm

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_MAX6902=3Dm
CONFIG_RTC_DRV_R9701=3Dm
CONFIG_RTC_DRV_RS5C348=3Dm

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
CONFIG_RTC_DRV_DS1511=3Dm
CONFIG_RTC_DRV_DS1553=3Dm
CONFIG_RTC_DRV_DS1742=3Dm
CONFIG_RTC_DRV_STK17TA8=3Dm
CONFIG_RTC_DRV_M48T86=3Dm
CONFIG_RTC_DRV_M48T59=3Dm
CONFIG_RTC_DRV_V3020=3Dm

#
# on-CPU RTC drivers
#
CONFIG_DMADEVICES=3Dy

#
# DMA Devices
#
CONFIG_INTEL_IOATDMA=3Dm
CONFIG_DMA_ENGINE=3Dy

#
# DMA Clients
#
CONFIG_NET_DMA=3Dy
CONFIG_DCA=3Dm
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=3Dm
CONFIG_UIO_CIF=3Dm
CONFIG_UIO_SMX=3Dm

#
# Firmware Drivers
#
CONFIG_EDD=3Dm
# CONFIG_EDD_OFF is not set
CONFIG_EFI_VARS=3Dm
CONFIG_DELL_RBU=3Dm
CONFIG_DCDBAS=3Dm
CONFIG_DMIID=3Dy
CONFIG_ISCSI_IBFT_FIND=3Dy
CONFIG_ISCSI_IBFT=3Dy

#
# File systems
#
CONFIG_EXT2_FS=3Dm
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_EXT4DEV_FS=3Dm
CONFIG_EXT4DEV_FS_XATTR=3Dy
CONFIG_EXT4DEV_FS_POSIX_ACL=3Dy
CONFIG_EXT4DEV_FS_SECURITY=3Dy
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_JFS_SECURITY=3Dy
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_XFS_RT=3Dy
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=3Dm
CONFIG_GFS2_FS_LOCKING_NOLOCK=3Dm
CONFIG_GFS2_FS_LOCKING_DLM=3Dm
CONFIG_OCFS2_FS=3Dm
CONFIG_OCFS2_FS_O2CB=3Dm
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
CONFIG_PRINT_QUOTA_WARNING=3Dy
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
CONFIG_FUSE_FS=3Dm
CONFIG_GENERIC_ACL=3Dy

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"utf8"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dm

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=3Dm
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=3Dm
CONFIG_ECRYPT_FS=3Dm
CONFIG_HFS_FS=3Dm
CONFIG_HFSPLUS_FS=3Dm
CONFIG_BEFS_FS=3Dm
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=3Dm
CONFIG_EFS_FS=3Dm
CONFIG_JFFS2_FS=3Dm
CONFIG_JFFS2_FS_DEBUG=3D0
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=3Dy
CONFIG_JFFS2_FS_XATTR=3Dy
CONFIG_JFFS2_FS_POSIX_ACL=3Dy
CONFIG_JFFS2_FS_SECURITY=3Dy
CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
CONFIG_JFFS2_ZLIB=3Dy
CONFIG_JFFS2_LZO=3Dy
CONFIG_JFFS2_RTIME=3Dy
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=3Dy
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_CRAMFS=3Dm
CONFIG_VXFS_FS=3Dm
CONFIG_MINIX_FS=3Dm
CONFIG_HPFS_FS=3Dm
CONFIG_QNX4FS_FS=3Dm
CONFIG_ROMFS_FS=3Dm
CONFIG_SYSV_FS=3Dm
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_SUNRPC_XPRT_RDMA=3Dm
CONFIG_SUNRPC_BIND34=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dm
CONFIG_RPCSEC_GSS_SPKM3=3Dm
# CONFIG_SMB_FS is not set
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=3Dy
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
# CONFIG_CIFS_DEBUG2 is not set
CONFIG_CIFS_EXPERIMENTAL=3Dy
CONFIG_CIFS_UPCALL=3Dy
CONFIG_CIFS_DFS_UPCALL=3Dy
CONFIG_NCP_FS=3Dm
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_CODA_FS=3Dm
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=3Dm
# CONFIG_AFS_DEBUG is not set
CONFIG_9P_FS=3Dm

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_ACORN_PARTITION=3Dy
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=3Dy
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=3Dy
CONFIG_OSF_PARTITION=3Dy
CONFIG_AMIGA_PARTITION=3Dy
CONFIG_ATARI_PARTITION=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=3Dy
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=3Dm
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm
CONFIG_DLM=3Dm
CONFIG_DLM_DEBUG=3Dy

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_PRINTK_TIME=3Dy
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN=3D2048
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_UNUSED_SYMBOLS=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=3Dy
CONFIG_SCHED_DEBUG=3Dy
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=3Dy
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_NONPROMISC_DEVMEM is not set
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_DIRECT_GBPAGES is not set
# CONFIG_DEBUG_NX_TEST is not set
CONFIG_X86_MPPARSE=3Dy
# CONFIG_IOMMU_DEBUG is not set
CONFIG_IO_DELAY_TYPE_0X80=3D0
CONFIG_IO_DELAY_TYPE_0XED=3D1
CONFIG_IO_DELAY_TYPE_UDELAY=3D2
CONFIG_IO_DELAY_TYPE_NONE=3D3
CONFIG_IO_DELAY_0X80=3Dy
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy
CONFIG_SECURITY_FILE_CAPABILITIES=3Dy
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=3D0
CONFIG_SECURITY_SELINUX=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=3D0
CONFIG_SECURITY_SELINUX_DISABLE=3Dy
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
# CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT is not set
# CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_GF128MUL=3Dm
CONFIG_CRYPTO_NULL=3Dm
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
CONFIG_CRYPTO_GCM=3Dm
CONFIG_CRYPTO_SEQIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dm
CONFIG_CRYPTO_CTR=3Dm
CONFIG_CRYPTO_CTS=3Dm
CONFIG_CRYPTO_ECB=3Dm
CONFIG_CRYPTO_LRW=3Dm
CONFIG_CRYPTO_PCBC=3Dm
CONFIG_CRYPTO_XTS=3Dm

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_XCBC=3Dm

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_WP512=3Dm

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_AES_X86_64=3Dm
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_CAMELLIA=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_FCRYPT=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_SALSA20=3Dm
CONFIG_CRYPTO_SALSA20_X86_64=3Dm
CONFIG_CRYPTO_SEED=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64=3Dm

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_LZO=3Dm
CONFIG_CRYPTO_HW=3Dy
CONFIG_CRYPTO_DEV_HIFN_795X=3Dm
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=3Dy
CONFIG_HAVE_KVM=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dm
CONFIG_KVM_INTEL=3Dm
CONFIG_KVM_AMD=3Dm
CONFIG_VIRTIO=3Dm
CONFIG_VIRTIO_RING=3Dm
CONFIG_VIRTIO_PCI=3Dm
CONFIG_VIRTIO_BALLOON=3Dm

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC16=3Dm
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dm
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_LZO_COMPRESS=3Dm
CONFIG_LZO_DECOMPRESS=3Dm
CONFIG_GENERIC_ALLOCATOR=3Dy
CONFIG_REED_SOLOMON=3Dm
CONFIG_REED_SOLOMON_DEC16=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_PLIST=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_CHECK_SIGNATURE=3Dy
