From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Tue, 26 Feb 2008 09:20:56 +0100
Message-ID: <20080226082056.7519C93C195@tippex.mynet.homeunix.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <200802240012.36571.bzolnier@gmail.com> <20080224082547.84F542DC002@tippex.mynet.homeunix.org> <200802241654.49150.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57550 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281AbYBZIVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 03:21:18 -0500
In-reply-to: <200802241654.49150.bzolnier@gmail.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>

> bzolnier@gmail.com said:
> > Could you try bisecting it down to the guilty commit using git-bisect?
> > [ the "old" stuff got few hundred commits in 2.6.25 ]
> > Thanks, Bart 

Ok, I got this:
852738f39258deafb3d89c187cb1a4050820d555 is first bad commit
commit 852738f39258deafb3d89c187cb1a4050820d555
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Sat Jan 26 20:13:12 2008 +0100

    ide: convert "empty" REQ_TYPE_ATA_CMD requests to use REQ_TYPE_ATA_TASKFILE

    Based on the previous work by Tejun Heo.

    There should be no functionality changes caused by this patch.

    Cc: Tejun Heo <htejun@gmail.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

:040000 040000 e65605824ccc1c8bda2ab6f917b5457d36c5537e 5fb514a261b13494c5e9c035f9e7598276ce8839 M      drivers

I'll run with the last known good version for a while,so if there's any more 
testing needed let me know.

/A 

