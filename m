From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Reinitilize idedisk_capacity for HPA drives on resume
Date: Mon, 21 Aug 2006 20:33:31 +0400
Message-ID: <44E9E05B.4030502@ru.mvista.com>
References: <44E9038D.4040109@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60136 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S964967AbWHUQcZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Aug 2006 12:32:25 -0400
In-Reply-To: <44E9038D.4040109@PicturesInMotion.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Lee Trager wrote:

> This patch fixes a problem that when a computer with HPA on it's hard
> drive comes out of sleep mode it needs the disks capacity reinitialized.

> This is my first patch to the Linux kernel so if I did anything wrong
> please be gentle ;)

    Your mailer spoils tabs, so either attach your patch or use the different
mailer.

[...]

> diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide.c
> linux-2.6.18-rc4/drivers/ide/ide.c
> --- linux-2.6.18-rc4-old/drivers/ide/ide.c    2006-08-19
> 03:49:03.000000000 -0400
> +++ linux-2.6.18-rc4/drivers/ide/ide.c    2006-08-20 19:12:38.000000000
> -0400
> @@ -1232,6 +1232,7 @@
>      struct request rq;
>      struct request_pm_state rqpm;
>      ide_task_t args;
> +    int ide_cmd;
>  
>      memset(&rq, 0, sizeof(rq));
>      memset(&rqpm, 0, sizeof(rqpm));
> @@ -1242,7 +1243,15 @@
>      rqpm.pm_step = ide_pm_state_start_resume;
>      rqpm.pm_state = PM_EVENT_ON;
>  
> -    return ide_do_drive_cmd(drive, &rq, ide_head_wait);
> +    ide_cmd = ide_do_drive_cmd(drive, &rq, ide_head_wait);
> +
> +    /* check to see if this is a hard drive
> +     * if it is then checkhpa needs to be
> +     * disabled */
> +    if(drive->media == ide_disk && idedisk_supports_hpa(drive->id))
> +        init_idedisk_capacity(drive);
> +
> +    return ide_cmd;
>  }

    Hm, shouldn't this be handled as a separate resume process step?

MBR, Sergei

