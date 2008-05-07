From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: sata silliness on the Vaio
Date: Tue, 6 May 2008 20:32:29 -0700
Message-ID: <20080506203229.dd99d2d7.akpm@linux-foundation.org>
References: <20080506202803.2e80957f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57801 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754405AbYEGDcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 23:32:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m473WTci031110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 6 May 2008 20:32:31 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m473WTAB009264
	for <linux-ide@vger.kernel.org>; Tue, 6 May 2008 20:32:29 -0700
In-Reply-To: <20080506202803.2e80957f.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, 6 May 2008 20:28:03 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1810 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
> ata1.00: ATAPI: MATSHITAUJ-832D, 1.02, max UDMA/33
> ata1.00: configured for UDMA/33
> ata2: port disabled. ignoring.
> scsi 0:0:0:0: CD-ROM            MATSHITA UJ-832D          1.02 PQ: 0 ANSI: 5
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 18
> ata_piix 0000:00:1f.2: MAP [ P0 P2 -- -- ]
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> scsi2 : ata_piix
> scsi3 : ata_piix
> ata3: SATA max UDMA/133 cmd 0x18c8 ctl 0x18c0 bmdma 0x18b0 irq 18
> ata4: SATA max UDMA/133 cmd 0x18a8 ctl 0x180c bmdma 0x18b8 irq 18
> ata3.00: ATA-7: HTS541010G9SA00, MBZOC60D, max UDMA/100
> ata3.00: 195371568 sectors, multi 16: LBA48 NCQ (not used)
> ata3.00: configured for UDMA/100
> ata4: link is slow to respond, please be patient (ready=0)
> ata4: device not ready (errno=-16), forcing hardreset
> ata4: link is slow to respond, please be patient (ready=0)
> ata4: SRST failed (errno=-16)
> ata4: link is slow to respond, please be patient (ready=0)
> ata4: SRST failed (errno=-16)
> ata4: link is slow to respond, please be patient (ready=0)
> ata4: SRST failed (errno=-16)
> ata4: SRST failed (errno=-16)
> ata4: reset failed, giving up
> scsi 2:0:0:0: Direct-Access     ATA      HTS541010G9SA00  MBZO PQ: 0 ANSI: 5
> sd 2:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
> sd 2:0:0:0: [sda] Write Protect is off
> sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 2:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
> 
> My Vaio now spends maybe a minute during bootup futzing around with ata
> links which aren't there.
> 
> good dmesg: http://userweb.kernel.org/~akpm/dmesg-sony.txt
> bad dmesg: http://userweb.kernel.org/~akpm/dmesg-sony-silly.txt
> config: http://userweb.kernel.org/~akpm/config-sony.txt

Oh, they are there in the 2.6.25-mm1 log as well.   But they're now
being mishandled in some fashion.

Someone snuck something into mainline which was never in 2.6.25-mm1.
