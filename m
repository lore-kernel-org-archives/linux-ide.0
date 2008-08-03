From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
	and IDE
Date: Sun, 03 Aug 2008 12:10:33 -0500
Message-ID: <1217783433.4179.18.camel@localhost.localdomain>
References: <1217779055.4179.10.camel@localhost.localdomain>
	 <20080803173941.314edf33@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:36056 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756583AbYHCRKj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 13:10:39 -0400
In-Reply-To: <20080803173941.314edf33@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Sun, 2008-08-03 at 17:39 +0100, Alan Cox wrote:
> On Sun, 03 Aug 2008 10:57:35 -0500
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > Right at the moment, we have two separate subsystems for running IDE
> > type devices:  driver/ide and drivers/ata.  The claim I've seen is that
> > drivers/ata can do everything drivers/ide can do plus it does sata.  I
> > also note that no major distribution seems to enable anything in
> > drivers/ide anymore, so given this is it time to deprecate drivers/ide?
> > 
> > A counter argument to the above is that not all drivers (particularly
> > the older ones where hw is scarce) are converted to drivers/ata, so
> 
> That statement would be false. In fact for old and obscure hw the libata
> coverage is probably better, not that this in fact is the slighest bit
> relevant to the real world!
> 
> The current situation is something like this

Hmm, OK, but I did see (as you note below) that mac ide doesn't work
with drivers/ata.

> - For PC class hardware libata covers everything in old IDE and a lot
> more.
> - For the older Mac hardware libata does not have pre PCI Macintosh
> support although it is in progress
> - For certain embedded PPC boards there are some things to sort out with
> IRQ routing on non standards sane configurations using pata_ali in
> particular.
> 
> There is a trend in new hardware to interfaces that simply won't fit old
> IDE so that process of libata only drivers is likely to continue.

Yes, that's SATA ... but legacy remains for a long time.

> > drivers/ide seems to be needed for some legacy systems (in which case it
> > can be deprecated but not removed).  I've also noted that some embedded
> > distributions seem to be using drivers/ide, but I'm not really sure
> > whether this is inertia or some overriding need.
> 
> Actually what a material number of embedded systems need is a single
> dumb-as-a-rock CF only PIO driver which doesn't suck in large chunks of
> midlayer code. I'm just not sure that trend will continue as CF is giving
> way to other smaller media.

Yes, I understand this ... if that means drivers/ata can't possibly be
used by embedded until its dependence on SCSI is broken, then so be
it ... but I think we should at least investigate what the issues and
potential solutions are.

> > The proposal is to discuss the future of these two subsystems and arrive
> > at a consensus what's happening to each going forwards.
> 
> Won't be at KS and I suspect that is true of most of the folks hacking on
> both sets so the right place for discussion would be the net. Right now
> the PPC bits need fixing, and the lack of libata Macio support for the
> moment makes the debate premature.

Well, I did notice from the lists that both drivers/ide and drivers/ata
would be represented.  I've also observed that there's been a singular
lack of discussion of this on the lists; plus it's the type of emotive
issue that in-person discussions help to extract the heat from.

James


