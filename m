From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 05/14] sata_mv Fix EDMA configuration
Date: Sat, 26 Jan 2008 10:12:39 -0500
Message-ID: <479B4DE7.8010302@rtr.ca>
References: <4798FB68.70400@rtr.ca> <4798FC48.4060707@rtr.ca> <479AB445.6060505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3563 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbYAZPMk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 10:12:40 -0500
In-Reply-To: <479AB445.6060505@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> sata_mv Fix EDMA configuration.
>>
>> Simplify and fix EDMA configuration setup to match Marvell 
>> specificiations.
>> The chip documentation gives a specific (re)init sequence, which we 
>> now follow.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> --- old/drivers/ata/sata_mv.c    2008-01-24 12:06:25.000000000 -0500
>> +++ new/drivers/ata/sata_mv.c    2008-01-24 12:12:37.000000000 -0500
>> @@ -210,6 +210,7 @@
>>     /* SATA registers */
>>     SATA_STATUS_OFS        = 0x300,  /* ctrl, err regs follow status */
>>     SATA_ACTIVE_OFS        = 0x350,
>> +    SATA_FIS_IRQ_CAUSE_OFS    = 0x364,
>>     PHY_MODE3        = 0x310,
>>     PHY_MODE4        = 0x314,
>>     PHY_MODE2        = 0x330,
>> @@ -222,11 +223,11 @@
>>
>>     /* Port registers */
>>     EDMA_CFG_OFS        = 0,
>> -    EDMA_CFG_Q_DEPTH    = 0,            /* queueing disabled */
>> -    EDMA_CFG_NCQ        = (1 << 5),
>> -    EDMA_CFG_NCQ_GO_ON_ERR    = (1 << 14),        /* continue on 
>> error */
>> -    EDMA_CFG_RD_BRST_EXT    = (1 << 11),        /* read burst 512B */
>> -    EDMA_CFG_WR_BUFF_LEN    = (1 << 13),        /* write buffer 512B */
>> +    EDMA_CFG_Q_DEPTH    = 0x1f,        /* max device queue depth */
>> +    EDMA_CFG_NCQ        = (1 << 5),    /* for R/W FPDMA queued */
>> +    EDMA_CFG_NCQ_GO_ON_ERR    = (1 << 14),    /* continue on error */
>> +    EDMA_CFG_RD_BRST_EXT    = (1 << 11),    /* read burst 512B */
>> +    EDMA_CFG_WR_BUFF_LEN    = (1 << 13),    /* write buffer 512B */
>>
>>     EDMA_ERR_IRQ_CAUSE_OFS    = 0x8,
>>     EDMA_ERR_IRQ_MASK_OFS    = 0xc,
>> @@ -470,6 +471,8 @@
>> static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio);
>> static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem 
>> *mmio,
>>                  unsigned int port_no);
>> +static void mv_edma_cfg(struct ata_port *ap, struct mv_host_priv *hpriv,
>> +            void __iomem *port_mmio);
>>
>> static struct scsi_host_template mv5_sht = {
>>     .module            = THIS_MODULE,
>> @@ -834,13 +837,33 @@
>>  *      LOCKING:
>>  *      Inherited from caller.
>>  */
>> -static void mv_start_dma(void __iomem *port_mmio, struct mv_host_priv 
>> *hpriv,
>> +static void mv_start_dma(struct ata_port *ap, void __iomem *port_mmio,
>>              struct mv_port_priv *pp)
>> {
>>     if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
>> +        struct mv_host_priv *hpriv = ap->host->private_data;
>> +        int hard_port = mv_hardport_from_port(ap->port_no);
>> +        void __iomem *hc_mmio = mv_hc_base_from_port(
>> +                ap->host->iomap[MV_PRIMARY_BAR], hard_port);
>> +        u32 hc_irq_cause, ipending;
>> +
>>         /* clear EDMA event indicators, if any */
>>         writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
>>
>> +        /* clear EDMA interrupt indicator, if any */
>> +        hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
>> +        ipending = (DEV_IRQ << hard_port) |
>> +                (CRPB_DMA_DONE << hard_port);
>> +        if (hc_irq_cause & ipending) {
>> +            writelfl(hc_irq_cause & ~ipending,
>> +                 hc_mmio + HC_IRQ_CAUSE_OFS);
>> +        }
>> +
>> +        mv_edma_cfg(ap, hpriv, port_mmio);
>> +
>> +        /* clear FIS IRQ Cause */
>> +        writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
>> +
>>         mv_set_edma_ptrs(port_mmio, hpriv, pp);
>>
>>         writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);
>> @@ -1025,30 +1048,22 @@
>> static void mv_edma_cfg(struct ata_port *ap, struct mv_host_priv *hpriv,
>>             void __iomem *port_mmio)
>> {
>> -    u32 cfg = readl(port_mmio + EDMA_CFG_OFS);
>> +    u32 cfg;
>>
>>     /* set up non-NCQ EDMA configuration */
>> -    cfg &= ~(1 << 9);    /* disable eQue */
>> +    cfg = EDMA_CFG_Q_DEPTH;        /* always 0x1f for *all* chips */
>>
>> -    if (IS_GEN_I(hpriv)) {
>> -        cfg &= ~0x1f;        /* clear queue depth */
>> +    if (IS_GEN_I(hpriv))
>>         cfg |= (1 << 8);    /* enab config burst size mask */
> 
> You no longer clear bit 9 for Gen-I, which looks wrong.
..

Sure it does.  It clears the *whole* register by default,
and then turns on only the bits we want.

Cheers
