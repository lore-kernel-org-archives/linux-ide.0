From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/15 v2] ide-atapi: remove pc->buf and misc cleanups
Date: Sun, 17 May 2009 15:12:49 +0200
Message-ID: <200905171512.50019.bzolnier@gmail.com>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com> <200905162135.53084.bzolnier@gmail.com> <20090517103343.GB27838@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:38278 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbZEQPUY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 11:20:24 -0400
In-Reply-To: <20090517103343.GB27838@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>

On Sunday 17 May 2009 12:33:43 Borislav Petkov wrote:
> Hi,
> 
> On Sat, May 16, 2009 at 09:35:52PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> [..]
> 
> > > > Looking at creation dates I suspect that somewhere along the way
> > > > something was rebased?
> > > > 
> > > > One quick temporary solution would be to recreate bp/pc-remove-buf
> > > > on top of tj/block-peek-fetch...
> > > 
> > > will do that first thing in the morning and push it for merging.
> > 
> > Cool, please also merge ide-tape DEBUG build fix while at it...
> 
> I'd suggest we merge that one before 2.6.30 hits the stores :) since it
> is trivial enough and I won't have to backport it. Here's a rediffed
> version against your for-next branch:
> 
> --
> 
> From: Mark de Wever <koraq@xs4all.nl>
> Date: Sun, 17 May 2009 12:29:28 +0200
> Subject: [PATCH] ide-tape: fix debug call
> 
> This error only occurs when IDETAPE_DEBUG_LOG is enabled.
> 
> Signed-off-by: Mark de Wever <koraq@xs4all.nl>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
