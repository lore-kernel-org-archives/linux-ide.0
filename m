From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [git pull] IDE fixes
Date: Sat, 16 May 2009 21:22:19 +0200
Message-ID: <20090516192219.GA6202@liondog.tnic>
References: <200905162116.23690.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42577 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbZEPTWX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 May 2009 15:22:23 -0400
Content-Disposition: inline
In-Reply-To: <200905162116.23690.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Sat, May 16, 2009 at 09:16:23PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> ide-tape oops fix, icside regression fix and new piix cable quirk
> 
> Linus, please pull from 'for-linus' branch of:
> 
> master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git for-linus
> 
> to receive the following updates:
> 
>  drivers/ide/icside.c   |    2 +-
>  drivers/ide/ide-tape.c |    6 ------
>  drivers/ide/piix.c     |    1 +
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> 
> Alan Cox (1):
>       piix: The Sony TZ90 needs the cable type hardcoding
> 
> Sergei Shtylyov (1):
>       icside: register second channel of version 6 PCB
> 
> Tejun Heo (1):
>       ide-tape: remove back-to-back REQUEST_SENSE detection

I assume it is too late to add another ide-tape debug build fix I told
you about earlier today:

--
From: Mark de Wever <koraq@xs4all.nl>
Date: Sat, 16 May 2009 18:17:30 +0200
Subject: [PATCH] ide-tape: fix debug call

This error only occurs when IDETAPE_DEBUG_LOG is enabled.

Signed-off-by: Mark de Wever <koraq@xs4all.nl>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 9ca2665..521a5f5 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -592,7 +592,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	struct ide_cmd cmd;
 	u8 stat;
 
-	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %u\n"
+	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %u\n",
 		  (unsigned long long)blk_rq_pos(rq), blk_rq_sectors(rq));
 
 	if (!(blk_special_request(rq) || blk_sense_request(rq))) {
-- 
1.6.3

If so, you could still queue it for 30-rc7 if there would be one...

Thanks.

-- 
Regards/Gruss,
    Boris.
