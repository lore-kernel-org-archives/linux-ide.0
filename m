From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 04/09] ide: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE
Date: Sun, 6 Feb 2005 20:08:53 +0100
Message-ID: <58cb370e05020611081a604a45@mail.gmail.com>
References: <42049F20.7020706@home-tj.org>
	 <20050205102843.93952132701@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.205]:57838 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261286AbVBFTI4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2005 14:08:56 -0500
Received: by wproxy.gmail.com with SMTP id 67so748990wri
        for <linux-ide@vger.kernel.org>; Sun, 06 Feb 2005 11:08:53 -0800 (PST)
In-Reply-To: <20050205102843.93952132701@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I forgot about this one...

> @@ -55,22 +55,19 @@
>  #include <asm/io.h>
>  #include <asm/bitops.h>
> 
> -static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
> +void ide_init_flush_task(ide_drive_t *drive, ide_task_t *args)
>  {
> -       char *buf = rq->cmd;
> -
> -       /*
> -        * reuse cdb space for ata command
> -        */
> -       memset(buf, 0, sizeof(rq->cmd));
> -
> -       rq->flags = REQ_DRIVE_TASK | REQ_STARTED;
> -       rq->buffer = buf;
> -       rq->buffer[0] = WIN_FLUSH_CACHE;
> +       memset(args, 0, sizeof(*args));
> 
>         if (ide_id_has_flush_cache_ext(drive->id) &&
>             (drive->capacity64 >= (1UL << 28)))
> -               rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
> +               args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
> +       else
> +               args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
> +
> +       args->command_type = IDE_DRIVE_TASK_NO_DATA;
> +       args->data_phase = TASKFILE_NO_DATA;
> +       args->handler = task_no_data_intr;
>  }

Isn't EXPORT_SYMBOL_{GPL} needed for ide_init_flush_task()?
