From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 10:42:37 +0100
Message-ID: <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
References: <20080826072841.GS20055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45679 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753094AbYHZKBY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 06:01:24 -0400
In-Reply-To: <20080826072841.GS20055@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: jeff@garzik.org, tj@kernel.org, linux-ide@vger.kernel.org

> a) Why was this limit put in there? It limits both transfer speed and
>    request size. If it's due to some dodgy drive/bridge, perhaps we
>    should just check for that and only apply the transfer limits when
>    detected (or blacklisted). On the bridge setups I've seen, I've never
>    had problems with killing the limit.

Various old bridges need it - and you can't detect the bridge type.

> 
> b) Put in a whitelist, easy to do for these Mtron drives.
> 
> c) Add a parameter to turn it on (or off, depending on the default) for
>    a specific drive.
> 
> I'm in favor of a) personally, but I'd like to hear why the check was
> added originally first. Dropping 20-30% of the throughput performance on
> the floor without option seems like a really bad choice.

Can I suggest 

d) Assume the bridge is ok but teach the SATA error handling code that if
there is a timeout immediately with such a bridge then to flip down to
UDMA5 and knobble the transfer length.
