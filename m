From: Guntsche Michael <mike@it-loops.com>
Subject: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Mon, 27 Oct 2008 16:45:18 +0100
Message-ID: <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:59304
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742AbYJ0PwE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 11:52:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello list,

Forgot to CC: linux-ide when writing this.

Please put me on CC when replying since I am not subscribed to the list.

Kind regards,
Michael

Begin forwarded message:

> From: Michael Guntsche <mike@it-loops.com>
> Date: October 27, 2008 11:21:58 GMT+01:00
> To: tj@kernel.org
> Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device  
> iteration bugs
>
> Hello,
>
> I just browsed through the linux-ide archives and found this patch.  
> I am
> wondering if this also helps with a problem I am facing on one of my  
> router
> boxes since a few kernel versions.
>
> I have an ancient router box with a  "Intel Corporation 82371SB  
> PIIX3 IDE
> [Natoma/Triton II]" controller. I switched to the new libata code a  
> long
> time ago using the ata_piix driver. I have one harddisk and a CD- 
> burner i
> not use very often. The Harddisk is on Primary master the burner on
> secondary master. with at least the last two kernel versions, I see  
> this
> during bootup
>
> ata_piix 0000:00:07.1: version 2.12
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe800 irq 14
> ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe808 irq 15
> ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
> ata1.00: 66055248 sectors, multi 16: LBA
> ata1.00: configured for MWDMA2
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
>
> As you can see for some reason ata2.01 (secondary slave??) gets probed
> during startup although there is nothing attached to it. It is tried  
> three
> times with a 5 seconds pause in between. I did not notice this in  
> the past
> since a do not reboot that machine very often.
> For testing purposes I just recently did this a few times in a row and
> noticed this. It is not a biggie since harddisk and burner are  
> working but
> nevertheless it wasn't happening with older kernel versions so I  
> though you
> should know.
>
> Kind regards,
> Michael

