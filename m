From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/15 v2] ide-atapi: remove pc->buf and misc cleanups
Date: Sun, 17 May 2009 12:33:43 +0200
Message-ID: <20090517103343.GB27838@liondog.tnic>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com> <200905162107.38332.bzolnier@gmail.com> <20090516192319.GB6202@liondog.tnic> <200905162135.53084.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:51536 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZEQKdq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 06:33:46 -0400
Content-Disposition: inline
In-Reply-To: <200905162135.53084.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>

Hi,

On Sat, May 16, 2009 at 09:35:52PM +0200, Bartlomiej Zolnierkiewicz wrote:

[..]

> > > Looking at creation dates I suspect that somewhere along the way
> > > something was rebased?
> > > 
> > > One quick temporary solution would be to recreate bp/pc-remove-buf
> > > on top of tj/block-peek-fetch...
> > 
> > will do that first thing in the morning and push it for merging.
> 
> Cool, please also merge ide-tape DEBUG build fix while at it...

I'd suggest we merge that one before 2.6.30 hits the stores :) since it
is trivial enough and I won't have to backport it. Here's a rediffed
version against your for-next branch:

--

From: Mark de Wever <koraq@xs4all.nl>
Date: Sun, 17 May 2009 12:29:28 +0200
Subject: [PATCH] ide-tape: fix debug call

This error only occurs when IDETAPE_DEBUG_LOG is enabled.

Signed-off-by: Mark de Wever <koraq@xs4all.nl>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 8dfc688..203bbea 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -617,7 +617,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	struct ide_cmd cmd;
 	u8 stat;
 
-	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu\n"
+	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu\n",
 		  (unsigned long long)rq->sector, rq->nr_sectors);
 
 	if (!(blk_special_request(rq) || blk_sense_request(rq))) {
-- 
1.6.3



-- 
Regards/Gruss,
    Boris.
