From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious
 IRQs
Date: Wed, 26 Nov 2008 10:47:31 +0000
Message-ID: <20081126104731.4b370d18@lxorguk.ukuu.org.uk>
References: <49263552.8090602@kernel.org>
	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>
	<492C30EE.9080600@garzik.org>
	<492CBA05.8000107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48815 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750879AbYKZKr2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Nov 2008 05:47:28 -0500
In-Reply-To: <492CBA05.8000107@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> > A separate interrupt function can, for example, perform an MMIO read to
> > check irq-pending, outside of a spinlock.  ->irq_pending callback is a
> > bit more constraining.
> 
> If we call ->irq_pending() only when no qc is in flight, I don't think
> there will be any noticeable performance penalty when the IRQ pending

Agreed

> All BMDMA controllers I know about are sata_sil (already has private
> irq handler) and ata_piix (this patch).  Alan, how do other
> controllers do it?

CMD chipsets do a register read .. from PCI config space (gak)
SIL680 is similar
SI3112 adds the fact you need to keep at the PHY as well.
Promise uses a magic register at dmabase + 0x1D which holds irq bits

All much the same. What I'd like to understand better is why we need any
of these ...

Alan
