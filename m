From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Sun, 24 Feb 2008 00:12:36 +0100
Message-ID: <200802240012.36571.bzolnier@gmail.com>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <20080222213932.3403F93C12F@tippex.mynet.homeunix.org> <20080223221721.5C8502DC002@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:25564 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbYBWW7d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 17:59:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so272377ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 14:59:32 -0800 (PST)
In-Reply-To: <20080223221721.5C8502DC002@tippex.mynet.homeunix.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>


Hi,

On Saturday 23 February 2008, Anders Eriksson wrote:
> 
> aeriksson@fastmail.fm said:
> >> But at this point libata is working much better than the old IDE stuff, and
> >> it really is worth moving things over if you can. 
> >
> > Ok, I'll take a stab at that tomorrow. Two things... 
> 
> Having switched to ata_piix i can confirm that smartd doesn't hand the system 
> anymore.
> 
> Still.. There seem to be a bug vs. the old drivers somewhere. Will that be 
> addressed, or should there be a big warning for the old stuff (DEPRECATED?)

Could you try bisecting it down to the guilty commit using git-bisect?

[ the "old" stuff got few hundred commits in 2.6.25 ]

Thanks,
Bart
