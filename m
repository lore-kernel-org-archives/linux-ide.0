From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/32] ide-tape: remove struct idetape_mode_parameter_header_t
Date: Sun, 27 Jan 2008 16:25:07 +0100
Message-ID: <200801271625.08005.bzolnier@gmail.com>
References: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de> <1201423312-2460-5-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:9355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbYA0TcR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:17 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431369fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:13 -0800 (PST)
In-Reply-To: <1201423312-2460-5-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 27 January 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied with some changes

> ---
>  drivers/ide/ide-tape.c |   40 +++++++++++++++-------------------------
>  1 files changed, 15 insertions(+), 25 deletions(-)

[...]

> @@ -3977,7 +3968,8 @@ static void idetape_get_mode_sense_results (ide_drive_t *drive)
>  	printk(KERN_INFO "ide-tape: Supports 32768 bytes block size / Restricted byte count for PIO transfers - %s\n",capabilities->blk32768 ? "Yes":"No");
>  	printk(KERN_INFO "ide-tape: Maximum supported speed in KBps - %d\n",capabilities->max_speed);
>  	printk(KERN_INFO "ide-tape: Continuous transfer limits in blocks - %d\n",capabilities->ctl);
> -	printk(KERN_INFO "ide-tape: Current speed in KBps - %d\n",capabilities->speed);	
> +	printk(KERN_INFO "ide-tape: Current speed in KBps - %d\n",
> +			capabilities->speed);
>  	printk(KERN_INFO "ide-tape: Buffer size - %d\n",capabilities->buffer_size*512);
>  #endif /* IDETAPE_DEBUG_INFO */
>  }

this code goes away in patch #5 so I dropped this chunk

[...]

> @@ -4003,10 +3994,9 @@ static void idetape_get_blocksize_from_block_descriptor(ide_drive_t *drive)
>  		}
>  		return;
>  	}
> -	header = (idetape_mode_parameter_header_t *) pc.buffer;
> -	block_descrp = (idetape_parameter_block_descriptor_t *) (pc.buffer + sizeof(idetape_mode_parameter_header_t));
> +	block_descrp = (idetape_parameter_block_descriptor_t *) pc.buffer + 4;

these brackets _are_ needed

[ block_descrp is of 'idetape_parameter_block_descriptor_t *' type so without
  brackets +4 would mean + 4 * sizeof(idetape_parameter_block_descriptor_t) ]
