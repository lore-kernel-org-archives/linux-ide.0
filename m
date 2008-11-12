From: Michael Guntsche <mike@it-loops.com>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Wed, 12 Nov 2008 08:22:18 +0100
Message-ID: <90e002e7b2d47cad80ff952a2a81f0e7@localhost>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:32862
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751022AbYKLHWX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 02:22:23 -0500
In-Reply-To: <491A40AB.4070002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

On Wed, 12 Nov 2008 11:34:19 +0900, Tejun Heo <tj@kernel.org> wrote:

> Looks like we screwed up phantom device detection somewhere.  Michael,
> can you please apply the attached patch and report kernel boot log?

Here the relevant dmesg output

ata_piix 0000:00:07.1: version 2.12
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe800 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe808 irq 15
ata1: XXX devmask=3
ata1.00: XXX sff_dev_classify present=1 hdiag=0 tf=01:00:00 class=1
ata1.01: XXX sff_dev_classify present=2 hdiag=0 tf=01:00:00 class=1
ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
ata1.00: 66055248 sectors, multi 16: LBA
ata1.00: configured for MWDMA2
ata2: XXX devmask=1
ata2.00: XXX sff_dev_classify present=1 hdiag=0 tf=01:14:eb class=3
ata2.01: XXX sff_dev_classify present=0 hdiag=1 tf=ff:00:00 class=1
ata2.01: XXX status=0x1 hdiag=1
ata2.01: NODEV after polling detection
ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
ata2.00: configured for MWDMA2

Hope this helps,
Michael
