From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] ide-tape: improve buffer pages freeing strategy
Date: Thu, 3 Apr 2008 23:33:23 +0200
Message-ID: <200804032333.23513.bzolnier@gmail.com>
References: <1206812769-10065-1-git-send-email-petkovbb@gmail.com> <1206812769-10065-5-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:13914 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760853AbYDCVuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 17:50:18 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4513185fkr.5
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2008 14:50:15 -0700 (PDT)
In-Reply-To: <1206812769-10065-5-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Saturday 29 March 2008, Borislav Petkov wrote:
> Instead of freeing pages one by one, free them 2^order-wise. Also, mv
> __idetape_kfree_stage() to ide_tape_kfree_buffer().
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   37 +++++++++++++++++++------------------
>  1 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index cf4351c..dcaefef 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -583,20 +583,21 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
>  	}
>  }
>  
> -/* Free a stage along with its related buffers completely. */
> -static void __idetape_kfree_stage(idetape_stage_t *stage)
> +/* Free data buffers completely. */
> +static void ide_tape_kfree_buffer(idetape_stage_t *stage)
>  {
>  	struct idetape_bh *prev_bh, *bh = stage->bh;
> -	int size;
> -
> -	while (bh != NULL) {
> -		if (bh->b_data != NULL) {
> -			size = (int) bh->b_size;
> -			while (size > 0) {
> -				free_page((unsigned long) bh->b_data);
> -				size -= PAGE_SIZE;
> -				bh->b_data += PAGE_SIZE;
> -			}
> +
> +	while (bh) {
> +		u32 size = bh->b_size;
> +
> +		while (size) {
> +			unsigned int order = fls(size >> PAGE_SHIFT)-1;
> +
> +			if (bh->b_data)
> +				free_pages((unsigned long)bh->b_data, order);
> +
> +			size &= (order-1);
>  		}

Hmmm, don't we also need to update bh->b_data?

[ I added the change below to the merged patch version for now: ]

@@ -598,6 +598,7 @@
 				free_pages((unsigned long)bh->b_data, order);
 
 			size &= (order-1);
+			bh->b_data += (1 << order) * PAGE_SIZE;
 		}
 		prev_bh = bh;
 		bh = bh->b_reqnext;
