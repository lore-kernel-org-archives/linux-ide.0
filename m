From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [REGRESSION] commit "ide: respect current DMA setting during resume" breaks resume on PowerBook G4
Date: Mon, 8 Dec 2008 17:51:49 +0100
Message-ID: <200812081751.51063.bzolnier@gmail.com>
References: <87wseb8mkm.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.186]:13345 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYLHQxM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 11:53:12 -0500
Received: by rn-out-0910.google.com with SMTP id k40so972111rnd.17
        for <linux-ide@vger.kernel.org>; Mon, 08 Dec 2008 08:53:11 -0800 (PST)
In-Reply-To: <87wseb8mkm.fsf@burly.wgtn.ondioline.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Collins <paul@burly.ondioline.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl

On Monday 08 December 2008, Paul Collins wrote:
> Commit e9eb8388306364295308132265c00bea685f409f ("ide: respect current
> DMA setting during resume") breaks resume on my PowerBook G4.
> 
> I get a stream of the following:
> 
>     hda: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
>     hda: task_out_intr: error=0x04 { DriveStatusError }
>     ide: failed opcode was: unknown
> 
> and generally the machine hangs, although once it reported
> 
>     ide0: reset: success
> 
> and resumed successfully.

Sorry about this.  I'll send the following patch to Linus in few minutes...

>From 1a659880ee755d96eeabe64bded059abed6d5ef5 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 8 Dec 2008 17:42:35 +0100
Subject: [PATCH] Revert "ide: respect current DMA setting during resume"

This reverts commit e9eb8388306364295308132265c00bea685f409f since
it could break resume (thanks to Paul Collins for the report).

I'll look into sorting this out properly for 2.6.29
but for 2.6.28 it is the best to just revert my patch.

Reported-by: Paul Collins <paul@burly.ondioline.org>
Cc: rjw@sisk.pl
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 7d275b2..cc35d6d 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -208,8 +208,10 @@ static ide_startstop_t ide_start_power_step(ide_drive_t *drive, struct request *
 		 */
 		if (drive->hwif->dma_ops == NULL)
 			break;
-		if (drive->dev_flags & IDE_DFLAG_USING_DMA)
-			ide_set_dma(drive);
+		/*
+		 * TODO: respect IDE_DFLAG_USING_DMA
+		 */
+		ide_set_dma(drive);
 		break;
 	}
 
-- 
1.6.0.4
