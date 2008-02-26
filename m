From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Tue, 26 Feb 2008 20:54:12 +0100
Message-ID: <200802262054.12806.bzolnier@gmail.com>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <200802241654.49150.bzolnier@gmail.com> <20080226082056.7519C93C195@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:27320 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbYBZWX1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 17:23:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so46398ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 26 Feb 2008 14:23:24 -0800 (PST)
In-Reply-To: <20080226082056.7519C93C195@tippex.mynet.homeunix.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>

On Tuesday 26 February 2008, Anders Eriksson wrote:
> > bzolnier@gmail.com said:
> > > Could you try bisecting it down to the guilty commit using git-bisect?
> > > [ the "old" stuff got few hundred commits in 2.6.25 ]
> > > Thanks, Bart 
> 
> Ok, I got this:
> 852738f39258deafb3d89c187cb1a4050820d555 is first bad commit
> commit 852738f39258deafb3d89c187cb1a4050820d555
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Sat Jan 26 20:13:12 2008 +0100
> 
>     ide: convert "empty" REQ_TYPE_ATA_CMD requests to use REQ_TYPE_ATA_TASKFILE
> 
>     Based on the previous work by Tejun Heo.
> 
>     There should be no functionality changes caused by this patch.
> 
>     Cc: Tejun Heo <htejun@gmail.com>
>     Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> :040000 040000 e65605824ccc1c8bda2ab6f917b5457d36c5537e 5fb514a261b13494c5e9c035f9e7598276ce8839 M      drivers
> 
> I'll run with the last known good version for a while,so if there's any more 
> testing needed let me know.

Thanks.

Unfortunately nothing seems wrong with the patch... :(

I'll take a closer look when I have some more time...

Bart
