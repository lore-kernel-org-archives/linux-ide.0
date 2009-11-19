From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_ali can't detect partitions
Date: Thu, 19 Nov 2009 21:10:31 +0000
Message-ID: <20091119211031.51cf95ff@lxorguk.ukuu.org.uk>
References: <20091109220338.GA1604@seek.priv>
	<20091110111125.15a71ed7@lxorguk.ukuu.org.uk>
	<20091119.125445.186207836.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43752 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752678AbZKSVIg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 16:08:36 -0500
In-Reply-To: <20091119.125445.186207836.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: gianluca@sottospazio.it, linux-ide@vger.kernel.org

> In the IDE layer driver, the guard is:
> 
> 	if (north && north->vendor != PCI_VENDOR_ID_AL)
> 		goto out;
> 
> This means the programming is done iff:
> 
> 1) We find no device at PCI_DEVFN(0,0)
> 
> 2) We find a device and vendor is ALI
> 
> I suspect case #1 triggers on sparc64.  The guard in the PATA
> driver is:
> 
> 	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
> 	if (north && north->vendor == PCI_VENDOR_ID_AL && ali_isa_bridge) {
> 
> which is different.  It won't do the programming if we find no
> device at PCI_DEVFN(0,0).
> 
> This might be the critical difference, I don't know, just pointing
> it out.

The logic in pata_ali is the intended logic there (and the comments in
drivers/ide match the code in pata_ali but the code doesn't)

What docs I have say you need to program the isa enable bit if you are
using an ALi north bridge (which always appears at 0,0,0). The other PC
case is the Transmeta systems, and in that case the setup is done by the
firmware and undocumented entirely.

I have exactly zero Sparc64 documentation on the subject. The only Sparc
related material I have is the C2/C3 post reset stuff. That *might* be a
relevant difference in behaviour for C2 and C3 devices but only with an
ALi bridge (ali_c2_c3_postreset)

Alan


