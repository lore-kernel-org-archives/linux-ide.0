From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Wed, 23 Jul 2008 20:04:33 +0100
Message-ID: <20080723190433.GB26938@trinity.fluff.org>
References: <20080723144226.807475493@fluff.org> <20080723144227.253944199@fluff.org> <20080723163216.7477be06@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:53853 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbYGWTEf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 15:04:35 -0400
Content-Disposition: inline
In-Reply-To: <20080723163216.7477be06@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org

On Wed, Jul 23, 2008 at 04:32:16PM +0100, Alan Cox wrote:
> > is not correclty supported by libata as the pdev->irq field
> > has no valid interrupt set. This is due to the legacy IRQ
> > check in ata_pci_sff_activate_host() only checking to see 
> > if the device class is legacy, not that the IRQ has been
> > setup.
> 
> It does that check as that is the correct check to do. If the device is
> in native mode with no assigned IRQ we must poll, we cannot assume that
> legacy interrupts are in use.
> 
> > Change ata_pci_sff_activate_host() to try the legacy IRQ
> > numbers (which works correctly) when the dev->irq has not
> > been set. The current check for !legacy_mode && dev->irq
> > does not deal with devices that are not in legacy mode
> > but do not have mapped interrupts.
> 
> If they have no mapped interrupt and are not in legacy mode then they
> have no interrupt we can use and we should poll. Your assumption that if
> no IRQ is assigned we should use the legacy interrupts is incorrect for
> PC class systems.
> 
> Can you not correct this with a PCI quirk handler for your board instead ?

Ok, however the drivers/ide/pci/alim15x3.c still works fine
on this board, so there's something that something in the libata
driver path not working properly. Possibly drivers/ata/pata_ali.c
that is missing something

I will check this over tommorow and come up with a new solution.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

