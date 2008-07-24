From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Thu, 24 Jul 2008 15:17:10 +0100
Message-ID: <20080724141710.GN26938@trinity.fluff.org>
References: <20080723144227.253944199@fluff.org> <20080723163216.7477be06@lxorguk.ukuu.org.uk> <20080723190433.GB26938@trinity.fluff.org> <20080723201349.33226d58@lxorguk.ukuu.org.uk> <20080724112637.GG26938@trinity.fluff.org> <20080724121328.5d281b97@lxorguk.ukuu.org.uk> <20080724115042.GK26938@trinity.fluff.org> <20080724125922.744923d7@lxorguk.ukuu.org.uk> <20080724135002.GL26938@trinity.fluff.org> <20080724145215.496d3ed4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:46876 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYGXORM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 10:17:12 -0400
Content-Disposition: inline
In-Reply-To: <20080724145215.496d3ed4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

On Thu, Jul 24, 2008 at 02:52:15PM +0100, Alan Cox wrote:
> > > Ok so you've got a board reporting native mode using the legacy IRQ
> > > numbering (14/15 - or platform equivalents) ? In which case may I suggest
> > > you rewrite the header to indicate it is in legacy mode as per the BIOS
> > > guide ?
> > 
> > The drivers/ide/pci/alim15x3.c driver currently has code to correctly
> > set the IRQ fields for anything that isn't SPARC. Does this mean we
> > must disable the libata driver for anything that isn't SPARC? What about
> > other boards where this device combination is present?
> 
> There should be no boards where this combination is present. IRQ 0 in
> native mode means "polled". It would therefore be helpful if you would
> start considering your board as a problem special case - one we need to
> support yes - rather than trying to argue that we should break support
> for standard configurations.

So just because we fit a chip, we're suddenyly a special case? Moving
to libata has ignored the code in the old IDE driver which ensures that
the IRQ driver is used. I have no idea how many other systems have this
same problems, but the systems we've shipped have had this chip setup
for nearly 10 years now.

I admit the original fix is wrong, the change should be handled by some
form of callback or a method of passing the interrupt numbers in when
registering with the libata-sff.c driver.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

