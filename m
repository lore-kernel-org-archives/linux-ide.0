From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE 	detection
Date: Fri, 17 Apr 2009 19:35:27 +0900
Message-ID: <49E85B6F.7080603@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>	 <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42878 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660AbZDQKfn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 06:35:43 -0400
In-Reply-To: <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello,

Borislav Petkov wrote:
> I hit that too when debugging an ide-tape problem a user has
> (http://bugzilla.kernel.org/show_bug.cgi?id=12874). However, this is not the
> proper solution since, currently, ide-tape stuffs all packet commands in
> rq->buffer or rq->special now after your changes. It has to get them out of
> there in the ->do_request callback and set drive->pc to point to the current
> packet command in flight through the IRQ handler. And since ide_tape_issue_pc()
> is called by the ->do_request callback we should have the drive->pc always
> valid.
> 
> How about something like that instead:
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 4e6181c..171dbcd 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -792,6 +792,9 @@ static ide_startstop_t
> idetape_do_request(ide_drive_t *drive,
>  	struct request *postponed_rq = tape->postponed_rq;
>  	u8 stat;
> 
> +	if (rq->cmd_type == REQ_TYPE_SPECIAL)
> +		drive->pc = (struct ide_atapi_pc *) rq->buffer;
> +
>  	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu,"
>  			" current_nr_sectors: %u\n",
>  			(unsigned long long)rq->sector, rq->nr_sectors,

I don't really care one way or the other but the error condition
itself looked somewhat pointless to me, so I just killed it.  Is the
error messasge really worth guaranteeing drive->pc can be accessed
after completion?  That's a nasty and fragile guarantee.  If such
check is really necessary, the proper way to do it would be recording
whether the last command was request sense in some persistent data
structure not trying to access a data structure which the code doesn't
own anymore.

Thanks.

-- 
tejun
