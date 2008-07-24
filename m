From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Thu, 24 Jul 2008 18:12:32 +0200
Message-ID: <200807241812.32988.bzolnier@gmail.com>
References: <20080723144227.253944199@fluff.org> <20080724145215.496d3ed4@lxorguk.ukuu.org.uk> <20080724141710.GN26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:55743 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYGXQPD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 12:15:03 -0400
Received: by ug-out-1314.google.com with SMTP id h2so608948ugf.16
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 09:15:00 -0700 (PDT)
In-Reply-To: <20080724141710.GN26938@trinity.fluff.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, vince@simtec.co.uk


Hi,

On Thursday 24 July 2008, Ben Dooks wrote:
> On Thu, Jul 24, 2008 at 02:52:15PM +0100, Alan Cox wrote:
> > > > Ok so you've got a board reporting native mode using the legacy IRQ
> > > > numbering (14/15 - or platform equivalents) ? In which case may I suggest
> > > > you rewrite the header to indicate it is in legacy mode as per the BIOS
> > > > guide ?
> > > 
> > > The drivers/ide/pci/alim15x3.c driver currently has code to correctly
> > > set the IRQ fields for anything that isn't SPARC. Does this mean we
> > > must disable the libata driver for anything that isn't SPARC? What about
> > > other boards where this device combination is present?
> > 
> > There should be no boards where this combination is present. IRQ 0 in
> > native mode means "polled". It would therefore be helpful if you would
> > start considering your board as a problem special case - one we need to
> > support yes - rather than trying to argue that we should break support
> > for standard configurations.
> 
> So just because we fit a chip, we're suddenyly a special case? Moving
> to libata has ignored the code in the old IDE driver which ensures that
> the IRQ driver is used. I have no idea how many other systems have this
> same problems, but the systems we've shipped have had this chip setup
> for nearly 10 years now.

Please note that the recommended PATA support in kernel.org kernels
is IDE subsystem and libata PATA is still considered experimental.

> I admit the original fix is wrong, the change should be handled by some
> form of callback or a method of passing the interrupt numbers in when
> registering with the libata-sff.c driver.

Seems like the good solution would be to:

- add PCI HEADER quirk to claim legacy mode (as suggested by Alan)

- move ALi IRQ handling code to PCI layer and then hook it into
  pci_get_legacy_ide_irq()

Thanks,
Bart
