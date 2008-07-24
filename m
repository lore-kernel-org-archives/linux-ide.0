From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Thu, 24 Jul 2008 12:26:37 +0100
Message-ID: <20080724112637.GG26938@trinity.fluff.org>
References: <20080723144226.807475493@fluff.org> <20080723144227.253944199@fluff.org> <20080723163216.7477be06@lxorguk.ukuu.org.uk> <20080723190433.GB26938@trinity.fluff.org> <20080723201349.33226d58@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:53236 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYGXL0k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 07:26:40 -0400
Content-Disposition: inline
In-Reply-To: <20080723201349.33226d58@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

On Wed, Jul 23, 2008 at 08:13:49PM +0100, Alan Cox wrote:
> > Ok, however the drivers/ide/pci/alim15x3.c still works fine
> > on this board, so there's something that something in the libata
> > driver path not working properly. Possibly drivers/ata/pata_ali.c
> > that is missing something
> 
> The old driver makes some rather iffy assumptions when dev->irq == 0 in
> part because the old IDE code predates PCI quirks.

>From reading the ALI M1543 datasheets that the interrupt pin in either
mode (compatibility or native) is routed directly into the inbuilt ISA-PIC,
and thus the IRQ field in the PCI child device is not available. This
means we need to be able to override the IRQ numbers for these devices.

I had a look, and there doesn't seem to be any way of specifying an
IRQ for a host port when registering with libata-sff.c, which is a
problem since we need to be able to either pass-in or have a callback
to allow our "quirk" to specify a new IRQ for the device.

Does anyone know if the ALi M5229 actually exists outside of one of
the M1543 bridges?

Note, this hardly seems to be a board-quirk, it is more of a device
quirk...

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

