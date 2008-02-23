From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Sat, 23 Feb 2008 21:49:01 +0100
Message-ID: <20080223204900.GA4340@ucw.cz>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <47BF0DCD.4060400@garzik.org> <20080222185645.9DD9C93C12F@tippex.mynet.homeunix.org> <47BF3DE3.4000100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4543 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751724AbYBXHzi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 02:55:38 -0500
Content-Disposition: inline
In-Reply-To: <47BF3DE3.4000100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Anders Eriksson <aeriksson@fastmail.fm>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>

Hi!

> So that's using the old IDE drivers.
> And the network and USB are sharing IRQ#11 with each 
> other.
> 
> If you are going to be using newer kernels like this 
> (2.6.23+),
> then you might consider shifting those drives over to 
> libata drivers.

Yes, that will probably fix it for him, but but... maybe we should fix
that regression?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
