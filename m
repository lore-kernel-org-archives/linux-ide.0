From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Promise SATA 300 TX2plus: disk stops responding
Date: Wed, 2 Jul 2008 13:36:25 +0200 (MEST)
Message-ID: <200807021136.m62BaPvx026056@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:55968 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457AbYGBLgc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jul 2008 07:36:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aneurin.price@gmail.com, linux-ide@vger.kernel.org

On Sun, 29 Jun 2008 17:14:12 +0100, Aneurin Price wrote:
>I have a 500GB Seagate disk[0] attached to an el-cheapo PCI-plugin
>Promise SATA controller[1], which I've had for a couple of years. Every
>so often, the disk stops responding and is eventually disabled. I'm
>trying to determine whether this is a hardware fault or not - and if so,
>whether the disk or the controller is at fault; any insight would be
>appreciated.
...
>The controller card was previously in use in another system without
>issue, with a 300GB disk which is otherwise similar (the current disk is
>essentially the upgraded model). That system was less frequently left
>running for the length of time that the problematic machine is though.

Same controller but different disks and machines. That's a sign
of a hardware issue with either the disk or the machine.

>At first I tried making sure that it was adequately cooled, the cables
>were all firmly in, etc. I also set the jumper on the disk to limit it
>to 1.5gbps, having read about a couple of potential problems with 3gbps
>access using some controllers supported by sata_promise [2]. I've even
>moved the disk and the controller card into a new machine, to eliminate
>any other possible causes, so the problem must be either with the disk,
>the controller, some interaction between them, or a software issue.

Inadequate power supplies are also common sources of problems.
And in another problem report the source turned out to be lack
of grounding between the disk and the chassis.

>[0] I believe it is a Barracuda ST3500630AS, but as it's currently
>inaccessible I can't be sure until I reboot.
>
>[1] lspci says:
>00:09.0 Mass storage controller: Promise Technology, Inc. PDC40775
>(SATA 300 TX2plus) (rev 02)
...
>[    0.000000] Linux version 2.6.24-18-server (buildd@terranova) (gcc
>version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Wed May 28 21:25:52 UTC
>2008 (Ubuntu 2.6.24-18.32-server)

2.6.24 plus unknown patches.

>[   20.525637] Enabling SiS 96x SMBus.

A SiS chipset box.

>[   24.479455] sata_promise 0000:00:09.0: version 2.11
>[   24.479495] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level,
>low) -> IRQ 19
>[   24.483100] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
>[   24.486651] scsi0 : sata_promise
>[   24.489369] scsi1 : sata_promise
>[   24.490837] scsi2 : sata_promise
>[   24.490979] ata1: SATA max UDMA/133 mmio m4096@0xdfffb000 port
>0xdfffb200 irq 19
>[   24.490986] ata2: SATA max UDMA/133 mmio m4096@0xdfffb000 port
>0xdfffb280 irq 19
>[   24.490989] ata3: PATA max UDMA/133 mmio m4096@0xdfffb000 port
>0xdfffb300 irq 19
>[   24.974147] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>[   24.994699] ata1.00: ATA-7: ST3500320AS, SD04, max UDMA/133
>[   24.994707] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
>[   25.034715] ata1.00: configured for UDMA/133
>[   25.363788] ata2: SATA link down (SStatus 0 SControl 300)
>[   25.524286] scsi 0:0:0:0: Direct-Access     ATA      ST3500320AS
>  SD04 PQ: 0 ANSI: 5
>[   25.525287] pata_sis 0000:00:02.5: version 0.5.2
>[   25.530885] scsi3 : pata_sis
>[   25.535308] scsi4 : pata_sis
>[   25.536000] ata4: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
>[   25.536009] ata5: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
>[   25.774285] ata4.00: ATA-6: ST360012A, 3.31, max UDMA/100
>[   25.774292] ata4.00: 117231408 sectors, multi 16: LBA
>[   25.813907] ata4.00: configured for UDMA/100
>[   25.814004] ata5: port disabled. ignoring.
>[   25.814283] scsi 3:0:0:0: Direct-Access     ATA      ST360012A
>  3.31 PQ: 0 ANSI: 5
>[   26.094795] Driver 'sd' needs updating - please use bus_type methods
>[   26.097381] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
>[   26.097482] sd 0:0:0:0: [sda] Write Protect is off
>[   26.097488] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>[   26.097566] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
>enabled, doesn't support DPO or FUA
>[   26.097766] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
>[   26.097808] sd 0:0:0:0: [sda] Write Protect is off
>[   26.097813] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>[   26.097876] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
>enabled, doesn't support DPO or FUA
>[   26.097888]  sda: sda1
>[   26.107984] sd 0:0:0:0: [sda] Attached SCSI disk
>[   26.108201] sd 3:0:0:0: [sdb] 117231408 512-byte hardware sectors (60022 MB)
>[   26.108255] sd 3:0:0:0: [sdb] Write Protect is off
>[   26.108260] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>[   26.108342] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
>enabled, doesn't support DPO or FUA
>[   26.108510] sd 3:0:0:0: [sdb] 117231408 512-byte hardware sectors (60022 MB)
>[   26.108559] sd 3:0:0:0: [sdb] Write Protect is off
>[   26.108564] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>[   26.108641] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
>enabled, doesn't support DPO or FUA
>[   26.108654]  sdb: sdb1 sdb2 < sdb5 >
>[   26.148272] sd 3:0:0:0: [sdb] Attached SCSI disk

