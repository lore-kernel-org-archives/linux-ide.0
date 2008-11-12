From: Michael Guntsche <mike@it-loops.com>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Wed, 12 Nov 2008 10:43:32 +0100
Message-ID: <fdc08450bd57b75c90440beab3d7534a@localhost>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org> <90e002e7b2d47cad80ff952a2a81f0e7@localhost> <491A90BE.9030005@kernel.org> <1741f98465176fff86a1dda48fc965ac@localhost> <491AA18A.9090001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:41022
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbYKLJng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 04:43:36 -0500
In-Reply-To: <491AA18A.9090001@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

On Wed, 12 Nov 2008 18:27:38 +0900, Tejun Heo <tj@kernel.org> wrote:
> Hello,
> Yeap, it's working correctly now.

Good to know

> Does libata.ignore_hpa=1 help?

No it does not.

/proc/cmdline:
==============

auto BOOT_IMAGE=Linux ro root=802 libata.ignore_hpa=1

dmesg:
======

ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
ata1.00: 66055248 sectors, multi 16: LBA
ata1.00: configured for MWDMA2
ata2.01: NODEV after polling detection
ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      IC35L040AVER07-0 ER4O PQ: 0 ANSI:
5
sd 0:0:0:0: [sda] 66055248 512-byte hardware sectors (33820 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 66055248 512-byte hardware sectors (33820 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

ibmsetmax:
==========

Using device /dev/sda
native max address: 66055247
that is 33820286976 bytes, 33.8 GB
lba capacity: 66055248 sectors (33820286976 bytes)

Kind regards,
Michael
