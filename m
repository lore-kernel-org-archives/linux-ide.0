From: David Miller <davem@davemloft.net>
Subject: Re: pata_ali can't detect partitions
Date: Thu, 19 Nov 2009 12:54:45 -0800 (PST)
Message-ID: <20091119.125445.186207836.davem@davemloft.net>
References: <20091109220338.GA1604@seek.priv>
	<20091110111125.15a71ed7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47134
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755442AbZKSUy2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 15:54:28 -0500
In-Reply-To: <20091110111125.15a71ed7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: gianluca@sottospazio.it, linux-ide@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 10 Nov 2009 11:11:25 +0000

> Some of the registers involved are deep magic (even with the official
> documentation its unclear what should occur in all cases). I will have
> another dig - probably it depends on the chip rev what the right setting
> is.

So while getting my sunblade up and going, I took a look at the
patch in question.  The northbridge logic changed a bit and
I suspect this is part of the problem.

In the IDE layer driver, the guard is:

	if (north && north->vendor != PCI_VENDOR_ID_AL)
		goto out;

This means the programming is done iff:

1) We find no device at PCI_DEVFN(0,0)

2) We find a device and vendor is ALI

I suspect case #1 triggers on sparc64.  The guard in the PATA
driver is:

	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
	if (north && north->vendor == PCI_VENDOR_ID_AL && ali_isa_bridge) {

which is different.  It won't do the programming if we find no
device at PCI_DEVFN(0,0).

This might be the critical difference, I don't know, just pointing
it out.

I'll do some checks once my slow test system is up and going.

