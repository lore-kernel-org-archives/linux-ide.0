From: Michael Guntsche <mike@it-loops.com>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Mon, 10 Nov 2008 11:10:44 +0100
Message-ID: <07a2f909b249db90ad6bfdddfdd17765@localhost>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:33757
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754263AbYKJKKs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2008 05:10:48 -0500
In-Reply-To: <4917DA12.8070307@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Mon, 10 Nov 2008 15:52:02 +0900, Tejun Heo <tj@kernel.org> wrote:
> Hello,

> Looks like our phantom device detection logic is somehow broken.  Can
> you please apply the attached patch and report boot log?

Here is the output after adding the debug line. Hopefully this helps.

ata_piix 0000:00:07.1: version 2.12
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe800 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe808 irq 15
ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
ata1.00: 66055248 sectors, multi 16: LBA
ata1.00: configured for MWDMA2
ata2.01: XXX status=0x1
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2.01: XXX status=0x1
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2.01: XXX status=0x1
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
ata2.00: configured for MWDMA2

Kind regards,
Michael
