From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Fri, 22 Feb 2008 17:00:04 -0500
Message-ID: <47BF45E4.4020006@garzik.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <47BF0DCD.4060400@garzik.org> <20080222185645.9DD9C93C12F@tippex.mynet.homeunix.org> <47BF3DE3.4000100@rtr.ca> <20080222213932.3403F93C12F@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52602 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbYBVWAI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 17:00:08 -0500
In-Reply-To: <20080222213932.3403F93C12F@tippex.mynet.homeunix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>

Anders Eriksson wrote:
> Is smartd prepared to handle /dev/sdX style devices?

Yes.  You need to pass "-d ata" to smartd and smartctl, if your scripts 
are not already doing so.


> If this is the prefered driver these days, maybe it shouldn't be marked 
> experimental in the menu anymore?

It's not marked experimental.

	Jeff


