From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 11:02:14 -0300
Message-ID: <4bbde1ea.c701be0a.60ec.0270@mx.google.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44919 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab0DHOCV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 10:02:21 -0400
Received: by pwj9 with SMTP id 9so1887888pwj.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 07:02:20 -0700 (PDT)
In-Reply-To: <20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, 8 Apr 2010 14:59:16 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> If you have the device name right (and if you are not using labels
> remember it might change depending upon whether the pata port has disks
> or not), your controller is in AHCI mode in the BIOS and your disk is on
> the SATA cables then yes.
> 
> And in those cases it should always use the AHCI driver for those devices
> even if the PIIX driver is also present

	Ok Alan, thanks for the answer. So I'll have to dig more here
to see where's the problem. The relevant part of the boot log is the
following:

ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: irq 29 for MSI/MSI-X
ahci: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ccc ems sxs 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6100 irq 29
ata2: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6180 irq 29
ata3: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6200 irq 29
ata4: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6280 irq 29
ata5: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6300 irq 29
ata6: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6380 irq 29
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
ata1.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST31500341AS     CC1H PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATAPI: HL-DT-ST BD-RE  GGW-H20L, YL05, max UDMA/133
ata4.00: configured for UDMA/133
scsi 3:0:0:0: CD-ROM            HL-DT-ST BD-RE  GGW-H20L  YL05 PQ: 0 ANSI: 5
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)

	***

	It seems it's using the AHCI driver, but if I remove the PIIX driver, it simply won't 
mount the root device. At least for the logs it is using the ahci driver, correct?

-- 
