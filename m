From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: fix memory leak when flush command is issued
Date: Fri, 17 Jul 2009 16:05:54 +0200
Message-ID: <200907171605.55502.bzolnier@gmail.com>
References: <1247761972.8418.46.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53630 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934659AbZGQN7b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jul 2009 09:59:31 -0400
Received: by fxm18 with SMTP id 18so754296fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 17 Jul 2009 06:59:30 -0700 (PDT)
In-Reply-To: <1247761972.8418.46.camel@sakura.staff.proxad.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mbizon@freebox.fr
Cc: davem <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thursday 16 July 2009 18:32:52 Maxime Bizon wrote:
> 
> Hi David, Bartlomiej
> 
> I'm using ide on 2.6.30.1 with xfs filesystem. I noticed a kernel memory
> leak after writing lots of data, the kmalloc-96 slab cache keeps
> growing. It seems the struct ide_cmd kmalloced by idedisk_prepare_flush
> is never kfreed.
> 
> Commit a09485df9cda49fbde2766c86eb18a9cae585162 and
> f505d49ffd25ed062e76ffd17568d3937fcd338c cause this regression, cmd->rq
> must now be set for ide_complete_cmd to honor the IDE_TFLAG_DYN flag.
> 
> Candidate for stable I think, thanks !
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanks for fixing this!

> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> index 6951811..7f87801 100644
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -455,6 +455,7 @@ static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
>  
>  	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
>  	rq->special = cmd;
> +	cmd->rq = rq;
>  }
>  
>  ide_devset_get(multcount, mult_count);
