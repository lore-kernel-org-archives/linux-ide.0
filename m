From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: ide-tape.c sparse annotations and unaligned access removal
Date: Wed, 16 Jul 2008 19:43:53 +0200
Message-ID: <200807161943.54033.bzolnier@gmail.com>
References: <1216152845.6610.18.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:10356 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbYGPTNL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2008 15:13:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2748680ywe.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Jul 2008 12:13:10 -0700 (PDT)
In-Reply-To: <1216152845.6610.18.camel@brick>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>

On Tuesday 15 July 2008, Harvey Harrison wrote:
> If this is actually unaligned the access of speed/max_speed above
> is already broken and needs a get_unaligned.  Otherwise it is
> aligned and they can be removed.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
> Bart, if this truly should be unaligned, let me know and I'll send you
> a patch fixing the speed/maxspeed issue.

I applied the patch as it is for now as I don't see a reason to
use unaligned access there but I could have forgotten some details
(added Borislav to cc:).

I've also noticed that there are some put_unaligned()-s left in
idetape_get_mode_sense_results(), is this intended?

>  drivers/ide/ide-tape.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 34fc925..40b09b2 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -655,10 +655,10 @@ static void ide_tape_callback(ide_drive_t *drive)
>  			uptodate = 0;
>  		} else {
>  			debug_log(DBG_SENSE, "Block Location - %u\n",
> -					be32_to_cpu(*(u32 *)&readpos[4]));
> +					be32_to_cpup((__be32 *)&readpos[4]));
>  
>  			tape->partition = readpos[1];
> -			tape->first_frame = be32_to_cpu(*(u32 *)&readpos[4]);
> +			tape->first_frame = be32_to_cpup((__be32 *)&readpos[4]);
>  			set_bit(IDE_DFLAG_ADDRESS_VALID, &drive->dev_flags);
>  		}
>  	}
> @@ -2381,13 +2381,13 @@ static void idetape_get_mode_sense_results(ide_drive_t *drive)
>  	caps = pc.buf + 4 + pc.buf[3];
>  
>  	/* convert to host order and save for later use */
> -	speed = be16_to_cpu(*(u16 *)&caps[14]);
> -	max_speed = be16_to_cpu(*(u16 *)&caps[8]);
> +	speed = be16_to_cpup((__be16 *)&caps[14]);
> +	max_speed = be16_to_cpup((__be16 *)&caps[8]);
>  
> -	put_unaligned(max_speed, (u16 *)&caps[8]);
> -	put_unaligned(be16_to_cpu(*(u16 *)&caps[12]), (u16 *)&caps[12]);
> -	put_unaligned(speed, (u16 *)&caps[14]);
> -	put_unaligned(be16_to_cpu(*(u16 *)&caps[16]), (u16 *)&caps[16]);
> +	*(u16 *)&caps[8] = max_speed;
> +	*(u16 *)&caps[12] = be16_to_cpup((__be16 *)&caps[12]);
> +	*(u16 *)&caps[14] = speed;
> +	*(u16 *)&caps[16] = be16_to_cpup((__be16 *)&caps[16]);
>  
>  	if (!speed) {
>  		printk(KERN_INFO "ide-tape: %s: invalid tape speed "
