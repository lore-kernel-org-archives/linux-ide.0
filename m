From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/15 v2] ide-atapi: remove pc->buf and misc cleanups
Date: Sun, 17 May 2009 12:26:40 +0200
Message-ID: <20090517102640.GA27838@liondog.tnic>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com> <200905162107.38332.bzolnier@gmail.com> <4A0F3963.8050000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:65024 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559AbZEQK0p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 06:26:45 -0400
Content-Disposition: inline
In-Reply-To: <4A0F3963.8050000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, tj@kernel.org

Hi,

On Sun, May 17, 2009 at 07:08:35AM +0900, Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >> It also got rebased ontop of block/for-2.6.31 after Tejun's stuff got merged.
> ...
> > Looking at creation dates I suspect that somewhere along the way
> > something was rebased?
> > 
> > One quick temporary solution would be to recreate bp/pc-remove-buf
> > on top of tj/block-peek-fetch...
> 
> Oh.. please use block commit.  Jens didn't pull in my tree but applied
> patches on top of the block tree, so my commits shouldn't be in any
> official trees.

ok, this means we'll have to synchronize a bit here. I just scanned
the tj/block-peek-fetch changes and there will IMHO be one conflict
point with my patchset - ide_retry_pc() in ide-atapi but FWICS it won't
be a big pain to merge it since the two patchsets touch different
functionality.

So, I could wait till you sync with Jens after he has pulled
tj/block-peek-fetch and I rebase my changes on top of it. I could do
that quite fast and we'll be hitting the merge window alright.

Opinions? Better ideas?

-- 
Regards/Gruss,
    Boris.
