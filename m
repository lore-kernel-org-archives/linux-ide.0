From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 not configuring drive right?
Date: Tue, 03 Jul 2007 15:38:12 +0900
Message-ID: <4689EED4.6070507@gmail.com>
References: <200706190628.38377.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:16509 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbXGCGiS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 02:38:18 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1126432nze
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 23:38:17 -0700 (PDT)
In-Reply-To: <200706190628.38377.tbaumgartner@swissonline.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theo Baumgartner <tbaumgartner@swissonline.ch>
Cc: linux-ide@vger.kernel.org

Theo Baumgartner wrote:
> Hello
> 
> I've got a sil3124 card which doesn't seem to use the full speed of my drives.
> 
> -------------------------------------------------------------------------------------------------------------------
> ata1: SATA max UDMA/100 cmd 0xe0850000 ctl 0x00000000 bmdma 0x00000000 irq 17
> ata2: SATA max UDMA/100 cmd 0xe0852000 ctl 0x00000000 bmdma 0x00000000 irq 17
> ata3: SATA max UDMA/100 cmd 0xe0854000 ctl 0x00000000 bmdma 0x00000000 irq 17
> ata4: SATA max UDMA/100 cmd 0xe0856000 ctl 0x00000000 bmdma 0x00000000 irq 17
> scsi0 : sata_sil24
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
> ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
> ata1.00: configured for UDMA/100
> scsi1 : sata_sil24
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
> ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
> ata2.00: configured for UDMA/100
> scsi2 : sata_sil24
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
> ata3.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
> ata3.00: configured for UDMA/100
> scsi3 : sata_sil24
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
> ata4.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
> ata4.00: configured for UDMA/100
> -------------------------------------------------------------------------------------------------------------------
> 
> Why does it tell "max UDMA/133" but then just uses UDMA/100?

That's the controller mask being applied.  UDMA mode doesn't matter for
native SATA devices at all, so just ignore it.

> and what about the NCQ depth 1?

That's the harddrive reporting NCQ max depth of 1.  Interesting.  Care
to post the result of "hdparm -I /dev/sda"?

-- 
tejun
