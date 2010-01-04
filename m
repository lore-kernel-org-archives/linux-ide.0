From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 11:48:20 -0500
Message-ID: <4B421BD4.8090308@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <20100104151637.559c4780@lxorguk.ukuu.org.uk> <4B420A27.9060407@garzik.org> <20100104154406.GB18335@flint.arm.linux.org.uk> <20100104155544.0c7dbfaa@lxorguk.ukuu.org.uk> <20100104161537.GC18335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:63276 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0ADQsW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 11:48:22 -0500
Received: by yxe26 with SMTP id 26so14700650yxe.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 08:48:21 -0800 (PST)
In-Reply-To: <20100104161537.GC18335@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 11:15 AM, Russell King wrote:
> It goes on to say that the interrupt status bit in the BM-DMA status
> register will only be set after buffered data has been transferred -
> which means reading the altstatus register to determine when the device
> has finished would give a premature indication and doesn't take any
> account of the BM-DMA buffering.
>
> So I think Jeff is not right on the "must read altstatus" point.
>
> I would not be surprised if lots of host controllers were actually buggy
> in respect of reading any ATA device register mid-transfer - firstly a
> started UDMA operation can't be stopped before at least one word has been
> transferred, nor can it be stopped without first transferring the CRC
> bytes.  That's an awful lot of logic (and overhead) to be randomly
> interacting with due to other shared devices interrupt activity.
>
> Reading the BM-DMA status register (or equivalent on hosts) seems to be
> the right way to tell if an interrupt is pending.


libata already does that, as does IDE:

         case HSM_ST_LAST:
                 if (qc->tf.protocol == ATA_PROT_DMA ||
                     qc->tf.protocol == ATAPI_PROT_DMA) {

                         /* check status of DMA engine */
                         host_stat = ap->ops->bmdma_status(ap);
                         VPRINTK("ata%u: host_stat 0x%X\n",
                                 ap->print_id, host_stat);

                         /* if it's not our irq... */
                         if (!(host_stat & ATA_DMA_INTR))
                                 goto idle_irq;

[...]

         /* check main status, clearing INTRQ if needed */

         status = ata_sff_irq_status(ap);  <-- reads AltStatus here
         if (status & ATA_BUSY)
                 goto idle_irq;

IDE driver has basically the same logic in drive_is_ready()

I never said "must" read, I was only responding to the notion that 
touching AltStatus at all, in general, was a violation of the ATA spec. 
  IFF there is a DMA status register available to be checked, and IFF 
the transfer is DMA, then we do check that first.

	Jeff


