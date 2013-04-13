From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [RFC PATCH] AHCI: Workaround for ATAPI on buggy AHCI controller
Date: Fri, 12 Apr 2013 23:05:17 -0600
Message-ID: <5168E78D.90805@gmail.com>
References: <CAO1A-8A0c=5GnH4wLYBz+N1tHLUO3CeuOSq_7S+ZxscNqt5Hnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:44650 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab3DMFFU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Apr 2013 01:05:20 -0400
Received: by mail-ia0-f178.google.com with SMTP id w21so1175563iac.23
        for <linux-ide@vger.kernel.org>; Fri, 12 Apr 2013 22:05:19 -0700 (PDT)
In-Reply-To: <CAO1A-8A0c=5GnH4wLYBz+N1tHLUO3CeuOSq_7S+ZxscNqt5Hnw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On 04/12/2013 01:34 PM, Marc C wrote:
> Hello Jeff,
>
> I'm working with a proprietary but AHCI-compatible SATA controller that uses
> the libata driver. Early versions of this controller have issues with processing
> non-data ATAPI commands. A workaround was identified which requires some
> register pokes in the command completion path of the driver. I don't expect to
> push this patch upstream (yet). However, I would like to get some feedback
> regarding the workaround, and check if the placement of the code is "acceptable"
> or if there would be a better place to put it.
>
> The workaround itself is rather simple: toggle the START bit immediately after a
> non-data ATAPI command completes. The ST bit toggle would be performed within
> atomic context in the AHCI port interrupt ISR.
>
> Signed-off-by: Marc C <marc.ceeeee@gmail.com>

This should likely be triggered off a host flag like some of the ones 
already in the driver so it can be done just for the affected 
controllers, not unconditionally.

> ---
>   linux/drivers/ata/libahci.c     |   26 ++++++++++++++++++++++++++
>   linux/drivers/ata/libata-core.c |    6 ++++++
>   2 files changed, 32 insertions(+)
>
> diff --git a/linux/drivers/ata/libahci.c b/linux/drivers/ata/libahci.c
> index f9eaa82..20b3a9a 100644
> --- a/linux/drivers/ata/libahci.c
> +++ b/linux/drivers/ata/libahci.c
> @@ -2215,6 +2215,32 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
>   }
>   EXPORT_SYMBOL_GPL(ahci_set_em_messages);
>
> +void ahci_apply_atapi_workaround(struct ata_queued_cmd *qc)
> +{
> +    if (!(qc->flags & ATA_QCFLAG_DMAMAP)) {
> +        /*
> +         * Non-data ATAPI commands need to kick the DMA engine
> +         */
> +        struct ata_port *ap = qc->ap;
> +        void __iomem *port_mmio = ahci_port_base(ap);
> +        u32 tmp = readl(port_mmio + PORT_CMD);
> +
> +        /* check if the HBA is idle */
> +        if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) != 0) {
> +            /* setting HBA to idle */
> +            tmp &= ~PORT_CMD_START;
> +            writel(tmp, port_mmio + PORT_CMD);
> +
> +            /* wait for engine to stop */
> +            do {
> +                tmp = readl(port_mmio + PORT_CMD);
> +            } while (tmp & PORT_CMD_LIST_ON);
> +        }
> +        ahci_start_engine(ap);
> +    }
> +}
> +EXPORT_SYMBOL_GPL(ahci_apply_atapi_workaround);
> +
>   MODULE_AUTHOR("Jeff Garzik");
>   MODULE_DESCRIPTION("Common AHCI SATA low-level routines");
>   MODULE_LICENSE("GPL");
> diff --git a/linux/drivers/ata/libata-core.c b/linux/drivers/ata/libata-core.c
> index 4e73e1b..383de21 100644
> --- a/linux/drivers/ata/libata-core.c
> +++ b/linux/drivers/ata/libata-core.c
> @@ -4827,6 +4827,12 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>   {
>       struct ata_port *ap = qc->ap;
>
> +    if (ata_is_atapi(qc->tf.protocol)) {
> +        void ahci_apply_atapi_workaround(struct ata_queued_cmd *qc);
> +        ahci_apply_atapi_workaround(qc);
> +    }
> +
>       /* XXX: New EH and old EH use different mechanisms to
>        * synchronize EH with regular execution path.
>        *
> --
> 1.7.9.5
>
>
>
>
> --
> Regards,
> Marc
> marc.ceeeee@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

