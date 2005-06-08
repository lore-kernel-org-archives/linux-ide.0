From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata: Handle ATAPI interrupt before CDB is sent
Date: Wed, 08 Jun 2005 20:17:37 +0800
Message-ID: <42A6E1E1.4090202@tw.ibm.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com>	 <4287D1E3.9070606@pobox.com> <428877F4.5050405@tw.ibm.com>	 <42A6A60D.7020807@tw.ibm.com> <58cb370e05060803014046ef0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:34273 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262192AbVFHMSl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 08:18:41 -0400
In-Reply-To: <58cb370e05060803014046ef0b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>


Hi Bart:

> 
> 
>>@@ -3457,6 +3461,32 @@
>> {
>>        u8 status, host_stat;
>>
>>+       /* ATAPI: Handle the interrupt before CDB is sent */
>>+       if (is_atapi_taskfile(&qc->tf) &&
>>+           ap->pio_task_state != PIO_ST_CDB_SENT) {
>>+               /* check whether it's our irq */
>>+               host_stat = ap->ops->bmdma_status(ap);
>>+
>>+               if (host_stat & ATA_DMA_INTR) {
>>+                       /* Some pre-ATAPI-4 devices assert INTRQ here
>>+                        * if nIEN is zero. qc->dev->id[0] bits 5-6 can
>>+                        * be used to identify such devices.
>>+                        */
>>+                       DPRINTK("ata%u: atapi interrupt handled\n", ap->id);
> 
> 
> This looks wrong for ATA_PROT_ATAPI_[NODATA],
> we can't expect host to support DMA.
> 
> 
Yes, it looks strange.

If the IRQ is shared, the interrupt bit in the BM-DMA status register
seems to be our only hope to distinguish our interrupt from others.
Is there any other better method to make sure it is our interrupt?

Or, maybe no need to make sure it is our interrupt?
We can just assume it is our interrupt and read status register
to clear INTRQ (if asserted) blindly here. It should not hurt anyway.

> 
> 
> 	case ATA_PROT_DMA:
> 	case ATA_PROT_ATAPI_DMA:
> 	case ATA_PROT_ATAPI:
> 		/* check status of DMA engine */
> 		host_stat = ap->ops->bmdma_status(ap);
> 		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
> 
> 		/* if it's not our irq... */
> 		if (!(host_stat & ATA_DMA_INTR))
> 			goto idle_irq;
> 
> 		/* before we do anything else, clear DMA-Start bit */
> 		ap->ops->bmdma_stop(ap);
> 
> 		/* fall through */
> 
> ditto (vanilla libata-core.c)

ATA_PROT_ATAPI is done via PIO polling. So, maybe we can safely change the
'case ATA_PROT_ATAPI' here to return error?


BTW, I'm not sure whether the interrupt bit in the BM-DMA status register
is correct if BM-DMA is not started, so I added a debug patch and
did experiment on my pdc2027x adapter.
It seems the interrupt bit of BM-DMA status register is correct
even the BM-DMA is not started on the pdc2027x. Please see the attached log.
(I am not sure whether other adapters have the same behavior.)
Just for your reference.

Albert
======================
Jun  8 14:14:14 p4ht-s kernel: NODATA: ata2: host_stat 0x4
Jun  8 14:14:14 p4ht-s kernel: NODATA: alt status 0x50
Jun  8 14:14:15 p4ht-s kernel: NODATA: ata2: host_stat 0x4
Jun  8 14:14:15 p4ht-s kernel: NODATA: alt status 0x50
Jun  8 14:14:15 p4ht-s kernel: NODATA: ata2: host_stat 0x0
Jun  8 14:14:15 p4ht-s kernel: NODATA: alt status 0xD0     (device busy)
Jun  8 14:14:15 p4ht-s kernel: NODATA: ata2: host_stat 0x0
Jun  8 14:14:15 p4ht-s kernel: NODATA: alt status 0xD0     (device busy)
Jun  8 14:14:15 p4ht-s kernel: NODATA: ata2: host_stat 0x0
Jun  8 14:14:15 p4ht-s kernel: NODATA: alt status 0xD0     (device busy)
Jun  8 14:14:15 p4ht-s kernel: NODATA: ata2: host_stat 0x4
Jun  8 14:14:15 p4ht-s kernel: NODATA: alt status 0x50
Jun  8 14:14:16 p4ht-s kernel: NODATA: ata2: host_stat 0x4
Jun  8 14:14:16 p4ht-s kernel: NODATA: alt status 0x50




