From: Andrew Morton <akpm@osdl.org>
Subject: Re: ata kmap_atomic abuse
Date: Sat, 16 Dec 2006 09:20:05 -0800
Message-ID: <20061216092005.f962b2cd.akpm@osdl.org>
References: <20061211001314.9ecb17a2.akpm@osdl.org>
	<457D822A.9010600@garzik.org>
	<20061211100025.c9abb9bb.akpm@osdl.org>
	<4584217D.7090500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:57062 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161266AbWLPRUg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 12:20:36 -0500
In-Reply-To: <4584217D.7090500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, 16 Dec 2006 11:40:29 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > On Mon, 11 Dec 2006 11:07:06 -0500
> > Jeff Garzik <jeff@garzik.org> wrote:
> > 
> >> Andrew Morton wrote:
> >>> [  231.948000] SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
> >>> [  232.232000] ata1.00: configured for UDMA/33
> >>> [  232.404000] WARNING (1) at arch/i386/mm/highmem.c:47 kmap_atomic()
> >>> It's using KM_USER0 from softirq.
> >> I thought that was OK if it was kmap_atomic().  Live and learn.
> > 
> > Each kmap_atomic slot is basically a per-cpu global variable.  If a CPU is
> > inside process-level kmap_atomic(KM_USER0) and then runs that softirq,
> > it'll return from the softirq with its kmap slot pointing at the wrong
> > page.
> > 
> >> Checked in the attached.
> > 
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> >> index 664e137..a4790be 100644
> >> --- a/drivers/ata/libata-scsi.c
> >> +++ b/drivers/ata/libata-scsi.c
> >> @@ -1539,7 +1539,7 @@ static unsigned int ata_scsi_rbuf_get(st
> >>  		struct scatterlist *sg;
> >>  
> >>  		sg = (struct scatterlist *) cmd->request_buffer;
> >> -		buf = kmap_atomic(sg->page, KM_USER0) + sg->offset;
> >> +		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
> >>  		buflen = sg->length;
> >>  	} else {
> >>  		buf = cmd->request_buffer;
> >> @@ -1567,7 +1567,7 @@ static inline void ata_scsi_rbuf_put(str
> >>  		struct scatterlist *sg;
> >>  
> >>  		sg = (struct scatterlist *) cmd->request_buffer;
> >> -		kunmap_atomic(buf - sg->offset, KM_USER0);
> >> +		kunmap_atomic(buf - sg->offset, KM_IRQ0);
> >>  	}
> >>  }
> >>  
> > 
> > KM_IRQ0 can only be used with local interrupts disabled, for the same
> > reason.
> 
> Are you making a comment, or pointing out a flaw in the patch?

<tries to remember>

> AFAICS, the code in question is always under spin_lock_irqsave()

ok.  That is in fact obligatory: if we were to call this (as-modified)
function from softirq context but with local IRQs enabled, an intervening
interrupt could come in and make out kmap slot point somewhere else.

We require that local interrupts remain disabled by the caller until the
caller has called ata_scsi_rbuf_put().

This means that we require that all callers of the non-static
ata_scsi_rbuf_fill() have disabled local IRQs.  The nice comment says they
must do that, so hopefully we're OK there.

So yes, it all looks to be solid to me.  
