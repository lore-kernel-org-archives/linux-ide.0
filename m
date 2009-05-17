From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/15 v2] ide-atapi: remove pc->buf and misc cleanups
Date: Sun, 17 May 2009 12:36:15 +0200
Message-ID: <200905171236.15366.bzolnier@gmail.com>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com> <200905162107.38332.bzolnier@gmail.com> <4A0F3963.8050000@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:47558 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZEQKdH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 06:33:07 -0400
In-Reply-To: <4A0F3963.8050000@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>


[ So long with my idyllic ide git tree experience... ]

On Sunday 17 May 2009 00:08:35 Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >> It also got rebased ontop of block/for-2.6.31 after Tejun's stuff got merged.
> ...

"..." == a lot of merge conflicts...

> > Looking at creation dates I suspect that somewhere along the way
> > something was rebased?
> > 
> > One quick temporary solution would be to recreate bp/pc-remove-buf
> > on top of tj/block-peek-fetch...

...which are coming up before tj/block-peek-fetch and which simply
shouldn't be there since there were no further modifications to these
files in ide-2.6.git/for-next

> Oh.. please use block commit.  Jens didn't pull in my tree but applied
> patches on top of the block tree, so my commits shouldn't be in any
> official trees.

I took a closer look and it seems the same is true for your earlier IDE
patchsets...  IOW they were also applied on top of block tree even though
your commits have been pulled into ide-2.6.git/for-next long before.

This seems to be wrong in terms of git usage and definitely is not what
we have agreed on w.r.t. handling of those patchsets.

Jens?
