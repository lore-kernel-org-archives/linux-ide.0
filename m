From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH]: Suppress output of error messages for non-existant interfaces
Date: Sat, 15 Jan 2005 02:33:31 +0100
Message-ID: <58cb370e050114173367f21873@mail.gmail.com>
References: <41E52E84.9040609@sgi.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:36516 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262025AbVAOBeF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2005 20:34:05 -0500
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id j0F1Y2lB005554
	for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 17:34:03 -0800
Received: by wproxy.gmail.com with SMTP id 67so710445wri
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 17:33:31 -0800 (PST)
In-Reply-To: <41E52E84.9040609@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@sgi.com>
Cc: linux-ide@vger.kernel.org

On Wed, 12 Jan 2005 09:04:52 -0500, Prarit Bhargava <prarit@sgi.com> wrote:
> Suppress output of "Wait for ready failed before probe !" messages for
> non-existant interfaces.
> 
> Please see
> http://marc.theaimsgroup.com/?l=linux-ide&m=110553792013649&w=2 for
> further context on this patch.

applied, thanks
 
> --- linux-2.5.orig/drivers/ide/ide-probe.c      2005-01-12 09:00:49.000000000 -0500
> +++ linux-2.5/drivers/ide/ide-probe.c   2005-01-12 09:01:25.000000000 -0500
> @@ -742,21 +742,21 @@
>          *    their reset sequence even when they are non-selected slave
>          *    devices, thus preventing discovery of the main HD
>          *
>          *  Doing this wait-for-busy should not harm any existing configuration
>          *  (at least things won't be worse than what current code does, that
>          *  is blindly go & talk to the drive) and fix some issues like the
>          *  above.
>          *
>          *  BenH.
>          */
> -       if (wait_hwif_ready(hwif))
> +       if (wait_hwif_ready(hwif) == -EBUSY)
>                 printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
> 
>         /*
>          * Second drive should only exist if first drive was found,
>          * but a lot of cdrom drives are configured as single slaves.
>          */
>         for (unit = 0; unit < MAX_DRIVES; ++unit) {
>                 ide_drive_t *drive = &hwif->drives[unit];
>                 drive->dn = (hwif->channel ? 2 : 0) + unit;
>                 (void) probe_for_drive(drive);
>
