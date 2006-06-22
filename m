From: Aalderd Bouwman <boac@wanadoo.nl>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Thu, 22 Jun 2006 09:16:17 +0200
Message-ID: <200606220916.18020.boac@wanadoo.nl>
References: <200606210942.33578.boac@wanadoo.nl> <44995139.30808@gmail.com>
Reply-To: boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:26912 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S1751763AbWFVHQS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jun 2006 03:16:18 -0400
In-Reply-To: <44995139.30808@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello Tejun,

Is the NCQ-patch already in libata-dev git and how could I update my 
libata-dev tree?

About hotplug in libata-dev:
Now when I load the driver and the drive is turned on and I turned of the 
drive:

ahci 0000:00:0f.0: version 1.3
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part
ata9: SATA max UDMA/133 cmd 0xE0486D00 ctl 0x0 bmdma 0x0 irq 10
ata10: SATA max UDMA/133 cmd 0xE0486D80 ctl 0x0 bmdma 0x0 irq 10
ata11: SATA max UDMA/133 cmd 0xE0486E00 ctl 0x0 bmdma 0x0 irq 10
ata12: SATA max UDMA/133 cmd 0xE0486E80 ctl 0x0 bmdma 0x0 irq 10
scsi8 : ahci
ata9: SATA link down (SStatus 0 SControl 300)
scsi9 : ahci
ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.00: cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:007f
ata10.00: ATA-7, max UDMA/133, 160086528 sectors: LBA
ata10.00: configured for UDMA/133
scsi10 : ahci
ata11: SATA link down (SStatus 0 SControl 300)
scsi11 : ahci
ata12: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 9:0:0:0: Attached scsi disk sda
sd 9:0:0:0: Attached scsi generic sg0 type 0
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
ata10: exception Emask 0x10 SAct 0x0 SErr 0x30000 action 0x2 frozen
ata10: (irq_stat 0x04400000, PHY RDY changed)
ata10: soft resetting port
ata10: SATA link down (SStatus 1 SControl 300)
ata10: failed to recover some devices, retrying in 5 secs
ata10: hard resetting port
ata10: SATA link down (SStatus 0 SControl 300)
ata10: failed to recover some devices, retrying in 5 secs
ata10: hard resetting port
ata10: SATA link down (SStatus 0 SControl 300)
ata10.00: disabled
ata10: EH complete
ata10.00: detaching (SCSI 9:0:0:0)

Now I turn on the drive and turned him off when I see 'soft resetting port':
ata10: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata10: (irq_stat 0x00000040, connection status changed)
ata10: waiting for device to spin up (8 secs)
ata10: soft resetting port
ata10: port is slow to respond, please be patient
ata10: port failed to respond (30 secs)
ata10: softreset failed (device not ready)
ata10: softreset failed, retrying in 5 secs
ata10: hard resetting port
ata10: SATA link down (SStatus 0 SControl 300)
ata10: EH complete

And when I turned on the drive and waiting:
ata10: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata10: (irq_stat 0x00000040, connection status changed)
ata10: waiting for device to spin up (8 secs)
ata10: soft resetting port
ata10: port is slow to respond, please be patient
ata10: port failed to respond (30 secs)
ata10: softreset failed (device not ready)
ata10: softreset failed, retrying in 5 secs
ata10: hard resetting port
ata10: port is slow to respond, please be patient
ata10: port failed to respond (30 secs)
ata10: COMRESET failed (device not ready)
ata10: hardreset failed, retrying in 5 secs
ata10: hard resetting port
ata10: port is slow to respond, please be patient
ata10: port failed to respond (30 secs)
ata10: COMRESET failed (device not ready)
ata10: reset failed, giving up
ata10: EH complete

Now the port is disabled by the driver :'( so I am unable to use this port for 
an another drive and I think that is not what you want. When this module 
is 'build in' you should reboot your machine.

Aalderd Bouwman.

