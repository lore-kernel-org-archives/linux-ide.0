From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration
 bugs
Date: Mon, 10 Nov 2008 19:21:34 +0900
Message-ID: <49180B2E.6020604@kernel.org>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34880 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbYKJKV5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 05:21:57 -0500
In-Reply-To: <07a2f909b249db90ad6bfdddfdd17765@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Guntsche <mike@it-loops.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>

(cc'ing Alan, Jeff and Mark).

Hello, guys.

Michael Guntsche wrote:
> On Mon, 10 Nov 2008 15:52:02 +0900, Tejun Heo <tj@kernel.org> wrote:
>> Hello,
> 
>> Looks like our phantom device detection logic is somehow broken.  Can
>> you please apply the attached patch and report boot log?
> 
> Here is the output after adding the debug line. Hopefully this helps.
> 
> ata_piix 0000:00:07.1: version 2.12
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe800 irq 14
> ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe808 irq 15
> ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
> ata1.00: 66055248 sectors, multi 16: LBA
> ata1.00: configured for MWDMA2
> ata2.01: XXX status=0x1
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.01: XXX status=0x1
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.01: XXX status=0x1
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
> ata2.00: configured for MWDMA2

On Michael's real old ata_piix, somehow the ERR bit is set on phantom
device defeating our phantom device detection logic.  We can relax
phantom device condition but that increases the risk of misdetection on
actual IDENTIFY errors.  Any ideas how we can nicely work around this one?

Thanks.

-- 
tejun
