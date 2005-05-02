From: <Stuart_Hayes@Dell.com>
Subject: RE: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Mon, 2 May 2005 10:17:38 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040AFCD0@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:48737 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261315AbVEBPRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2005 11:17:39 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axboe@suse.de
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Fri, Apr 29 2005, Stuart_Hayes@Dell.com wrote:
>>> With more testing, I've discovered a problem with thin patch--I used
>>> the "KM_USER0" window for kmap_atomic(), but that's apparently not
>>> safe to use in an interrupt handler, because there are places in the
>>> kernel where KM_USER0 is used without masking interrupts (see
>>> include/linux/highmem.h for several examples).  This patch is
>>> identical to the previous one I sent in, except it uses the KM_IRQ0
>>> window, which I verified is not used anywhere without IRQs masked.
>>> 
>>> This patch is against 2.6.11.7... the latest kernel on kernel.org
>>> didn't yet have the previous patch I submitted.  If it would be more
>>> useful, I can make this patch against an ide-scsi.c that already has
>>> my previous patch applied--I wasn't sure which would be better.
> 
> (you should inline the patch so one can comment on it...)
> 
> The IO code typically uses the BIO defines for this.
> 
> diff -purN linux-2.6.11.7/drivers/scsi/ide-scsi.c
> linux-2.6.11.7mods/drivers/scsi/ide-scsi.c ---
> linux-2.6.11.7/drivers/scsi/ide-scsi.c	2005-04-07
14:57:46.000000000
> -0400 +++ linux-2.6.11.7mods/drivers/scsi/ide-scsi.c	2005-04-29
>  	11:46:55.000000000 -0400 @@ -143,6 +143,9 @@ static void
>  	idescsi_input_buffers (ide_d  { int count; char *buf;
> +#ifdef CONFIG_HIGHMEM
> +	unsigned long flags;
> +#endif
> 
>  	while (bcount) {
>  		if (pc->sg - (struct scatterlist *)
pc->scsi_cmd->request_buffer >
>  			pc->scsi_cmd->use_sg) { @@ -151,8 +154,15 @@
static void
>  		idescsi_input_buffers (ide_d return; }
>  		count = min(pc->sg->length - pc->b_count, bcount);
> -		buf = page_address(pc->sg->page) + pc->sg->offset;
> +#ifdef CONFIG_HIGHMEM
> +		local_irq_save(flags);
> +#endif
> 
> This is just aweful, don't add tons of ifdefs. If you must
> differentiate, just do something ala: 
> 
>         if (PageHighMem(page)) {
>                 save interrupts
>                 buf = kmap
>         } else
>                 buf = page_address(xxx).
> 
> and so on. But why are you still doing it this way? Did we not agree
> that adding a host template no-high-mem defines was way better?? 

The ifdefs were at Bart's request.

The reason I went back to the kmap_atomic() fix instead of adding a  
no-high-mem flag in the host is that I couldn't get James to accept that

patch, while this one is ide-scsi only, and Bart did accept it.  And, to
be honest, I wasn't really sure why the kmap_atomic() fix was inferior.

But I'd certainly defer to your (or Bart's) judgment on those things--
you guys have a lot more experience than me with the kernel.  I am
hesitant to change the "ifdef"s to "if"s at this point, since Bart
already accepted it (previously) with the ifdefs, but I'd be more than 
happy to change it if he agrees.

Thanks for the comments,
Stuart

