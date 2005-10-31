From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ide-scsi highmem cleanup
Date: Sun, 30 Oct 2005 20:00:33 -0800
Message-ID: <20051030200033.31a34b5c.akpm@osdl.org>
References: <200510310302.j9V32hO4009277@hera.kernel.org>
	<43659404.6050605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:60826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbVJaEB0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2005 23:01:26 -0500
In-Reply-To: <43659404.6050605@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > @@ -212,19 +205,12 @@ static void idescsi_output_buffers (ide_
>  >  			return;
>  >  		}
>  >  		count = min(pc->sg->length - pc->b_count, bcount);
>  > -		if (PageHighMem(pc->sg->page)) {
>  > -			unsigned long flags;
>  > -
>  > -			local_irq_save(flags);
>  > -			buf = kmap_atomic(pc->sg->page, KM_IRQ0) + pc->sg->offset;
>  > -			drive->hwif->atapi_output_bytes(drive, buf + pc->b_count, count);
>  > -			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
>  > -			local_irq_restore(flags);
>  > -		} else {
>  > -			buf = page_address(pc->sg->page) + pc->sg->offset;
>  > -			drive->hwif->atapi_output_bytes(drive, buf + pc->b_count, count);
>  > -		}
>  > -		bcount -= count; pc->b_count += count;
>  > +		buf = kmap_atomic(pc->sg->page, KM_IRQ0);
>  > +		drive->hwif->atapi_output_bytes(drive,
>  > +				buf + pc->b_count + pc->sg->offset, count);
>  > +		kunmap_atomic(buf, KM_IRQ0);
>  > +		bcount -= count;
>  > +		pc->b_count += count;
> 
>  Unless I'm missing something, this patch looks very wrong.
> 
>  kmap_atomic(..., KM_IRQx) needs to be inside local_irq_save().

Yeah, shared interrupts.

>  As such, the PageHighMem() does have clear benefits.

Yep, thanks.  I'll fix that up.
