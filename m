From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] sil24: use SRST for phy_reset
Date: Wed, 16 Nov 2005 22:24:01 +0900
Message-ID: <437B32F1.6000103@gmail.com>
References: <20051116080505.GC22807@htj.dyndns.org> <437B25D1.3000805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:59399 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030322AbVKPNYK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 08:24:10 -0500
Received: by zproxy.gmail.com with SMTP id 14so1856473nzn
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 05:24:09 -0800 (PST)
In-Reply-To: <437B25D1.3000805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> There seems to be no way to obtain device signature from sil24 after
>> SATA phy reset and SRST is needed anyway for later port multiplier
>> suppport.  This patch converts sil24_phy_reset to use SRST instaed.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> Index: work/drivers/scsi/sata_sil24.c
>> ===================================================================
>> --- work.orig/drivers/scsi/sata_sil24.c    2005-11-16 
>> 16:58:01.000000000 +0900
>> +++ work/drivers/scsi/sata_sil24.c    2005-11-16 17:02:56.000000000 +0900
>> @@ -333,7 +333,7 @@ static struct ata_port_info sil24_port_i
>>      {
>>          .sht        = &sil24_sht,
>>          .host_flags    = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>> -                  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
>> +                  ATA_FLAG_SRST | ATA_FLAG_MMIO |
>>                    ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(4),
>>          .pio_mask    = 0x1f,            /* pio0-4 */
>>          .mwdma_mask    = 0x07,            /* mwdma0-2 */
>> @@ -344,7 +344,7 @@ static struct ata_port_info sil24_port_i
>>      {
>>          .sht        = &sil24_sht,
>>          .host_flags    = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>> -                  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
>> +                  ATA_FLAG_SRST | ATA_FLAG_MMIO |
>>                    ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(2),
>>          .pio_mask    = 0x1f,            /* pio0-4 */
>>          .mwdma_mask    = 0x07,            /* mwdma0-2 */
>> @@ -355,7 +355,7 @@ static struct ata_port_info sil24_port_i
>>      {
>>          .sht        = &sil24_sht,
>>          .host_flags    = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>> -                  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
>> +                  ATA_FLAG_SRST | ATA_FLAG_MMIO |
>>                    ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(1),
>>          .pio_mask    = 0x1f,            /* pio0-4 */
>>          .mwdma_mask    = 0x07,            /* mwdma0-2 */
> 
> 
> This is not only OK, it is preferred, since 3124 port reset issues 
> COMRESET for us.
> 
> 
>> @@ -415,16 +415,69 @@ static void sil24_tf_read(struct ata_por
>>      *tf = pp->tf;
>>  }
>>  
>> +static int sil24_issue_SRST(struct ata_port *ap)
>> +{
>> +    void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
>> +    struct sil24_port_priv *pp = ap->private_data;
>> +    struct sil24_prb *prb = &pp->cmd_block[0].prb;
>> +    dma_addr_t paddr = pp->cmd_block_dma;
>> +    u32 irq_enable, irq_stat;
>> +    int cnt;
>> +
>> +    /* temporarily turn off IRQs during SRST */
>> +    irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
>> +    writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
>> +
>> +    /* delay 10 ms */
>> +    udelay(10000);
> 
> 
> NAK:
> * long udelay (always NAK'd), as they chew processor and lock out other 
> things, for no reason.
> * passing 1000 or more to udelay() means you should use mdelay() instead
> * in this case, msleep() works just fine
> * I don't see why this delay is needed at all?
> 

The delay is from the original driver and I wasn't really sure whether 
we're allowed to sleep in phy_reset handlers.  IIRC, it didn't use to. 
I'll convert it to msleep.

> 
>> +    prb->ctrl = PRB_CTRL_SRST;
>> +    prb->fis[1] = 0; /* no PM yet */
>> +
>> +    writel((u32)paddr, port + PORT_CMD_ACTIVATE);
>> +
>> +    for (cnt = 0; cnt < 100; cnt++) {
>> +        irq_stat = readl(port + PORT_IRQ_STAT);
>> +        writel(irq_stat, port + PORT_IRQ_STAT);        /* clear irq */
>> +
>> +        irq_stat >>= PORT_IRQ_RAW_SHIFT;
>> +        if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
>> +            break;
>> +
>> +        udelay(1000);
> 
> 
> NAK:
> * long udelay (always NAK'd)
> * passing 1000 or more to udelay() means you should use mdelay() instead
> * in this case, msleep() works just fine
> 

ditto.

-- 
tejun
