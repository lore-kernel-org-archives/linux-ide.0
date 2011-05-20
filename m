From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: SATA PMP support
Date: Fri, 20 May 2011 10:48:35 +0200
Message-ID: <BANLkTikrHcnpKZccYMi0+24THZPYP6bRfg@mail.gmail.com>
References: <BANLkTi=4oJvigsq7GPMuB8meX0XnDh4VWw@mail.gmail.com> <20110519153826.GM627@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41075 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933796Ab1ETIs4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2011 04:48:56 -0400
Received: by ewy4 with SMTP id 4so1103663ewy.19
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2011 01:48:55 -0700 (PDT)
In-Reply-To: <20110519153826.GM627@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hello

On 19 May 2011 17:38, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Thu, May 19, 2011 at 05:12:02PM +0200, Michal Suchanek wrote:
>> I bought an eSATA enclosure (evolve doubledock) and I wonder if it c=
an
>> be used as a PMP.
>>
>> My eSATA port is connected to ICH10 AHCI controller which reportedly
>> supports CBS =C2=A0PMP.
>>
>> When I connect the dock kernel sees the port going up and I get acce=
ss
>> to one of the drives.
>>
>> I can access a drive in either slot but if both are populated only t=
he
>> primary slot (marked source) is visible.
>
> Can you please post full dmesg output?

This was the part after connecting the enclosure. Here is the part
from saved boot dmesg where the ahci controller is initialized. What
other part are you missing?

The box is running for some weeks so I don't have full dmesg, it gets
logrotated.

Thanks

Michal

[    2.389424] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    2.687223] libata version 3.00 loaded.
[    2.653246] SCSI subsystem initialized
[    3.080221] ahci 0000:00:1f.2: version 3.0
[    3.080234] ahci 0000:00:1f.2: PCI INT C -> GSI 18 (level, low) -> I=
RQ 18
[    3.080265] ahci 0000:00:1f.2: irq 50 for MSI/MSI-X
[    3.080338] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3
Gbps 0x2f impl SATA mode
[    3.080341] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio ems=
 sxs
[    3.080345] ahci 0000:00:1f.2: setting latency timer to 64
[    3.112612] scsi0 : ahci
[    3.112685] scsi1 : ahci
[    3.112755] scsi2 : ahci
[    3.112830] scsi3 : ahci
[    3.112908] scsi4 : ahci
[    3.112997] scsi5 : ahci
[    3.114484] ata1: SATA max UDMA/133 abar m2048@0xf0400000 port
0xf0400100 irq 50
[    3.114486] ata2: SATA max UDMA/133 abar m2048@0xf0400000 port
0xf0400180 irq 50
[    3.114488] ata3: SATA max UDMA/133 abar m2048@0xf0400000 port
0xf0400200 irq 50
[    3.114490] ata4: SATA max UDMA/133 abar m2048@0xf0400000 port
0xf0400280 irq 50
[    3.114492] ata5: DUMMY
[    3.114493] ata6: SATA max UDMA/133 abar m2048@0xf0400000 port
0xf0400380 irq 50
[    3.114540] ata_generic 0000:00:03.2: PCI INT C -> GSI 18 (level,
low) -> IRQ 18
[    3.114579] ata_generic 0000:00:03.2: setting latency timer to 64
[    3.114976] scsi6 : ata_generic
[    3.115054] scsi7 : ata_generic
[    3.115112] ata7: PATA max UDMA/100 cmd 0xfe80 ctl 0xfe90 bmdma 0xfe=
f0 irq 18
[    3.115114] ata8: PATA max UDMA/100 cmd 0xfea0 ctl 0xfeb0 bmdma 0xfe=
f8 irq 18
[    3.432017] ata3: SATA link down (SStatus 4 SControl 300)
[    3.432037] ata6: SATA link down (SStatus 0 SControl 300)
[    3.432057] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.432076] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.432093] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.432226] ata1.00: ATA-8: OCZ-VERTEX, 1.41, max UDMA/133
[    3.432229] ata1.00: 62533296 sectors, multi 1: LBA48 NCQ (depth 31/=
32), AA
[    3.433135] ata2.00: ATAPI: Optiarc DVD+/-RW AD-7200S, 102A, max UDM=
A/100
[    3.434706] ata2.00: configured for UDMA/100
[    3.435188] ata1.00: configured for UDMA/133
[    3.435313] scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX
  1.41 PQ: 0 ANSI: 5
[    3.438451] ata4.00: ATA-7: SAMSUNG HD252HJ, 1AC01118, max UDMA7
[    3.438454] ata4.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31=
/32), AA
[    3.439613] scsi 1:0:0:0: CD-ROM            Optiarc  DVD+-RW
AD-7200S 102A PQ: 0 ANSI: 5
[    3.444879] ata4.00: configured for UDMA/133
[    3.444962] scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG
HD252HJ  1AC0 PQ: 0 ANSI: 5
[    3.624050] sd 0:0:0:0: [sda] 62533296 512-byte logical blocks:
(32.0 GB/29.8 GiB)
[    3.624102] sd 3:0:0:0: [sdb] 488397168 512-byte logical blocks:
(250 GB/232 GiB)
[    3.624113] sd 0:0:0:0: [sda] Write Protect is off
[    3.624116] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.624142] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    3.624147] sd 3:0:0:0: [sdb] Write Protect is off
[    3.624149] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.624166] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    3.624897]  sda: sda1 sda2 sda3
[    3.625184] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.627242] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw
xa/form2 cdda tray
[    3.627245] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.627385] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    3.650992]  sdb: sdb1 sdb2 sdb3 sdb4
[    3.651260] sd 3:0:0:0: [sdb] Attached SCSI disk
