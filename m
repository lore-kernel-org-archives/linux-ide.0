From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] libata: PIO via bounce buffer
Date: Fri, 29 Feb 2008 19:26:40 -0500
Message-ID: <47C8A2C0.7070005@garzik.org>
References: <20080229135106.4fcf19e3@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54269 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYCAA0n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Feb 2008 19:26:43 -0500
In-Reply-To: <20080229135106.4fcf19e3@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> First cut at the problem. Given the lack of certainty about worst case
> buffer size (1 page I suspect) this uses kmalloc. We could hang a buffer
> off the device (or I think in fact the port as we never do overlapped PIO)

> +static void ata_bounce_pio_xfer(struct ata_device *dev, struct page *page, 
> +				  unsigned int offset, int count, int do_write)
> +{
> +	struct ata_port *ap = dev->link->ap;
> +	unsigned long flags;
> +	unsigned char *zebedee;
> +	unsigned char *buf;
> +
> +	BUG_ON(offset + count > PAGE_SIZE);
> +
> +	zebedee = kmalloc(count, GFP_ATOMIC);
> +	if (likely(zebedee)) {
> +		if (do_write) {
> +			local_irq_save(flags);
> +			buf = kmap_atomic(page, KM_IRQ0);
> +			memcpy(zebedee, buf + offset, count);
> +			kunmap_atomic(buf, KM_IRQ0);
> +			local_irq_restore(flags);
> +		}
> +		/* do the actual data transfer */
> +		ap->ops->data_xfer(dev, zebedee, count, do_write);
> +		if (!do_write) {
> +			/* Read so bounce  data upwards */
> +			local_irq_save(flags);
> +			buf = kmap_atomic(page, KM_IRQ0);
> +			memcpy(buf + offset, zebedee, count);
> +			kunmap_atomic(buf, KM_IRQ0);
> +			local_irq_restore(flags);
> +		}
> +		kfree(zebedee);
> +	} else {
> +		/* Only used when we are out of buffer memory
> +		   as a last last resort */
> +		local_irq_save(flags);
> +		buf = kmap_atomic(page, KM_IRQ0);
> +		/* do the actual data transfer */
> +		ap->ops->data_xfer(dev, buf + offset, count, do_write);
> +		kunmap_atomic(buf, KM_IRQ0);
> +		local_irq_restore(flags);
> +	}


Pretty good first cut, though I think you can dramatically reduce the 
allocations:

Create a per-cpu var during libata module init, a pointer to a kmalloc'd 
structure:

	struct ata_bb {
		unsigned long len;
		u8 buffer[0];
	};

Initialize to an 8K buffer (or other size, or NULL, if you prefer).

Inside ata_bounce_pio_xfer(), get the buffer for your CPU.  If NULL or 
too small, allocate new buffer, otherwise re-use existing buffer.

This method makes the common case _not_ allocate anything, which should 
be obviously more efficient.

	Jeff


