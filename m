From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 19:54:27 +0000
Message-ID: <20120116195427.64edd96f@pyramind.ukuu.org.uk>
References: <20120109003255.GA6598@havoc.gtf.org>
	<CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com>
	<4F12E57E.3090805@garzik.org>
	<1326676534.13517.3.camel@minggr>
	<1326691403.13517.21.camel@minggr>
	<CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
	<20120116194211.2cd09fb3@pyramind.ukuu.org.uk>
	<CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38911 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2APTxX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 14:53:23 -0500
In-Reply-To: <CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lin Ming <ming.m.lin@intel.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, 16 Jan 2012 11:47:12 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jan 16, 2012 at 11:42 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> > There are two sets of problems with that
> >
> > The first is that quite a few machines crap themselves if you do this
> > because nobody has ever tested things like the IRQ routing or the
> > firmware on suspend/resume when they find the hardwared controller has
> > gone for a walk.
> 
> I think this could trivially be solved at least on these kinds of
> Apple machines by just making it a config option, and just not doing
> it if it doesn't work. Some kernel command line to say "ahci=force" or
> whatever.

There are patches for this from way back including a white list of
devices that were tested

Just ping Matthew about

http://www.codon.org.uk/~mjg59/tmp/ahci_quirk_cleanup.diff

> That doesn't solve the "user never even realized" problem, but at
> least it gives the user the possibility of solving the "crap firmware
> doesn't even allow this".

For the "memory found over 4GB" case it may even be worth printing a
warning.

> > Putting it back on suspend might help in some cases but then you get to
> > pick your way through the documentation minefield, deal with device
> > changes while in non AHCI mode, figure out how to set up registers the
> > BIOS didn't etc.
> 
> Yeah, no, that would just be horrible. I doubt it happens in practice,
> though.  I bet the normal PCI/AHCI resume will just do the right
> thing. But I haven't tried..

Some BIOSes go off and try and re-unlock the drive with the bios password
etc. They get most unhappy when the controller isn't in the mode they
expected. Matthew used a white list for some he tested which didn't have
problems. Most netbooks seem ok with it.

Alan
