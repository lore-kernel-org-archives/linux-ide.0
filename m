From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Wed, 6 Jul 2005 16:05:15 +0200
Message-ID: <58cb370e050706070512c93ee1@mail.gmail.com>
References: <20050706133052.GF21330@wotan.suse.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.195]:22622 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262301AbVGFOFR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jul 2005 10:05:17 -0400
Received: by nproxy.gmail.com with SMTP id o25so283155nfa
        for <linux-ide@vger.kernel.org>; Wed, 06 Jul 2005 07:05:15 -0700 (PDT)
In-Reply-To: <20050706133052.GF21330@wotan.suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, christoph@lameter.com

On 7/6/05, Andi Kleen <ak@suse.de> wrote:
> 
> Without this patch a dual Xeon EM64T machine would oops on boot
> because the hwif pointer here was NULL. I also added a check for
> pci_dev because it's doubtful that all IDE devices have pci_devs.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> 
> Index: linux/drivers/ide/ide-probe.c
> ===================================================================
> --- linux.orig/drivers/ide/ide-probe.c
> +++ linux/drivers/ide/ide-probe.c
> @@ -978,8 +978,10 @@ static int ide_init_queue(ide_drive_t *d
>          *      do not.
>          */
> 
> -       q = blk_init_queue_node(do_ide_request, &ide_lock,
> -                               pcibus_to_node(drive->hwif->pci_dev->bus));
> +       int node = 0; /* Should be -1 */
> +       if (drive->hwif && drive->hwif->pci_dev)
> +               node = pcibus_to_node(drive->hwif->pci_dev->bus);
> +       q = blk_init_queue_node(do_ide_request, &ide_lock, node);
>         if (!q)
>                 return 1;

drive->hwif check is redundant, please remove it

> @@ -1096,8 +1098,13 @@ static int init_irq (ide_hwif_t *hwif)
>                 hwgroup->hwif->next = hwif;
>                 spin_unlock_irq(&ide_lock);
>         } else {
> -               hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
> -                       pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
> +               int node = 0;
> +               if (hwif->drives[0].hwif) {
> +                       struct pci_dev *pdev = hwif->drives[0].hwif->pci_dev;
> +                       if (pdev)
> +                               node = pcibus_to_node(pdev->bus);
> +               }

ditto, moreover hwif->drives[0].hwif == hwif

> +               hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,node);
>                 if (!hwgroup)
>                         goto out_up;
