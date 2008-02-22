From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Fri, 22 Feb 2008 22:39:31 +0100
Message-ID: <20080222213932.3403F93C12F@tippex.mynet.homeunix.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <47BF0DCD.4060400@garzik.org> <20080222185645.9DD9C93C12F@tippex.mynet.homeunix.org> <47BF3DE3.4000100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:45850 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755891AbYBVVjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 16:39:55 -0500
In-reply-to: <47BF3DE3.4000100@rtr.ca> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Anders Eriksson <aeriksson@fastmail.fm>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>


liml@rtr.ca said:
> So that's using the old IDE drivers. And the network and USB are sharing
> IRQ#11 with each other.

> If you are going to be using newer kernels like this (2.6.23+), then you
> might consider shifting those drives over to libata drivers.

> This involves a little bit of work -- building a kernel with libata and
> "ata_piix" built-in instead of the old IDE drivers, and then rearranging /etc/
> fstab to match the new device names (eg. /dev/sda instead of /dev/hda).

> But at this point libata is working much better than the old IDE stuff, and
> it really is worth moving things over if you can. 

Ok, I'll take a stab at that tomorrow. Two things...

Is smartd prepared to handle /dev/sdX style devices?

If this is the prefered driver these days, maybe it shouldn't be marked 
experimental in the menu anymore?

/A