On Wednesday 21 June 2006 16:01, Tejun Heo wrote:
> Aalderd Bouwman wrote:
> > Hello,
> >
> > When I load module ahci when a drive is 'online' the drive is can be used
> > normal. When I disconnect the drive EH doesn't recognize that action.
> > When I reconnect the driver posts the following kernel-message:
>
> I'm getting to dislike this via controller.  Again, the controller seems
> to lock up completely on hotplug events.  It might be that the current
> ahci's EH behavior just doesn't fit the via controller as the controller
> seems to lock up similarly in both NCQ and this case.  Maybe it doesn't
> like engine restart sequence (which, BTW, are all done in accordance to
> the AHCI spec).
>
> > Here I disconnect both drives connected to the controller.
> > After the second/third port-reset I also do rmmod ahci:
>
> [--snip--]
>
> > Jun 21 09:15:18 server BUG: unable to handle kernel NULL pointer
> > dereference at virtual address 00000010
> > Jun 21 09:15:18 server printing eip:
> > Jun 21 09:15:18 server e04926cc
> > Jun 21 09:15:18 server *pde = 00000000
> > Jun 21 09:15:18 server Oops: 0000 [#1]
> > Jun 21 09:15:18 server last sysfs file: /block/sdb/sdb2/dev
> > Jun 21 09:15:18 server Modules linked in: ahci libata cls_u32 sch_htb
> > xt_tcpudp iptable_filter iptable_nat ip_tables x_tables ip_nat_irc
> > ip_conntrack_irc ip_nat_ftp ip_nat ip_conntrack_ftp w83627ehf i2c_isa
> > i2c_core 3c59x
> > Jun 21 09:15:18 server CPU:    0
> > Jun 21 09:15:18 server EIP:    0060:[<e04926cc>]    Not tainted VLI
> > Jun 21 09:15:18 server EFLAGS: 00010246   (2.6.17-rc5-mm2 #2)
> > Jun 21 09:15:18 server EIP is at ahci_tf_read+0xa/0x19 [ahci]
> > Jun 21 09:15:18 server eax: 00000000   ebx: e049382f   ecx: de36c29c  
> > edx: 00000000
> > Jun 21 09:15:18 server esi: de36c29c   edi: 00000000   ebp: e0488d00  
> > esp: de43ce84
> > Jun 21 09:15:18 server ds: 007b   es: 007b   ss: 0068
> > Jun 21 09:15:18 server Process scsi_eh_8 (pid: 15546, threadinfo=de43c000
> > task=c66ed550)
> > Jun 21 09:15:18 server Stack: e0492455 de36c29c de43ce94 00000000
> > 0000000a de36c380 00000246 00000046
> > Jun 21 09:15:18 server fffffecc 0000001a de43cecc c0110a49 de43cefc
> > de36c380 de36c29c de36c29c
> > Jun 21 09:15:18 server e04aa50e de36c29c de43cefc e04923f1 e04b0de3
> > de36c29c e04923f1 de43cefc
> > Jun 21 09:15:18 server Call Trace:
> > Jun 21 09:15:18 server <e0492455> ahci_softreset+0x64/0x1d1 [ahci] 
> > <c0110a49> __wake_up+0x14/0x1e
> > Jun 21 09:15:18 server <e04aa50e> ata_do_reset+0x1b/0x4d [libata] 
> > <e04923f1> ahci_softreset+0x0/0x1d1 [ahci]
> > Jun 21 09:15:18 server <e04b0de3> ata_eh_reset+0x78/0xff [libata] 
> > <e04923f1>
>
> But, this is a driver bug.  I tried pretty hard to prevent this from
> happening.  Apparently, I screwed up.  If it's not too much trouble, can
> you please try libata-dev #upstream and see how it works with similar
> unloading scenario.  I'll try to reproduce it here but I wanna know for
> sure that the latest devel tree has the same issue.
>
> Even if you're not familiar w/ git, accessing libata-dev #upstream is
> actually quite simple.
>
> 1. install git (on debian, just install git-core package)
> 2. $ git-clone git://git.kernel.org/pub/scm/linux/kernel/\
>     git/jgarzik/libata-dev.git libata-dev
> 3. $ cd libata-dev
> 4. $ git-checkout -f upstream
> 5. copy over your .config and build.
