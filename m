From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Wed, 10 Sep 2008 09:38:40 +0100
Message-ID: <20080910093840.0fc9df68@the-village.bc.nu>
References: <48C45BEF.5090502@gmail.com>
	<20080908094332.7b021b4e@lxorguk.ukuu.org.uk>
	<48C5BD49.6090204@gmail.com>
	<20080909115248.580eba78@lxorguk.ukuu.org.uk>
	<48C70313.6080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35362 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751584AbYIJJJd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 05:09:33 -0400
In-Reply-To: <48C70313.6080704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antonio Cardoso Martins <digiplan.pt@gmail.com>
Cc: linux-ide@vger.kernel.org

> Booting with CONFIG_BLK_DEV_CS5530=n and CONFIG_PATA_CS5530=y and
> libdata_dma_mask=0
> kernel 2.6.24.7:
> ...
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Driver 'sd' needs updating - please use bus_type methods
> scsi0: pata_cs5530
> scsi1: pata_cs5530
> ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
> ata1.00: ATA-5: SILICON POWER, 2.0, mas UDMA/66
> ata1.00: 2000880 sectors, multi 1: LBA
> ata1.00: configured for PIO4
> scsi 0:0:0:0: Direct-Access      ATA     SILICON POWER    2.0  PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1

And now it all works nicely

> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> So PIO4 is now working. Great. But i am stuck with the root device.

I would suggest posting to linux-kernel on that and talking to H Peter
Anvin about possible ways to get a real boot loader on the box.