Two disks, a big SATA one on the TX2plus and a small PATA one on the SiS controller.

>[1382260.429883] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
>0x2 frozen
>[1382260.429931] ata1.00: cmd 25/00:50:27:6e:cd/00:00:15:00:00/e0 tag
>0 dma 40960 in
>[1382260.429933]          res 40/00:00:00:00:00/00:00:00:00:00/00
>Emask 0x4 (timeout)
>[1382260.429956] ata1.00: status: { DRDY }
>[1382265.796276] ata1: port is slow to respond, please be patient (Status 0xff)
>[1382270.473163] ata1: device not ready (errno=-16), forcing hardreset
>[1382270.473179] ata1: hard resetting link
>[1382276.679024] ata1: port is slow to respond, please be patient (Status 0xff)
>[1382280.476592] ata1: COMRESET failed (errno=-16)
>[1382280.476626] ata1: hard resetting link
>[1382286.692400] ata1: port is slow to respond, please be patient (Status 0xff)
>[1382290.529795] ata1: COMRESET failed (errno=-16)
>[1382290.529829] ata1: hard resetting link
>[1382296.745702] ata1: port is slow to respond, please be patient (Status 0xff)
>[1382325.566448] ata1: COMRESET failed (errno=-16)
>[1382325.566484] ata1: limiting SATA link speed to 1.5 Gbps
>[1382325.566487] ata1: hard resetting link
>[1382330.573112] ata1: COMRESET failed (errno=-16)
>[1382330.573146] ata1: reset failed, giving up
>[1382330.573162] ata1.00: disabled
>[1382330.573188] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002
>action 0xa frozen t4
>[1382330.573212] ata1: hotplug_status 0x10
>[1382330.573226] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
...
>[1382571.052939] ata1: EH pending after 5 tries, giving up

These are signs of the disk going offline, or the communication between
the controller and the disk being corrupted. That's a hardware issue,
not unlike what we see with bad PSUs.

The 2.6.24 kernel lacks two post-2.6.24 sata_promise bug fixes.
The first fixes a problem where error recovery may trigger unexpected
hotplug events (we see those in your log), the second fixes a potential
problem in interrupt status clearing operations.

These fixes are in the 2.6.26-rc8 kernel. For 2.6.24 you can apply
the following two patches:
<http://user.it.uu.se/~mikpe/linux/patches/sata_promise/2.6.24/patch-sata_promise-1-fix-hardreset-hotplug-events-2.6.24>
<http://user.it.uu.se/~mikpe/linux/patches/sata_promise/2.6.24/patch-sata_promise-2-irqclear-2.6.24>

(And please make sure you're not running smartd while testing changes/patches/etc.)

/Mikael
