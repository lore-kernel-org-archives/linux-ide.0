From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Sat, 23 Feb 2008 23:17:21 +0100
Message-ID: <20080223221721.5C8502DC002@tippex.mynet.homeunix.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <47BF0DCD.4060400@garzik.org> <20080222185645.9DD9C93C12F@tippex.mynet.homeunix.org> <47BF3DE3.4000100@rtr.ca> <20080222213932.3403F93C12F@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:48828 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752583AbYBWWSM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 17:18:12 -0500
In-reply-to: <20080222213932.3403F93C12F@tippex.mynet.homeunix.org> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>


aeriksson@fastmail.fm said:
>> But at this point libata is working much better than the old IDE stuff, and
>> it really is worth moving things over if you can. 
>
> Ok, I'll take a stab at that tomorrow. Two things... 

Having switched to ata_piix i can confirm that smartd doesn't hand the system 
anymore.

Still.. There seem to be a bug vs. the old drivers somewhere. Will that be 
addressed, or should there be a big warning for the old stuff (DEPRECATED?)

/A

