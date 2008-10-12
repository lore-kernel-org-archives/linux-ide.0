From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] ide: replace the global ide_lock spinlock by per-hwgroup spinlocks
Date: Sun, 12 Oct 2008 20:01:26 +0200
Message-ID: <87ej2ld761.fsf@denkblock.local>
References: <200810102126.14475.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:57164 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586AbYJLSCM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Oct 2008 14:02:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Vaibhav V. Nivargi" <vaibhav.nivargi@gmail.com>, "Alok N. Kataria" <alokk@calsoftinc.com>, Ravikiran Thirumalai <kiran@scalex86.org>, Shai Fultheim <shai@scalex86.org>

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: replace the global ide_lock spinlock by per-hwgroup spinlocks
>
> Now that (almost) all host drivers have been fixed not to abuse ide_lock
> and core code usage of ide_lock has been sanitized we may safely replace
> ide_lock by per-hwgroup locks.
>
> This patch is partially based on earlier patch from Ravikiran G Thirumalai.
>
> While at it:
> - don't use deprecated HWIF() and HWGROUP() macros
> - update locking documentation in ide.h
>
> Cc: Vaibhav V. Nivargi <vaibhav.nivargi@gmail.com>
> Cc: Alok N. Kataria <alokk@calsoftinc.com>
> Cc: Ravikiran Thirumalai <kiran@scalex86.org>
> Cc: Shai Fultheim <shai@scalex86.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> this is against 2.6.27 + pata tree + pre-patchset posted on Wednesday
> (http://lkml.org/lkml/2008/10/8/221)

I've only had a casual look at this patch, but there is one thing:

[...]
> Index: b/drivers/ide/ide-probe.c
> ===================================================================
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
[...]
> @@ -1091,11 +1092,11 @@ static int init_irq (ide_hwif_t *hwif)
>  		 * linked list, the first entry is the hwif that owns
>  		 * hwgroup->handler - do not change that.
>  		 */
> -		spin_lock_irq(&ide_lock);
> +		spin_lock_irq(&hwgroup->lock);
>  		hwif->next = hwgroup->hwif->next;
>  		hwgroup->hwif->next = hwif;
>  		BUG_ON(hwif->next == hwif);
> -		spin_unlock_irq(&ide_lock);
> +		spin_unlock_irq(&hwgroup->lock);
>  	} else {
>  		hwgroup = kmalloc_node(sizeof(*hwgroup), GFP_KERNEL|__GFP_ZERO,
>  				       hwif_to_node(hwif));

Something like

	spin_lock_init(&hwgroup->lock);

should go into this else clause too.

Regards,

Elias
