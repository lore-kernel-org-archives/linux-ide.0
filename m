From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 07/22] ide-tape: struct idetape_tape_t: shorten member names v2
Date: Tue, 5 Feb 2008 02:23:21 +0100
Message-ID: <200802050223.21176.bzolnier@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <1202132440-26648-8-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:16651 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355AbYBEBPJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 20:15:09 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2168782mue.5
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 17:15:08 -0800 (PST)
In-Reply-To: <1202132440-26648-8-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 04 February 2008, Borislav Petkov wrote:
> Shorten some member names not too aggressively since this driver might be gone
> anyway soon.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-tape.c |  210 ++++++++++++++++++++++++++----------------------
>  1 files changed, 113 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 126e8a9..0b5ccce 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c

[...]

> @@ -1583,7 +1579,8 @@ static void idetape_create_read_cmd(idetape_tape_t *tape, idetape_pc_t *pc, unsi
>  	pc->bh = bh;
>  	atomic_set(&bh->b_count, 0);
>  	pc->buffer = NULL;
> -	pc->request_transfer = pc->buffer_size = length * tape->tape_block_size;
> +	pc->buffer_size		= length * tape->blk_size;
> +	pc->request_transfer	= length * tape->blk_size;
>  	if (pc->request_transfer == tape->stage_size)
>  		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
>  }
> @@ -1621,7 +1618,8 @@ static void idetape_create_write_cmd(idetape_tape_t *tape, idetape_pc_t *pc, uns
>  	pc->b_data = bh->b_data;
>  	pc->b_count = atomic_read(&bh->b_count);
>  	pc->buffer = NULL;
> -	pc->request_transfer = pc->buffer_size = length * tape->tape_block_size;
> +	pc->request_transfer	= length * tape->blk_size;
> +	pc->buffer_size		= length * tape->blk_size;
>  	if (pc->request_transfer == tape->stage_size)
>  		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
>  }

for some reason gcc doesn't seem to optimize the new code as well as
the old one (=> driver size goes up instead of staying unchanged)

interdiff between original patch and merged version:

diff -u b/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- b/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -324,7 +324,7 @@
 	/* Current character device data transfer direction */
 	u8 chrdev_dir;
 
-	/* tape block size, usu. 512 or 1024 bytes */
+	/* tape block size, usually 512 or 1024 bytes */
 	unsigned short blk_size;
 	int user_bs_factor;
 
@@ -1580,8 +1580,8 @@
 	pc->bh = bh;
 	atomic_set(&bh->b_count, 0);
 	pc->buffer = NULL;
-	pc->buffer_size		= length * tape->blk_size;
-	pc->request_transfer	= length * tape->blk_size;
+	pc->buffer_size = length * tape->blk_size;
+	pc->request_transfer = pc->buffer_size;
 	if (pc->request_transfer == tape->stage_size)
 		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
 }
@@ -1619,8 +1619,8 @@
 	pc->b_data = bh->b_data;
 	pc->b_count = atomic_read(&bh->b_count);
 	pc->buffer = NULL;
-	pc->request_transfer	= length * tape->blk_size;
-	pc->buffer_size		= length * tape->blk_size;
+	pc->buffer_size = length * tape->blk_size;
+	pc->request_transfer = pc->buffer_size;
 	if (pc->request_transfer == tape->stage_size)
 		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
 }
