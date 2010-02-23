From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patch] atang tree: fix 2.6.32 SSD performance regression
Date: Tue, 23 Feb 2010 13:17:01 +0100
Message-ID: <201002231317.01128.bzolnier@gmail.com>
References: <201002222224.35860.bzolnier@gmail.com> <20100223062324.GI1025@kernel.dk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:63342 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab0BWMVI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2010 07:21:08 -0500
In-Reply-To: <20100223062324.GI1025@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Benjamin S." <sbenni@gmx.de>

On Tuesday 23 February 2010 07:23:24 am Jens Axboe wrote:
> On Mon, Feb 22 2010, Bartlomiej Zolnierkiewicz wrote:
> > DISCLAIMER: the fact of getting patches merged into atang tree means
> > that from now on they will be getting updates for changes happening
> > in atang tree and it should not be treated as an indication regarding
> > decisions taken by 'upstream' kernel trees
> > 
> > 
> > Fix 2.6.32 regression bringing back the desired SSD performance.
> > 
> > [ 'upstream' may want to wait for a proper resolution, for atang tree
> >   performance of big non-ATA boxes owned by a very few people is not
> >   of such a big concern as a major regression on a commodity hardware ]
> 
> What is the point of this, other than continuing your past history of
> political tirades?

I worry that you may be reading too much into it -- I don't use Linus'
tree or linux-next tree any longer so the next kernel I would see fix
for the issue is most likely 2.6.34 and there is a little point from my
personal perspective in waiting for such long time..

--
Bartlomiej Zolnierkiewicz
