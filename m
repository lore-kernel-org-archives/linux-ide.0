From: Michael Guntsche <mike@it-loops.com>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Wed, 12 Nov 2008 10:16:00 +0100
Message-ID: <1741f98465176fff86a1dda48fc965ac@localhost>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org> <90e002e7b2d47cad80ff952a2a81f0e7@localhost> <491A90BE.9030005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:39389
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488AbYKLJQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 04:16:07 -0500
In-Reply-To: <491A90BE.9030005@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

On Wed, 12 Nov 2008 17:15:58 +0900, Tejun Heo <tj@kernel.org> wrote:

> Can you please test the attached patch?


ata_piix 0000:00:07.1: version 2.12
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe800 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe808 irq 15
ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
ata1.00: 66055248 sectors, multi 16: LBA
ata1.00: configured for MWDMA2
ata2.01: NODEV after polling detection
ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
ata2.00: configured for MWDMA2

This is the output I get. I do not know if I have any stalls there since I
am not in front of the machine right now.
But if I understand "NODEV after polling detection" correctly, the code is
no able to see that there is nothing attached there.
I will give it another reboot when I am back home to see if the stall is
still happening.

On a side note, since we are already talking about old chipsets and mobos.
Since this is a rather old hardware it was not possible to get the 40GB IBM
disk running in the first place. 
What I did back then (2.4 kernel days) was to use "ibmsetmax" to clamp the
disk to a smaller size and enabled the relevent option in the kernel. This
way I got past the BIOS (it stopped if the harddisk was saying it was >
32GB??) but the linux kernel correctly saw the right size.
Looking ad the dmesg output right now I think that it is only seeing the
smaller size.

sd 0:0:0:0: [sda] 66055248 512-byte hardware sectors (33820 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO

ibmsetmax output:
 ./ibmsetmax /dev/sda
Using device /dev/sda
native max address: 66055247
that is 33820286976 bytes, 33.8 GB
lba capacity: 66055248 sectors (33820286976 bytes)

Is the clamping feature present in 2.6 by default? I cannot test this with
a 2.4 kernel right now, since the libc no longer supports it. :)

Anyway thank you all very much for your time and support,
Michael

