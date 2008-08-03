From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
	and IDE
Date: Sun, 03 Aug 2008 14:21:24 -0500
Message-ID: <1217791284.4179.34.camel@localhost.localdomain>
References: <1217779055.4179.10.camel@localhost.localdomain>
	 <20080803173941.314edf33@lxorguk.ukuu.org.uk>
	 <1217783433.4179.18.camel@localhost.localdomain>
	 <20080803194501.24fa3e51@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:56225 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752761AbYHCTV3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 15:21:29 -0400
In-Reply-To: <20080803194501.24fa3e51@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Sun, 2008-08-03 at 19:45 +0100, Alan Cox wrote:
> > > There is a trend in new hardware to interfaces that simply won't fit old
> > > IDE so that process of libata only drivers is likely to continue.
> > 
> > Yes, that's SATA ... but legacy remains for a long time.
> 
> It isn't that simple. The newer PATA controllers are diverging from the
> old style interfaces as well.
> 
> > Yes, I understand this ... if that means drivers/ata can't possibly be
> > used by embedded until its dependence on SCSI is broken, then so be
> > it ... but I think we should at least investigate what the issues and
> > potential solutions are.
> 
> The simpler embedded wants a pure CF driver - no scsi, no libata, no
> drivers/ide overhead, just about 4K of CF only pio driver.

I'd be a bit surprised if that's anything other than a niche.  PIO is
deadly slow and wasteful of precious CPU cycles ... and embedded devices
seem to be interested in performance as well (which the DMA modes
bring).

> > Well, I did notice from the lists that both drivers/ide and drivers/ata
> > would be represented.  I've also observed that there's been a singular
> > lack of discussion of this on the lists; plus it's the type of emotive
> > issue that in-person discussions help to extract the heat from.
> 
> We've certainly discussed it in the past and I'm not sure its gotten that
> personal - many people contribute to both trees for example, or are
> directly cc'ing stuff between trees to ensure they stay in sync and any
> useful info gets in both.

My observation was merely that I hadn't seen it discussed.

> Anyway with my libata hat on I would say its far too early to worry about
> this. Right now we have platforms that need old IDE and it is still
> proving very useful to be able to ask people to try both. I don't quite
> know why Bart is putting so much effort into polishing up the old IDE but
> if he's enjoying it I don't really care 8)

Hey, I'd be the last person to discourage anyone from maintaining
obsolete systems ... however, the outside world looking in on this is
interested to know where they should be starting if they have some type
of CF/IDE device to support.  What we really want to avoid is someone
spending months on a device driver only to have us turn around and
deprecate the subsystem.

I don't envisage anything in terms of code changes (or removal) coming
out of this.  What I would like is a nice roadmap of where to start for
people contemplating writing IDE drivers.

James


