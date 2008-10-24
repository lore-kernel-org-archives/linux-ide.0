From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: 2.6.27-rc1 (2fca5c): libata: kernel cant boot
Date: Fri, 24 Oct 2008 16:32:12 +0900
Message-ID: <20081024073212.GA4008@linux-sh.org>
References: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com> <20081024070955.GN22217@kernel.dk> <20081024071329.GO22217@kernel.dk> <20081024071608.GA3879@linux-sh.org> <20081024072428.GP22217@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:31428 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751432AbYJXHcv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 03:32:51 -0400
Content-Disposition: inline
In-Reply-To: <20081024072428.GP22217@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, tj@kernel.org, torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Fri, Oct 24, 2008 at 09:24:29AM +0200, Jens Axboe wrote:
> On Fri, Oct 24 2008, Paul Mundt wrote:
> > On Fri, Oct 24, 2008 at 09:13:29AM +0200, Jens Axboe wrote:
> > > Darn, this smells like a train wreck. I'm assuming this fixes it?
> > > 
> > Yes, that fixes it.
> 
> OK, that's pretty bad. 2.6.28-rc1 will not work on any box using libata
> with non-ncq disks. If you need me, I'll be at the bar.
> 
At least you only missed -rc1 by a few hours, it was a good effort.. :-)

> From e598055dde1951c47c8b3522616f6ebff0ed9847 Mon Sep 17 00:00:00 2001
> From: Jens Axboe <jens.axboe@oracle.com>
> Date: Fri, 24 Oct 2008 09:22:42 +0200
> Subject: [PATCH] libata: fix bug with non-ncq devices
> 
> The recent commit 201f1b98822078c808b5e2d379a6ddbfc0a06ee1 to enable
> support for block layer tagging in libata was broken for non-NCQ
> devices. The block layer initializes the tag field to -1 to detect
> invalid uses of a tag, and if the libata devices does NOT support
> NCQ, we just used that field to index the internal command list.
> So we need to check for -1 first and only use the tag field if
> it's valid.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

Tested-by: Paul Mundt <lethal@linux-sh.org>

Thanks for the quick fix! Now I can go back to hacking on the stuff I
was avoiding..
