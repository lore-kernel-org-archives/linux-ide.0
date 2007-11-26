From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Mon, 26 Nov 2007 07:55:18 +0000
Message-ID: <20071126075517.GA4141@ucw.cz>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com> <20071120220512.46b9e975@the-village.bc.nu> <20071126120649.GC4701@ucw.cz> <474CCA82.7030000@gmail.com> <474F3A4B.3080304@cfl.rr.com> <20071130131344.07b75f45@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3113 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754375AbXK3NcX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Nov 2007 08:32:23 -0500
Content-Disposition: inline
In-Reply-To: <20071130131344.07b75f45@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Phillip Susi <psusi@cfl.rr.com>, Tejun Heo <htejun@gmail.com>, noah <noah123@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Fri 2007-11-30 13:13:44, Alan Cox wrote:
> > Why does a single spurious interrupt cause it to be shut down?  I can 
> 
> It doesn't.
> 
> > see if the interrupt is stuck on and keeps interrupting constantly, but 
> > if it's just the occasional spurious interrupt, why not just ignore it 
> > and move on?
> 
> The interrupt is usually level triggered so it continues to create
> interrupts until you silence it. The thresholds are about 10,000
> interrupt events and on newer kernels we also reset the count if we don't
> see any for a while. That works for most stuff except the thinkpad
> bluetooth problem.

Which is confirmed hw problem now, btw.
						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
