From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Wed, 23 Jul 2008 16:32:16 +0100
Message-ID: <20080723163216.7477be06@lxorguk.ukuu.org.uk>
References: <20080723144226.807475493@fluff.org>
	<20080723144227.253944199@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48799 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752675AbYGWPt0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 11:49:26 -0400
In-Reply-To: <20080723144227.253944199@fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

> is not correclty supported by libata as the pdev->irq field
> has no valid interrupt set. This is due to the legacy IRQ
> check in ata_pci_sff_activate_host() only checking to see 
> if the device class is legacy, not that the IRQ has been
> setup.

It does that check as that is the correct check to do. If the device is
in native mode with no assigned IRQ we must poll, we cannot assume that
legacy interrupts are in use.

> Change ata_pci_sff_activate_host() to try the legacy IRQ
> numbers (which works correctly) when the dev->irq has not
> been set. The current check for !legacy_mode && dev->irq
> does not deal with devices that are not in legacy mode
> but do not have mapped interrupts.

If they have no mapped interrupt and are not in legacy mode then they
have no interrupt we can use and we should poll. Your assumption that if
no IRQ is assigned we should use the legacy interrupts is incorrect for
PC class systems.

Can you not correct this with a PCI quirk handler for your board instead ?

Alan

