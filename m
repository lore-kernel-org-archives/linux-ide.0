From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 18 May 2004 16:40:24 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084920024.3191.8.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482 8
		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3211
	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:16570 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263725AbUERWkj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2004 18:40:39 -0400
In-Reply-To: <40A93E85.4010904@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> Feel free to play around.  :)
> 
> Silicon Image is sending me a couple bridges, we'll see how they
> behave.

Heads up, I have a second sample of hardware now:

kernel: ata_exec_command_pio: ata2: cmd 0xA1
kernel: ata2: dev 0 cfg 49:0e00 82:4218 83:4000 84:4000 85:4218 86:0000 87:4000 88:0000

Its ata_piix.ko op x12 "INQUIRY" doesn't yet work at all, perhaps by way
of more accurately simulating what we may see in mass distribution.

You'll remember, the first hardware sample I acquired was a
massively-distributed PATA ATAPI DMA drive combined with an Si 3611CT80
r1.4 SATA/ PATA bridge.

My second sample is that same bridge, but now with a different drive
behind it, specifically a drive whose firmware purportedly implements
the "d1532v1r4b ATA-ATAPI-7.pdf" proposal to substitute:

PATA ATAPI:

id[49] = id[ 7 * 8 - 8 + 1] = x0F00 // DMA
id[62] = id[ 8 * 8 - 8 + 6] = x0000 // SWDMA not
id[63] = id[ 8 * 8 - 8 + 7] = x0007 // MWDMA 2 1 0
id[88] = id[12 * 8 - 8 + 0] = xXX3F // UDMA 5 4 2 1 0

SATA ATAPI per 2004-04-21 d1532v1r4b:

id[49] = id[ 7 * 8 - 8 + 1] = x0E00
id[62] = id[ 8 * 8 - 8 + 6] = x87FF // ATA-7: DMADIR, ATA-2: SWDMA 2 1 0
id[63] = id[ 8 * 8 - 8 + 7] = x0000
id[88] = id[12 * 8 - 8 + 0] = xXX00

I'll go digging now.

I imagine I'll find I can most concisely make this work by copying into
words 49 63 88 the bits of word 62.

Pat LaVarre


