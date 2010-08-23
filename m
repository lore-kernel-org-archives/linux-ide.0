From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] sata_mv: fix broken DSM/TRIM support (v2)
Date: Mon, 23 Aug 2010 09:50:19 -0400
Message-ID: <1282571419.30799.7.camel@corey>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>
	 <4C722FD4.2010305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:6356 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751163Ab0HWNuQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2010 09:50:16 -0400
In-Reply-To: <4C722FD4.2010305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

>On 08/20/2010 03:40 AM, Mark Lord wrote:
>> Fix DSM/TRIM commands in sata_mv (v2).
>> These need to be issued using old-school "BM DMA",
>> rather than via the EDMA host queue.
>> 
>> Since the chips don't have proper BM DMA status,
>> we need to be more careful with setting the ATA_DMA_INTR bit,
>> since DSM/TRIM often has a long delay between "DMA complete"
>> and "command complete".
>> 
>> GEN_I chips don't have BM DMA, so no TRIM for them.
>> 
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>> ---
>> 
>> Re-issue of original patch, with fixes for GEN_I and GEN_II chipsets.
>> (my apologies for broken mailers -- patch also attached in case inline is b0rked).
>> 
>> --- 2.6.35.2/drivers/ata/sata_mv.c    2010-08-01 18:11:14.000000000 -0400
>> +++ linux/drivers/ata/sata_mv.c       2010-08-19 21:34:46.139766319 -0400
>> @@ -1898,19 +1898,25 @@
>>   *   LOCKING:
>>   *   Inherited from caller.
>>   */
>> -static void mv_bmdma_stop(struct ata_queued_cmd *qc)
>> +static void mv_bmdma_stop_ap(struct ata_port *ap)
>>  {
>> -     struct ata_port *ap = qc->ap;
>>       void __iomem *port_mmio = mv_ap_base(ap);
>>       u32 cmd;
>>  
>>       /* clear start/stop bit */
>>       cmd = readl(port_mmio + BMDMA_CMD);
>> -     cmd &= ~ATA_DMA_START;
>> -     writelfl(cmd, port_mmio + BMDMA_CMD);
>> +     if (cmd & ATA_DMA_START) {
>> +             cmd &= ~ATA_DMA_START;
>> +             writelfl(cmd, port_mmio + BMDMA_CMD);
>>  
>> -     /* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
>> -     ata_sff_dma_pause(ap);
>> +             /* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
>> +             ata_sff_dma_pause(ap);
>> +     }
>> +}
>
>Don't we need this for other BMDMA commands too?  If so, maybe it's
>better to make it two patches?
>-- 
>tejun

mlord wrote:
> TRIM is the first/only command which actually breaks
> without this.  It is possible that other commands may
> benefit as well on some DVD-RW drives, but I have not
> encountered those yet.
> 
> So for now, I've left it as a single patch,
> with all of the (small) pieces together for TRIM.

Oh, waitasec.. you were commenting on just that one scrap of code above.
Here, there's no change to normal operation.  It still gets called,
and still runs.  The change above just removes unnecessary register
writes if/when the code gets called multiple times, which can now
happen from the status polling further down.

Tested and working for TRIM and ATAPI (the only two users)
on both the PCI (6081) and PCIe (7042) variants, and also
confirmed by Nils on his Kirkwood SOC variant.

Cheers


