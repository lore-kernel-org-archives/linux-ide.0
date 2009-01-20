From: Mark Lord <liml@rtr.ca>
Subject: Re: libata, devm_*, and MSI ?
Date: Tue, 20 Jan 2009 11:07:49 -0500
Message-ID: <4975F6D5.1040807@rtr.ca>
References: <4975F5C1.8090107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55210 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166AbZATQHv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 11:07:51 -0500
In-Reply-To: <4975F5C1.8090107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-pci@vger.kernel.org

Mark Lord wrote:
> Tejun / Jeff,
> 
> I am working on MSI support for sata_mv, and am trying to puzzle out
> exactly what the kernel expects for this.  Looking at other drivers,
> both libata and otherwise, yields a variety of conflicting implementations.
> 
> For starters, the MSI HOW-TO suggests that drivers must be careful
> to invoke pci_disable_msi() on module unload, but I don't see that
> happening anywhere in libata.
> 
> Unless, Tejun, the devm_* routines automatically do this.. do they?
> 
> Next, there's no mention of a need for invoking pci_intx() in the HOW-TO,
> yet some device drivers call it, and others do not.
> 
> Eg. from ahci.c, we have this:
> 
>        if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
>                pci_intx(pdev, 1);
> 
> Which agrees with the existing code in sata_mv:
> 
>        if (msi && pci_enable_msi(pdev))
>                pci_intx(pdev, 1);
> 
> Which seems to call pci_intx() only when MSI is *not* used.  Fine.
> But then in sata_vsc.c, we do sort of the opposite:
> 
>        if (pci_enable_msi(pdev) == 0)
>                pci_intx(pdev, 0);
> 
> Either that one is wrong, or pci_intx() is unnecessary in all cases.
> Again, the MSI HOW-TO doesn't even mention this routine.
> 
> Looking through the network drivers, it seems that some of them
> do the pci_intx(pdev,1) call for the cases where pci_enable_msi() fails,
> similar to ahci.c and sata_mv.c.
> 
> But not all of them do that.
..

Looking through drivers/pci/*, it appears that the call to pci_intx()
should be totally redundant.  pci_enable_msi() does pci_intx(pdev,0)
on success only, and doesn't touch it otherwise.

Similarly, pci_disable_msi() does pci_intx(pdev,1).

So, where does libata cause pci_disable_msi() to be invoked?
Or is that just missing at the moment?

Thanks.
