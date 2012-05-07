From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: very slow write to AHCI device
Date: Mon, 07 May 2012 20:27:18 +0200
Message-ID: <4FA81406.5010806@fold.natur.cuni.cz>
References: <4FA7F563.4040708@pocock.com.au> <4FA81009.1030308@fold.natur.cuni.cz> <4FA81067.80607@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:53670 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755386Ab2EGSYS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2012 14:24:18 -0400
In-Reply-To: <4FA81067.80607@pocock.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Pocock <daniel@pocock.com.au>
Cc: linux-ide@vger.kernel.org



Daniel Pocock wrote:
> On 07/05/12 20:10, Martin Mokrejs wrote:
>> Hi Daniel,
>>
>> Daniel Pocock wrote:
>>   
>>>
>>> Hi,
>>>
>>> I'm testing a problem with the following combination:
>>> - SB700/SB800 type controller in AHCI mode (in a HP Microserver N36L)
>>> - Seagate Barracuda 1TB 7k2 drive with NCQ
>>>     
>> Is that a disk with 4k hardware sectors (Advanced Format)? Where does
>> you partition start? At sector 63 or 2048? ;-)
>>
>>   
> At 2048:

So you you safe if it would be 4k sector drive.

> 
> Disk /dev/sdb: 1000.2 GB, 1000204886016 bytes
> 255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors
> Units = sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk identifier: 0x484d5754
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sdb1   *        2048      499711      248832   83  Linux
> Partition 1 does not end on cylinder boundary.
> /dev/sdb2          499712  1953523711   976512000   fd  Linux raid
> autodetect

I caught myself:

# lsscsi 
[0:0:0:0]    disk    ATA      ST380815AS       3.AA  /dev/sda 
[1:0:0:0]    disk    ATA      WDC WD2502ABYS-0 02.0  /dev/sdb 
[2:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sdc 
[3:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sdd 
[4:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sde 
[5:0:0:0]    disk    ATA      WDC WD1000FYPS-0 02.0  /dev/sdf 
# fdisk /dev/sdc 

Command (m for help): p

Disk /dev/sdc: 1000.2 GB, 1000204886016 bytes
255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xe997c4dd

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1              63  1953520064   976760001   fd  Linux raid autodetect

Command (m for help): q

# smartctl -a /dev/sdc 
smartctl 5.42 2011-10-20 r3458 [x86_64-linux-3.3.2-default] (local build)
Copyright (C) 2002-11 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital RE2-GP
Device Model:     WDC WD1000FYPS-01ZKB0
Serial Number:    WD-WCASJ1253793
LU WWN Device Id: 5 0014ee 256812a2d
Firmware Version: 02.01B01
User Capacity:    1,000,204,886,016 bytes [1.00 TB]
Sector Size:      512 bytes logical/physical
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon May  7 20:21:35 2012 MEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

[cut]

Do you have same model?


My disk catch up at 3Gbps:

ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: WDC WD1000FYPS-01ZKB0, 02.01B01, max UDMA/133
ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk


Martin
