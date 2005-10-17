From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 10:06:39 -0700
Message-ID: <200510171006.39206.jbarnes@virtuousgeek.org>
References: <20051017044606.GA1266@havoc.gtf.org> <200510170952.34174.jbarnes@virtuousgeek.org> <4353D96F.90805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:21470 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750960AbVJQRGx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Oct 2005 13:06:53 -0400
In-Reply-To: <4353D96F.90805@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com

On Monday, October 17, 2005 10:03 am, Jeff Garzik wrote:
> Jesse Barnes wrote:
> > It does, since it prevents one of the ports from being bound by the
> > legacy IDE driver.  But the whole thing is rather hackish to begin
> > with, and I prefer this hack to the existing code (in fact, Andrew
> > already queued up a patch from me in -mm that looks just like
> > yours).
> >
> > Ultimately, when libata gets ATAPI support, I think we just have to
> > declare libata and legacy IDE to be incompatible for combined mode
> > devices and remove the quirk.  Then whichever driver loads first
> > will get the whole device, as it should.
>
> I would love to remove the quirk completely!
>
> Unfortunately combined mode is a runtime BIOS configuration, and there
> is also the lockup issue I mentioned in another email.

So sometimes the legacy IDE driver will lock up when it tries to drive 
both ports in a combined configuration?  In that case, can't we just 
disable the legacy IDE driver for these chips and force the use of the 
libata version?

Jesse
