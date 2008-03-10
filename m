From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide-tape: remove tape->cache_stage
Date: Tue, 11 Mar 2008 00:24:51 +0100
Message-ID: <200803110024.51339.bzolnier@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <1205082632-3418-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29283 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbYCJXNA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 19:13:00 -0400
Received: by nf-out-0910.google.com with SMTP id g13so870464nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 16:12:59 -0700 (PDT)
In-Reply-To: <1205082632-3418-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 09 March 2008, Borislav Petkov wrote:
> Prior to allocating a new pipeline stage, the code checked for the existence of
> a cached pipeline stage to use. Do away with and stick to normal pipeline
> stages only.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

I modified it slightly while merging since AFAICS we still need to check
'tape->nr_stages >= tape_max_stages' for idetape_add_chrdev_write_request().

From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/4] ide-tape: remove tape->cache_stage

Prior to allocating a new pipeline stage, the code checked for the existence of
a cached pipeline stage to use. Do away with and stick to normal pipeline
stages only.

[bart: keep idetape_kmalloc_stage() for now]

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -365,8 +365,6 @@ typedef struct ide_tape_obj {
 	idetape_stage_t *next_stage;
 	/* New requests will be added to the pipeline here */
 	idetape_stage_t *last_stage;
-	/* Optional free stage which we can use */
-	idetape_stage_t *cache_stage;
 	int pages_per_stage;
 	/* Wasted space in each stage */
 	int excess_bh_size;
@@ -1686,16 +1684,10 @@ abort:
 
 static idetape_stage_t *idetape_kmalloc_stage(idetape_tape_t *tape)
 {
-	idetape_stage_t *cache_stage = tape->cache_stage;
-
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
 
 	if (tape->nr_stages >= tape->max_stages)
 		return NULL;
-	if (cache_stage != NULL) {
-		tape->cache_stage = NULL;
-		return cache_stage;
-	}
 	return __idetape_kmalloc_stage(tape, 0, 0);
 }
 
@@ -3245,10 +3237,7 @@ static int idetape_chrdev_release(struct
 		else
 			idetape_wait_for_pipeline(drive);
 	}
-	if (tape->cache_stage != NULL) {
-		__idetape_kfree_stage(tape->cache_stage);
-		tape->cache_stage = NULL;
-	}
+
 	if (minor < 128 && test_bit(IDETAPE_FLAG_MEDIUM_PRESENT, &tape->flags))
 		(void) idetape_rewind_tape(drive);
 	if (tape->chrdev_dir == IDETAPE_DIR_NONE) {
