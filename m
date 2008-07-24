From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Thu, 24 Jul 2008 14:50:02 +0100
Message-ID: <20080724135002.GL26938@trinity.fluff.org>
References: <20080723144226.807475493@fluff.org> <20080723144227.253944199@fluff.org> <20080723163216.7477be06@lxorguk.ukuu.org.uk> <20080723190433.GB26938@trinity.fluff.org> <20080723201349.33226d58@lxorguk.ukuu.org.uk> <20080724112637.GG26938@trinity.fluff.org> <20080724121328.5d281b97@lxorguk.ukuu.org.uk> <20080724115042.GK26938@trinity.fluff.org> <20080724125922.744923d7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:53649 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbYGXNuE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 09:50:04 -0400
Content-Disposition: inline
In-Reply-To: <20080724125922.744923d7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

On Thu, Jul 24, 2008 at 12:59:22PM +0100, Alan Cox wrote:
> On Thu, 24 Jul 2008 12:50:42 +0100
> Ben Dooks <ben-linux@fluff.org> wrote:
> 
> > On Thu, Jul 24, 2008 at 12:13:28PM +0100, Alan Cox wrote:
> > > > I had a look, and there doesn't seem to be any way of specifying an
> > > > IRQ for a host port when registering with libata-sff.c, which is a
> > > > problem since we need to be able to either pass-in or have a callback
> > > > to allow our "quirk" to specify a new IRQ for the device.
> > > 
> > > Currently there is not. However if the device as a whole is wired to IRQ
> > > 14 you want to quirk pdev->irq.
> > 
> > That would be great if both channels are mapped to 14, however the
> > mapping set by default is for each channel to have an unique IRQ.
> 
> Ok so you've got a board reporting native mode using the legacy IRQ
> numbering (14/15 - or platform equivalents) ? In which case may I suggest
> you rewrite the header to indicate it is in legacy mode as per the BIOS
> guide ?

The drivers/ide/pci/alim15x3.c driver currently has code to correctly
set the IRQ fields for anything that isn't SPARC. Does this mean we
must disable the libata driver for anything that isn't SPARC? What about
other boards where this device combination is present?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

