From: Daniel Pocock <daniel@pocock.com.au>
Subject: Re: very slow write to AHCI device
Date: Tue, 08 May 2012 01:30:45 +0200
Message-ID: <4FA85B25.8070500@pocock.com.au>
References: <4FA7F563.4040708@pocock.com.au> <4FA81009.1030308@fold.natur.cuni.cz> <4FA81067.80607@pocock.com.au> <4FA81406.5010806@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.trendhosting.net ([195.8.117.5]:35445 "EHLO
	mail1.trendhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab2EGXau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2012 19:30:50 -0400
In-Reply-To: <4FA81406.5010806@fold.natur.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-ide@vger.kernel.org


>> Disk /dev/sdb: 1000.2 GB, 1000204886016 bytes
>> 255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors
>> Units = sectors of 1 * 512 = 512 bytes
>> Sector size (logical/physical): 512 bytes / 512 bytes
>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>> Disk identifier: 0x484d5754
>>
>>    Device Boot      Start         End      Blocks   Id  System
>> /dev/sdb1   *        2048      499711      248832   83  Linux
>> Partition 1 does not end on cylinder boundary.
>> /dev/sdb2          499712  1953523711   976512000   fd  Linux raid
>> autodetect
>>     
> I caught myself:
>
> # lsscsi 
> [0:0:0:0]    disk    ATA      ST380815AS       3.AA  /dev/sda 
> [1:0:0:0]    disk    ATA      WDC WD2502ABYS-0 02.0  /dev/sdb 
> [2:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sdc 
> [3:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sdd 
> [4:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sde 
> [5:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sdf 
> # fdisk /dev/sdc 
>
> Command (m for help): p
>
> Disk /dev/sdc: 1000.2 GB, 1000204886016 bytes
> 255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors
> Units = sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk identifier: 0xe997c4dd
>
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sdc1              63  1953520064   976760001   fd  Linux raid autodetect
>
> Command (m for help): q
>
> # smartctl -a /dev/sdc 
> smartctl 5.42 2011-10-20 r3458 [x86_64-linux-3.3.2-default] (local build)
> Copyright (C) 2002-11 by Bruce Allen, http://smartmontools.sourceforge.net
>
> === START OF INFORMATION SECTION ===
> Model Family:     Western Digital RE2-GP
> Device Model:     WDC WD1000FYPS-01ZKB0
> Serial Number:    WD-WCASJ1253793
> LU WWN Device Id: 5 0014ee 256812a2d
> Firmware Version: 02.01B01
> User Capacity:    1,000,204,886,016 bytes [1.00 TB]
> Sector Size:      512 bytes logical/physical
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   8
> ATA Standard is:  Exact ATA specification draft version not indicated
> Local Time is:    Mon May  7 20:21:35 2012 MEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>
> [cut]
>
> Do you have same model?
>
>   

Not quite:

# smartctl -a /dev/sda
smartctl 5.40 2010-07-12 r3124 [x86_64-unknown-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.12 family
Device Model:     ST31000528AS
Serial Number:    6VP0KWSF
Firmware Version: CC49
User Capacity:    1,000,204,886,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Tue May  8 01:26:06 2012 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled


> My disk catch up at 3Gbps:
>
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: ATA-8: WDC WD1000FYPS-01ZKB0, 02.01B01, max UDMA/133
> ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
> ata3.00: configured for UDMA/133
> scsi 2:0:0:0: Direct-Access     ATA      WDC WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
> sd 2:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> sd 2:0:0:0: Attached scsi generic sg2 type 0
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sdc: sdc1
> sd 2:0:0:0: [sdc] Attached SCSI disk
>
>   


One of mine died as soon as I upgraded to the CC49 firmware today:

[ 2905.173593] sd 0:0:0:0: [sda] Unhandled error code
[ 2905.173599] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
[ 2905.173608] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 18 f7 aa c8 00 00
10 00
[ 2905.173628] end_request: I/O error, dev sda, sector 418884296
[ 2905.180214] sd 0:0:0:0: [sda] Unhandled error code
[ 2905.180220] sd 0:0:0:0: [sda]  Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
[ 2905.180234] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 18 f7 aa b8 00 00
08 00
[ 2905.180286] end_request: I/O error, dev sda, sector 418884280
[ 2905.180496] md/raid1:md2: Disk failure on sda2, disabling device.
[ 2905.180501] md/raid1:md2: Operation continuing on 1 devices.
[ 2905.199738] sd 0:0:0:0: [sda] Unhandled error code


Lucky I'm using md

I thought maybe the firmware had just exposed a pre-existing problem and
that maybe the bad drive had already been making my AHCI controller slow
down - but removing the drive completely hasn't made operations any
faster on the remaining drive.

I'm now looking to replace them with something like the Seagate
Constellation or another slightly more robust enterprise drive, maybe
even SAS



