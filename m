From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE	detection
Date: Sun, 19 Apr 2009 06:39:42 +0900
Message-ID: <49EA489E.6080809@gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com> <49E85B6F.7080603@kernel.org> <49E85CA7.2060801@gmail.com> <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com> <49E8F0A7.5040208@gmail.com> <20090418194839.GA2848@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:36379 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760292AbZDRVju (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Apr 2009 17:39:50 -0400
Received: by ti-out-0910.google.com with SMTP id 11so916266tim.23
        for <linux-ide@vger.kernel.org>; Sat, 18 Apr 2009 14:39:48 -0700 (PDT)
In-Reply-To: <20090418194839.GA2848@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello, Borislav.

Borislav Petkov wrote:
> sorry for I wasn't that clear. We need the drive->pc ptr valid in order to
> retry a packet command couple lines below in the ->do_request callback:
> 
>         /* Retry a failed packet command */
>         if (drive->failed_pc && drive->pc->c[0] == REQUEST_SENSE) {
>                 pc = drive->failed_pc;
>                 goto out;
>         }

No, that's checking whether the _previous_ command was REQUEST_SENSE
which is guaranteed to be set if drive->failed_pc is not NULL.
drive->pc is set to the current command at the start of
ide_tape_issue_pc().

> @@ -753,6 +753,9 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
>  	struct ide_cmd cmd;
>  	u8 stat;
>  
> +	if (rq->cmd_type == REQ_TYPE_SPECIAL)
> +		drive->pc = pc = (struct ide_atapi_pc *) rq->buffer;
> +
>  	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu,"
>  			" current_nr_sectors: %u\n",
>  			(unsigned long long)rq->sector, rq->nr_sectors,
> @@ -769,7 +772,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
>  	}
>  
>  	/* Retry a failed packet command */
> -	if (drive->failed_pc && drive->pc->c[0] == REQUEST_SENSE) {
> +	if (drive->failed_pc && pc->c[0] == REQUEST_SENSE) {
>  		pc = drive->failed_pc;

So, if you do this, the retry after REQUEST_SENSE logic will never
trigger.

Thanks.

-- 
tejun
