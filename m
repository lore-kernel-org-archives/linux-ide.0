From: Matthieu CASTET <matthieu.castet@sagem.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 09:35:38 +0200
Message-ID: <OFED10B103.942F56FA-ONC1257171.0028EEA3-C1257171.0029B954@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.sagem.com ([62.160.59.65]:38365 "EHLO mx1.sagem.com")
	by vger.kernel.org with ESMTP id S1750974AbWEQHfo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 03:35:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-ide-owner@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Llu, 2006-05-15 at 14:15 -0400, Jeff Garzik wrote:
> > which persists on Sil 311x on rare motherboards.  The rest are either 
> > addressed with the improved error handling, or are ATAPI + VIA AFAICS.

> ATAPI + VIA to that pattern is also showing up on pata_via cases as
> well, but only on via so far. Its as if there is a case where the IRQ of
> the first command is lost sometimes.
I investigated further the problem. For my pata case the interrupt go 
through idle_irq in ata_host_intr.
If I put a printk before ata_host_intr in ata_interrupt there no problem.

I bet "altstatus" or "main status" return ATA_BUSY and are not cleared 
enough fast by the hardware.

I will try others tests this evening.


Matthieu


