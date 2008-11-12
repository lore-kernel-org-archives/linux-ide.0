From: Michael Guntsche <mike@it-loops.com>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Wed, 12 Nov 2008 10:55:05 +0100
Message-ID: <f6c0b70008a38679e11dff42a0970c9c@localhost>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org> <90e002e7b2d47cad80ff952a2a81f0e7@localhost> <491A90BE.9030005@kernel.org> <1741f98465176fff86a1dda48fc965ac@localhost> <491AA18A.9090001@kernel.org> <fdc08450bd57b75c90440beab3d7534a@localhost> <491AA682.2000100@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:41610
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbYKLJzJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 04:55:09 -0500
In-Reply-To: <491AA682.2000100@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

On Wed, 12 Nov 2008 18:48:50 +0900, Tejun Heo <tj@kernel.org> wrote:

> Care to post "hdparm -I /dev/sda"?

Here it is.

/dev/sda:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
        Model Number:       IC35L040AVER07-0
        Serial Number:      SXPTXGK0136
        Firmware Revision:  ER4OA45A
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 1
        Supported: 5 4 3 & some of 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   66055248
        device size with M = 1024*1024:       32253 MBytes
        device size with M = 1000*1000:       33820 MBytes (33 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40     Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: disabled
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
                Release interrupt
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    READ/WRITE_DMA_QUEUED
                Advanced Power Management feature set
                Power-Up In Standby feature set
                SET_FEATURES required to spinup after power up
                Address Offset Reserved Area Boot
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    Device Configuration Overlay feature set
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        30min for SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct


/Mike
