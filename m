From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 06/29] ide: IDE_CONTROL_REG cleanup
Date: Thu, 3 Feb 2005 01:23:24 +0100
Message-ID: <58cb370e050202162334828b55@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024830.GG621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.202]:2025 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262738AbVBCAX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 19:23:26 -0500
Received: by wproxy.gmail.com with SMTP id 67so166126wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 16:23:26 -0800 (PST)
In-Reply-To: <20050202024830.GG621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:48:30 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 06_ide_start_request_IDE_CONTROL_REG.patch
> >
> >       Replaced HWIF(drive)->io_ports[IDE_CONTROL_OFFSET] with
> >       equivalent IDE_CONTROL_REG in ide-io.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>
> 
> Index: linux-ide-export/drivers/ide/ide-io.c
> ===================================================================
> --- linux-ide-export.orig/drivers/ide/ide-io.c  2005-02-02 10:27:15.996184821 +0900
> +++ linux-ide-export/drivers/ide/ide-io.c       2005-02-02 10:28:03.340503581 +0900
> @@ -884,7 +884,7 @@ static ide_startstop_t start_request (id
>                 if (rc)
>                         printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
>                 SELECT_DRIVE(drive);
> -               HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
> +               HWIF(drive)->OUTB(8, IDE_CONTROL_REG);
>                 rc = ide_wait_not_busy(HWIF(drive), 10000);
>                 if (rc)
>                         printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);

IDE_CONTROL_REG macro and co. are obfuscations and should die...
