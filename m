From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 12:17:14 +0200
Message-ID: <20080826101713.GW20055@kernel.dk>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [93.163.65.50] ([93.163.65.50]:25979 "EHLO kernel.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757773AbYHZKRQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 06:17:16 -0400
Content-Disposition: inline
In-Reply-To: <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, tj@kernel.org, linux-ide@vger.kernel.org

On Tue, Aug 26 2008, Alan Cox wrote:
> > a) Why was this limit put in there? It limits both transfer speed and
> >    request size. If it's due to some dodgy drive/bridge, perhaps we
> >    should just check for that and only apply the transfer limits when
> >    detected (or blacklisted). On the bridge setups I've seen, I've never
> >    had problems with killing the limit.
> 
> Various old bridges need it - and you can't detect the bridge type.

Not generically, but for some devices (like the Mtron) we can.

> > b) Put in a whitelist, easy to do for these Mtron drives.
> > 
> > c) Add a parameter to turn it on (or off, depending on the default) for
> >    a specific drive.
> > 
> > I'm in favor of a) personally, but I'd like to hear why the check was
> > added originally first. Dropping 20-30% of the throughput performance on
> > the floor without option seems like a really bad choice.
> 
> Can I suggest 
> 
> d) Assume the bridge is ok but teach the SATA error handling code that if
> there is a timeout immediately with such a bridge then to flip down to
> UDMA5 and knobble the transfer length.

That would be nice, assuming that we can rely on safe behaviour (eg not
data corrupting badness).

-- 
Jens Axboe

