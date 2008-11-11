From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.28-rc3 libata: still "failed to IDENTIFY" on bootup
Date: Tue, 11 Nov 2008 18:36:30 +0900
Message-ID: <4919521E.2040703@kernel.org>
References: <20081109130231.GA20290@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40232 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbYKKJgy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 04:36:54 -0500
In-Reply-To: <20081109130231.GA20290@rhlx01.hs-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Andreas Mohr wrote:
> on my Inspiron 8000, I keep getting this on bootup (including the
> ensuing 3 x 5 second delay!):
> 
> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xbfa0 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xbfa8 irq 15
> Switched to high resolution mode on CPU 0
> ata1.00: ATA-6: IC25N060ATMR04-0, MO3OAD0A, max UDMA/100
> ata1.00: 117210240 sectors, multi 8: LBA48
> ata1.01: ATAPI: TOSHIBA DVD-ROM SD-C2402, X021, max UDMA/33
> ata1.00: configured for UDMA/100
> ata1.01: configured for UDMA/33
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata2.00: ATAPI: SONY    CD-RW  CRX700E, 1.4u, max MWDMA2
> ata2.00: configured for MWDMA2
> 
> This did not occur with kernels <= config-2.6.24-rc6 and did occur
> with _all_ kernels >= config-2.6.26-rc5, if I'm not entirely
> mistaken (I believe there has been a large libata update in
> between).
> 
> # hdparm -I /dev/sr1
> 
> /dev/sr1:
> 
> ATAPI CD-ROM, with removable media
>         Model Number:       SONY    CD-RW  CRX700E
>         Firmware Revision:  1.4u
> Standards:
>         Likely used CD-ROM ATAPI-1
> Configuration:
>         DRQ response: 50us.
>         Packet size: 12 bytes
> Capabilities:
>         LBA, IORDY(can be disabled)
>         DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=180ns  IORDY flow control=120ns
>   
> 
> As you can see, ata2.00 AKA /dev/sr1 is a single-drive controller setup,
> if only I knew whether it's hardware-configured
> as Master / Slave or Cable Select...
> 
> Earlier kernels did not have any IDENTIFY bootup delay (both old-style ide
> and my earlier libata configurations!), but I assume this ""problem"" occured
> due to some _increase_ in verification functionality in later kernels,
> not due to some stupid bug.
> 
> So, since earlier kernels did not annoy me with a 15-second delay
> since they didn't detect a problematic controller port configuration,
> what can we do about this now?
> 
> How can I figure out my controller configuration? The drive in question
> is a removeable notebook CD writer.
> 
> If this turns out to be (e.g.) an "illegal" Master-only configuration
> (thus with a "phantom" second drive), then is there a way to blacklist
> (DMI etc.) my notebook model for this check?
> And what if this happens to be a "legal" Cable Select setup which thus
> shouldn't trigger this IDENTIFY problem?

Hmm... this is our second report on phantom device problem.  I thought
the initial one was controller/device specific but it looks like we
genuinely screwed up something here.  Can you please post the result
of "lspci -nn" and full kernel boot log?

Thanks.

-- 
tejun
