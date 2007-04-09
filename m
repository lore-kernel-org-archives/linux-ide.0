From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 9 Apr 2007 12:18:09 +0200 (MEST)
Message-ID: <200704091018.l39AI9tg020015@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:55225 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117AbXDIKSR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Apr 2007 06:18:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, phil@ipom.com

On Sat, 07 Apr 2007 16:41:04 -0700, Phil Dibowitz wrote:
>I've recently moved to a Promise Sata controller with two SATA drives in a
>RAID1 mirror. But I get lots of ata exceptions and the kernel eventually
>slows down my drive to UDMA/33.
>
>It usually happens on ata1 (sda), but sometimes it'll kick in on ata2 (sdb).
>I can definitely cause this to happen more by increasing load on the disks.
>But even low load (checking email) causes this. Full hardware and software
>specs are below, but first, the errors:
>
>ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x180100 action 0x2
>ata1.00: cmd c8/00:d0:8a:31:ae/00:00:00:00:00/e0 tag 0 cdb 0x0 data 106496 in
>         res 51/0c:0f:4b:32:ae/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
>ata1: soft resetting port
>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>ata1.00: configured for UDMA/133
>ata1: EH complete
>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
>sda: Write Protect is off
>sda: Mode Sense: 00 3a 00 00
>SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
>DPO or FUA
...
>Kernel: 2.6.20.6 (PREEMT & SMP)
>SATA Controller:
>  02:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak
>  378/SATA 378) (rev 02)
>        Subsystem: ASUSTeK Computer Inc. K8V Deluxe/PC-DL Deluxe motherboard
>        Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 16
>        I/O ports at df00 [size=64]
>        I/O ports at dfa0 [size=16]
>        I/O ports at dc00 [size=128]
>        Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
>        Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
>        Capabilities: [60] Power Management version 2
>Drives:
>  2 x Western Digital WD1600JS-00N

I've seen reports of issues like these with second-generation
Promise SATA chips and SATAII (3Gbps) drives, but this is the
first time I've seen any issues with a first-generation chip.

1. Please try 2.6.21-rc6 plus the following two patches:
   http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21-rc6
   http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21-rc6

   This probably won't eliminate the errors, but should improve
   the level of detail in the error messages.

2. Try with a better power supply and verify that cooling is OK.
   Also verify that the SATA data and power cables are firmly attached.

   We've seen several reports of mysterious issues that eventually
   were traced to insufficient power supplies or poorly seated
   PCI cards (but in your case the chip is integrated on the mobo).

/Mikael
