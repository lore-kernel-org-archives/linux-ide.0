From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH] libata: PIO bounce copies to avoid long IRQ off runs
Date: Tue, 29 Apr 2008 08:51:08 -0700
Message-ID: <da824cf30804290851g117b97e4u6952f64d02a09f02@mail.gmail.com>
References: <20080429144754.7d2952c8@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:45370 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760436AbYD2PvN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 11:51:13 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id m3TFpBt8021842
	for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 16:51:11 +0100
Received: from rn-out-0910.google.com (rnbs28.prod.google.com [10.38.95.28])
	by zps78.corp.google.com with ESMTP id m3TFp95p028276
	for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 08:51:10 -0700
Received: by rn-out-0910.google.com with SMTP id s28so73219rnb.13
        for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 08:51:09 -0700 (PDT)
In-Reply-To: <20080429144754.7d2952c8@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Tue, Apr 29, 2008 at 6:47 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Right now with PIO transfers we can jam the box up horribly as lock IRQs
>  off when the transfer is from high memory. We still have other things we
>  need to fix in this area to really make a difference but this is the
>  buffering side of the fix (the state machine enable/disable irq stuff is
>  also needed)
>
>  Currently uses kmalloc - which seems to work best, but trivial to
>  allocate at init time if wanted
>
>  Signed-off-by: Alan Cox <alan@redhat.com>
>
>  diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-mm1/drivers/ata/libata-sff.c linux-2.6.25-mm1/drivers/ata/libata-sff.c
>  --- linux.vanilla-2.6.25-mm1/drivers/ata/libata-sff.c   2008-04-28 11:36:48.000000000 +0100
>  +++ linux-2.6.25-mm1/drivers/ata/libata-sff.c   2008-04-28 11:42:05.000000000 +0100
>  @@ -665,6 +665,62 @@
>   }
>
>   /**
>  + *     ata_bounce_pio_xfer     -       Transfer a block by PIO from high
>  + *     @dev: target device
>  + *     @page: highmem page
>  + *     @offset: offset in page
>  + *     @count: bytes to transfer
>  + *     @do_write: writing if set, reading if not
>  + *
>  + *     Transfer a page of high memory via PIO. Whenever possible use a bounce
>  + *     buffer to avoid transfers occuring with local IRQ disable
>  + */
>  +
>  +static unsigned int ata_bounce_pio_xfer(struct ata_device *dev, struct page *page,
>  +                                 unsigned int offset, int count, int rw)
>  +{
>  +       struct ata_port *ap = dev->link->ap;
>  +       unsigned long flags;
>  +       unsigned char *zebedee;
>  +       unsigned char *buf;
>  +       unsigned int consumed;
>  +
>  +       BUG_ON(offset + count > PAGE_SIZE);
>  +
>  +       zebedee = kmalloc(count, GFP_ATOMIC);
>  +       if (likely(zebedee)) {
>  +               if (rw == WRITE) {
>  +                       local_irq_save(flags);
>  +                       buf = kmap_atomic(page, KM_IRQ0);
>  +                       memcpy(zebedee, buf + offset, count);
>  +                       kunmap_atomic(buf, KM_IRQ0);
>  +                       local_irq_restore(flags);
>  +               }
>  +               /* do the actual data transfer */
>  +               consumed = ap->ops->sff_data_xfer(dev, zebedee, count, rw);
>  +               if (rw == READ) {
>  +                       /* Read so bounce  data upwards */
>  +                       local_irq_save(flags);
>  +                       buf = kmap_atomic(page, KM_IRQ0);
>  +                       memcpy(buf + offset, zebedee, count);
>  +                       kunmap_atomic(buf, KM_IRQ0);
>  +                       local_irq_restore(flags);
>  +               }
>  +               kfree(zebedee);
>  +       } else {
>  +               /* Only used when we are out of buffer memory
>  +                  as a last last resort */
>  +               local_irq_save(flags);
>  +               buf = kmap_atomic(page, KM_IRQ0);
>  +               /* do the actual data transfer */
>  +               consumed = ap->ops->sff_data_xfer(dev, buf + offset, count, rw);
>  +               kunmap_atomic(buf, KM_IRQ0);
>  +               local_irq_restore(flags);
>  +       }
>  +       return consumed;
>  +}
>  +
>  +/**
>   *     ata_pio_sector - Transfer a sector of data.
>   *     @qc: Command on going
>   *
>  @@ -675,7 +731,7 @@
>   */
>   static void ata_pio_sector(struct ata_queued_cmd *qc)
>   {
>  -       int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
>  +       int do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? WRITE : READ;
>         struct ata_port *ap = qc->ap;
>         struct page *page;
>         unsigned int offset;
>  @@ -693,19 +749,9 @@
>
>         DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
>
>  -       if (PageHighMem(page)) {
>  -               unsigned long flags;
>  -
>  -               /* FIXME: use a bounce buffer */
>  -               local_irq_save(flags);
>  -               buf = kmap_atomic(page, KM_IRQ0);
>  -
>  -               /* do the actual data transfer */
>  -               ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
>  -                                      do_write);
>  -
>  -               kunmap_atomic(buf, KM_IRQ0);
>  -               local_irq_restore(flags);
>  +       if (PageHighMem(page) || 1 /* TEST FIXME */) {

Did you want the "|| 1" code committed as well?

thanks,
grant

>  +               ata_bounce_pio_xfer(qc->dev, page, offset, qc->sect_size,
>  +                                                               do_write);
>         } else {
>                 buf = page_address(page);
>                 ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
>  @@ -830,19 +876,9 @@
>
>         DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
>
>  -       if (PageHighMem(page)) {
>  -               unsigned long flags;
>  -
>  -               /* FIXME: use bounce buffer */
>  -               local_irq_save(flags);
>  -               buf = kmap_atomic(page, KM_IRQ0);
>  -
>  -               /* do the actual data transfer */
>  -               consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
>  -
>  -               kunmap_atomic(buf, KM_IRQ0);
>  -               local_irq_restore(flags);
>  -       } else {
>  +       if (PageHighMem(page))
>  +               consumed = ata_bounce_pio_xfer(qc->dev, page, offset, count, rw);
>  +       else {
>                 buf = page_address(page);
>                 consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
>         }
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
