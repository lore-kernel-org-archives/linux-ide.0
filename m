From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH]: [RFC] Fix error handlnig in hwif-init and sgiioc4 driver
Date: Thu, 3 Feb 2005 15:46:54 +0100
Message-ID: <58cb370e050203064648e81449@mail.gmail.com>
References: <41F79A30.4040900@sgi.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:62705 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263450AbVBCOqz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 09:46:55 -0500
Received: by wproxy.gmail.com with SMTP id 67so264069wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 06:46:54 -0800 (PST)
In-Reply-To: <41F79A30.4040900@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@sgi.com>
Cc: linux-ide@vger.kernel.org

On Wed, 26 Jan 2005 08:25:04 -0500, Prarit Bhargava <prarit@sgi.com> wrote:
> I didn't see any ACKs on this so I'm resubmitting....

sorry for the delay

> I discovered an issue where a hwif_init failure lead to /proc/ide files
> being created for devices that failed probes.  This resulted in

create_proc_ide_interfaces() doesn't create /proc/ide files for
hwif->present == 0 interfaces but hwif_init() sets hwif->present
to 0 too late.  Also this hwif->present games are silly and should
be removed after your patch is applied and locking is verified.

> The second part of the fix is to the core IDE layer and to the SGI IOC4
> IDE driver which need to handle errors properly from failed hwif
> initializations.  This patch is attached for review.

please remember about Signed-off-by:

> ===== drivers/ide/ide-probe.c 1.90 vs edited =====
> --- 1.90/drivers/ide/ide-probe.c        2004-12-10 14:12:14 -05:00
> +++ edited/drivers/ide/ide-probe.c      2005-01-14 08:18:43 -05:00
> @@ -841,7 +841,10 @@
>         if (fixup)
>                 fixup(hwif);
> 
> -       hwif_init(hwif);
> +       if (!hwif_init(hwif)) {
> +               printk("%s: Failed to initialize IDE interface\n", hwif->name);
> +               return -1;
> +       }

Could you fix hwif_init() to return meaningful error codes
and return error from hwif_init() instead of '-1'?

>         if (hwif->present) {
>                 u16 unit = 0;
> ===== drivers/ide/pci/sgiioc4.c 1.22 vs edited =====
> --- 1.22/drivers/ide/pci/sgiioc4.c      2005-01-06 20:35:35 -05:00
> +++ edited/drivers/ide/pci/sgiioc4.c    2005-01-14 08:18:56 -05:00
> @@ -669,7 +669,10 @@
>                 printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
>                        hwif->name, d->name);
> 
> -       probe_hwif_init(hwif);
> +       if (probe_hwif_init(hwif)) {
> +               printk(KERN_INFO "%s: initialization failed\n", hwif->name);

redundant, error message is printed in probe_hwif_init()

> +               return -EIO;

please fix probe_hwif_init() to return error codes

> +       }
> 
>         /* Create /proc/ide entries */
>         create_proc_ide_interfaces();

I removed redundant printk and applied the patch
