From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide: Remove ide_spin_wait_hwgroup() and use special requests instead
Date: Wed, 13 Aug 2008 00:41:07 +0200
Message-ID: <200808130041.07424.bzolnier@gmail.com>
References: <87iqu73128.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:47973 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbYHLWnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 18:43:53 -0400
Received: by mu-out-0910.google.com with SMTP id w8so4666461mue.1
        for <linux-ide@vger.kernel.org>; Tue, 12 Aug 2008 15:43:51 -0700 (PDT)
In-Reply-To: <87iqu73128.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org


Hi,

On Monday 11 August 2008, Elias Oltmanns wrote:
> Hi bart,
> 
> as you suggested, I've prepared a patch to get rid of
> ide_spin_wait_hwgroup(). Unfortunately, it turned out to be more
> intrusive and bigger than I'd hoped it would, so if you have any
> suggestions how to do this more elegantly, please let me know.

Thank you for working on this.

Patch looks good to me (there is a couple of minor things to address
but nothing serious).  I also really like how it adds struct ide_devset
which is shared by struct ide_{ioctl,proc}_devset.

> On a different matter, I've encountered several places where requests
> are being allocated with __GFP_WAIT for no obvious reason. Wouldn't it
> be more suitable to allocate them with GFP_KERNEL and fail with -ENOMEM
> in case of an error? Or is there some policy I'm not aware of?

Without more details it is hard to tell, maybe it has something to do
with GFP_KERNEL also using __GFP_IO?

> Regards,
> 
> Elias
> 
> From: Elias Oltmanns <eo@nebensachen.de>
> Subject: ide: Remove ide_spin_wait_hwgroup() and use special requests instead
> 
> Use a special request for serialisation purposes and get rid of the
> awkward ide_spin_wait_hwgroup().

This is really a 'compact' patch description for a rather large patch.

Especially given that there are some by-the-way improvements worth
bragging about (i.e. 'shared' struct ide_devset). :)

[...]

> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index ec6664b..5451e50 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -716,9 +716,63 @@ static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
>   	return ide_stopped;
>  }
>  
> +typedef struct {
> +	u8 opcode;	/* always == REQ_DEVSET_EXEC */
> +	int arg;
> +} ide_devset_cdb_t;

Generally we don't want new typedefs in kernel
and here we shouldn't even need new struct.

> +#define DEVSET_CDB_LEN (sizeof(ide_devset_cdb_t))
> +
> +int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
> +		       int arg)
> +{
> +	struct request_queue *q = drive->queue;
> +	struct request *rq;
> +	ide_devset_cdb_t *ds;
> +	int ret = 0;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +	if (!(setting->flags & DS_SYNC))
> +		return setting->set(drive, arg);
> +
> +	rq = blk_get_request(q, READ, GFP_KERNEL);
> +	if (!rq)
> +		return -ENOMEM;
> +
> +	rq->cmd_type = REQ_TYPE_SPECIAL;
> +	BUILD_BUG_ON(DEVSET_CDB_LEN > BLK_MAX_CDB);

BLK_MAX_CDB would never be < 16 so this seems overcautious

> +	rq->cmd_len = DEVSET_CDB_LEN;
> +	ds = (ide_devset_cdb_t *)rq->cmd;
> +	ds->opcode = REQ_DEVSET_EXEC;
> +	ds->arg = arg;

How's about just doing:

	rq->cmd[0] = REQ_DEVSET_EXEC;
	(int *)rq->cmd[1] = arg;

[...]

> @@ -22,9 +22,9 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
>  	int err = -EOPNOTSUPP;
>  
>  	for (; s->get_ioctl; s++) {
> -		if (s->get && s->get_ioctl == cmd)
> +		if (s->get_ioctl == cmd)
>  			goto read_val;

What if 'cmd' == -1?

[ That was the reason for s->get / s->set checks. ]

> @@ -42,13 +42,9 @@ set_val:
>  	if (bdev != bdev->bd_contains)
>  		err = -EINVAL;
>  	else {
> -		if (!capable(CAP_SYS_ADMIN))
> -			err = -EACCES;

I would prefer that CAP_SYS_ADMIN check here and in ide_write_setting()
to stay in their places and be done before checking other things (so error
codes returned to user-space remain unchanged).

There is also a few CodingStyle errors/warnings catched by checkpatch.pl
(some look bogus but others seem legitimate).

Otherwise it looks all good.

Thanks,
Bart
