From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Sun, 1 May 2005 17:49:02 +0200
Message-ID: <20050501154901.GH2034@suse.de>
References: <7A8F92187EF7A249BF847F1BF4903C04010EEC08@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:34978 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261679AbVEAPtI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 May 2005 11:49:08 -0400
Content-Disposition: inline
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C04010EEC08@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart_Hayes@Dell.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Fri, Apr 29 2005, Stuart_Hayes@Dell.com wrote:
> > With more testing, I've discovered a problem with thin patch--I used
> > the "KM_USER0" window for kmap_atomic(), but that's apparently not
> > safe to use in an interrupt handler, because there are places in the
> > kernel where KM_USER0 is used without masking interrupts (see
> > include/linux/highmem.h for several examples).  This patch is
> > identical to the previous one I sent in, except it uses the KM_IRQ0
> > window, which I verified is not used anywhere without IRQs masked.   
> > 
> > This patch is against 2.6.11.7... the latest kernel on kernel.org
> > didn't yet have the previous patch I submitted.  If it would be more
> > useful, I can make this patch against an ide-scsi.c that already has
> > my previous patch applied--I wasn't sure which would be better.   

(you should inline the patch so one can comment on it...)

The IO code typically uses the BIO defines for this.

diff -purN linux-2.6.11.7/drivers/scsi/ide-scsi.c linux-2.6.11.7mods/drivers/scsi/ide-scsi.c
--- linux-2.6.11.7/drivers/scsi/ide-scsi.c	2005-04-07 14:57:46.000000000 -0400
+++ linux-2.6.11.7mods/drivers/scsi/ide-scsi.c	2005-04-29 11:46:55.000000000 -0400
@@ -143,6 +143,9 @@ static void idescsi_input_buffers (ide_d
 {
 	int count;
 	char *buf;
+#ifdef CONFIG_HIGHMEM
+	unsigned long flags;
+#endif
 
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *) pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
@@ -151,8 +154,15 @@ static void idescsi_input_buffers (ide_d
 			return;
 		}
 		count = min(pc->sg->length - pc->b_count, bcount);
-		buf = page_address(pc->sg->page) + pc->sg->offset;
+#ifdef CONFIG_HIGHMEM
+		local_irq_save(flags);
+#endif

This is just aweful, don't add tons of ifdefs. If you must
differentiate, just do something ala:

        if (PageHighMem(page)) {
                save interrupts
                buf = kmap
        } else
                buf = page_address(xxx).

and so on. But why are you still doing it this way? Did we not agree
that adding a host template no-high-mem defines was way better??

-- 
Jens Axboe

