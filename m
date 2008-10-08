From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [patch][repost] ide-tape build fix
Date: Wed, 8 Oct 2008 08:33:52 +0200
Message-ID: <20081008063352.GA13530@gollum.tnic>
References: <20080921185138.GA16310@localhost> <48D79ABD.8060805@ru.mvista.com> <9ea470500809220656j6dfcf4c9q7a5a4185481ec994@mail.gmail.com> <20080922204129.GA3495@localhost> <48D80949.4080901@ru.mvista.com> <20080923074845.GB5656@gollum.tnic> <20080923165914.GA7803@localhost> <9ea470500809231011p5ea37fc4u71eeeddf6ccec45a@mail.gmail.com> <20080923212018.GA3348@localhost> <20081007182615.GA2400@localhost>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:6026 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbYJHGeB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 02:34:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3161416fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 07 Oct 2008 23:33:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081007182615.GA2400@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Gadi Oxman <gadio@netvision.net.il>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 07, 2008 at 08:26:15PM +0200, Mark de Wever wrote:
> I never got a reaction on this patch, but please apply it.
> 
> In order to compile the kernel with IDETAPE_DEBUG_LOG enabled I had to
> apply the following build fix.

Bugger, I should be getting at least warnings when compiling this but I don't.
This is because I don't have CONFIG_LBD enabled. However, the %ld and %d
format specifiers are also not entirely correct but gcc doesn't warn about them
- I guess it checks only size but not signedness...

> Signed-off-by: Mark de Wever <koraq@xs4all.nl>
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 3833189..7258eca 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -978,9 +978,10 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
>  	struct request *postponed_rq = tape->postponed_rq;
>  	u8 stat;
>  
> -	debug_log(DBG_SENSE, "sector: %ld, nr_sectors: %ld,"
> +	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %ld,"

the other format specifiers should be rq->nr_sectors: %lu, rq->current_nr_sectors: %u.

>  			" current_nr_sectors: %d\n",
> -			rq->sector, rq->nr_sectors, rq->current_nr_sectors);
> +			(unsigned long long)rq->sector, rq->nr_sectors, 
> +			rq->current_nr_sectors);
>  
>  	if (!blk_special_request(rq)) {
>  		/* We do not support buffer cache originated requests. */
> 

Would you like to redo your patch and add a proper comment ontop?

Thanks.

-- 
Regards/Gruss,
    Boris.
