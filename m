From: "Mat Loikkanen" <Mat.Loikkanen@synopsys.com>
Subject: RE: ata_bmdma_* calls in libata-core.c
Date: Wed, 2 Feb 2005 11:47:24 -0800
Message-ID: <001001c50960$049a7930$3805040a@internal.synopsys.com>
References: <42012916.5020007@pobox.com>
Reply-To: <Mat.Loikkanen@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Received: from us01smtp2.synopsys.com ([198.182.44.80]:56254 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S262334AbVBBTrm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 14:47:42 -0500
In-Reply-To: <42012916.5020007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff-

My driver (and our controller) actually does do DMA, using an off-controller
DMAC (the ARM PL080 on the Versatile board -- our controller talks the DMA
protocol over the AMBA/AHB bus).  I have successfully implemented
->qc_prep(), ->bmdma_setup(), and ->bmdma_start().  These functions setup
scatter-gather lists, configure the DMAC and kick off the DMAC respectively.
All works.  That said, I do run into ata_bmdma_status() and ata_bmdma_stop()
in ata_qc_timeout().

I suggest all BMDMA calls become callbacks that the driver can set to its
own functions or assign to wrapper functions implemented in libata-core.c
that call the inline functions in libata.h.  Should I do this?

-mat

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: Wednesday, February 02, 2005 11:25 AM
To: Mat.Loikkanen@synopsys.COM
Subject: Re: ata_bmdma_* calls in libata-core.c


Mat Loikkanen wrote:
> Jeff-
> 
> Could we somehow eliminate the direct calls to ata_bmdma_*() functions in
> libata-core.c?  Specifically, what's getting in my way currently are the
> calls within ata_qc_timeout(), called by ata_eng_timeout().  I can't use
the
> Libata callback ata_eng_timeout() since I'm not BMDMA.  What would be the
> correct fix:  Make these BMDMA calls no-ops?  Have the functions check
that
> ap->ioaddr.bmdma_addr doesn't equal some bad value (0xcdcdcdcd)?  Or make
> all these ata_bmdma_stop/ack_irq/status() overridable callbacks like
> bmdma_setup/start()?  The last option may be the most flexible, in case a
> non-BMDMA driver (like mine) would like to do something relevant in their
> place.  I will change the code and send a patch to you if you tell me what
> your preference is.

Quite honestly, libata error handling is very basic, and could stand to 
be improved.

On the "other side" of the transaction, the command submission side of 
things, libata is design so that it provides a standard IDE BMDMA 
interface.  If drivers do not have a purely BMDMA interface (AHCI is a 
good example here), the driver overrides library functions with its own.

However, for non-DMA controllers (your situation), there does not appear 
to be a big problem:  ata_eng_timeout() and ata_qc_timeout() correctly 
check qc->tf.protocol before calling BMDMA functions, except for one case:

                 /* ack bmdma irq events */
                 ata_bmdma_ack_irq(ap);

This is called in the PIO/non-data paths.  This is correct for most 
controllers, who want an IRQ ack on the BMDMA register even though its 
not a DMA command...  but in your case, this is incorrect.

So,

1) Do you see problems other than the call to ata_bmdma_ack_irq() ?

2) Feel free to suggest a patch which works around this.  Maybe an 
ATA_FLAG_BMDMA_ACK_IRQ for those controllers that must call 
ata_bmdma_ack_irq() on non-DMA paths.

	Jeff


