From: Pavel Machek <pavel@suse.cz>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 17 Aug 2006 11:18:42 +0200
Message-ID: <20060817091842.GC17899@elf.ucw.cz>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex> <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53229 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932382AbWHQJTF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 05:19:05 -0400
Content-Disposition: inline
In-Reply-To: <44E3E1E6.9090908@PicturesInMotion.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@falooley.org>, Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Stefan Seyfried <seife@suse.de>


> > I agree.  Moreover, the disk-related resume-from-ram problems are the hardest
> > ones (the graphics may be handled from the user land to a reasonable extent).
> >
> > Actually, I'm looking for someone who'd agree to be Cced on bug reports where
> > we suspect the problem may be related to IDE/PATA/SATA . ;-)
> >
> > Greetings,
> > Rafael
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >   
> Well it seems I am one of those users who is bit by the resume bug. I
> was wondering why no developer has replied to my
> bug(http://bugzilla.kernel.org/show_bug.cgi?id=6840) even though many
> users have. Id try to fix it myself but Ive never done kernel

Time to learn?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
