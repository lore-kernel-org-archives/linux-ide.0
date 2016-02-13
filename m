From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Sat, 13 Feb 2016 19:54:25 +0300
Message-ID: <56BF5FC1.40000@cogentembedded.com>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35247 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbcBMQy2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2016 11:54:28 -0500
Received: by mail-lb0-f173.google.com with SMTP id bc4so59803301lbc.2
        for <linux-ide@vger.kernel.org>; Sat, 13 Feb 2016 08:54:28 -0800 (PST)
In-Reply-To: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tchalamarla@caviumnetworks.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, stripathi@apm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 2/13/2016 2:20 AM, tchalamarla@caviumnetworks.com wrote:

> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>
> Due to Errata in ThunderX, HOST_IRQ_STAT should be
> cleared before leaving the interrupt handler.
> The patch attempts to satisfy the need.
>
> Changes from V1:
> 	- Rebased on top of libata/for-4.6
>          - Moved ThunderX intr handler to new file
>
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> ---
>   drivers/ata/Makefile        |  2 +-
>   drivers/ata/ahci.c          |  3 ++
>   drivers/ata/ahci.h          |  1 +
>   drivers/ata/ahci_thunderx.c | 73 +++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 78 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/ata/ahci_thunderx.c
>
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 1857952..a36e70d 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -2,7 +2,7 @@
>   obj-$(CONFIG_ATA)		+= libata.o
>
>   # non-SFF interface
> -obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
> +obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o ahci_thunderx.o
>   obj-$(CONFIG_SATA_ACARD_AHCI)	+= acard-ahci.o libahci.o
>   obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o libahci_platform.o
>   obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 546a369..76e310e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1560,6 +1560,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (ahci_broken_devslp(pdev))
>   		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
>
> +	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
> +		ahci_thunderx_init(&pdev->dev, hpriv);
> +
>   	/* save initial config */
>   	ahci_pci_save_initial_config(pdev, hpriv);
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 167ba7e..77ae20d 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -425,6 +425,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s);
>   int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
>   void ahci_error_handler(struct ata_port *ap);
>   u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
> +void ahci_thunderx_init(struct device *dev, struct ahci_host_priv *hpriv);
>
>   static inline void __iomem *__ahci_port_base(struct ata_host *host,
>   					     unsigned int port_no)
> diff --git a/drivers/ata/ahci_thunderx.c b/drivers/ata/ahci_thunderx.c
> new file mode 100644
> index 0000000..223e170
> --- /dev/null
> +++ b/drivers/ata/ahci_thunderx.c
> @@ -0,0 +1,73 @@
> +/*
> + * SATA glue for Cavium Thunder SOCs.
> + *
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2010-2016 Cavium Networks
> + *
> + */
> +
> +#include <linux/module.h>
> +#include "ahci.h"
> +#include "libata.h"
> +
> +static irqreturn_t ahci_thunderx_irq_intr(int irq, void *dev_instance)

    *_irq_intr() is a bit tautological.

> +{
> +	struct ata_host *host = dev_instance;
> +	struct ahci_host_priv *hpriv;
> +	unsigned int rc = 0;
> +	void __iomem *mmio;
> +	u32 irq_stat, irq_masked;
> +	unsigned int handled = 1;
> +
> +	VPRINTK("ENTER\n");
> +
> +	hpriv = host->private_data;
> +	mmio = hpriv->mmio;

    Why not do this in the initializers?

> +
> +	/* sigh.  0xffffffff is a valid return from h/w */
> +	irq_stat = readl(mmio + HOST_IRQ_STAT);
> +	if (!irq_stat)
> +		return IRQ_NONE;
> +redo:

    Closer to the next statement, please.

> +
> +	irq_masked = irq_stat & hpriv->port_map;
> +
> +	spin_lock(&host->lock);
> +
> +	rc = ahci_handle_port_intr(host, irq_masked);
> +

    No need for empty line here.

> +	if (!rc)
> +		handled = 0;

    Doesn't this override the valid result in case of looping?

> +
> +	writel(irq_stat, mmio + HOST_IRQ_STAT);
> +
> +	/* Due to ERRATA#22536, ThunderX need to handle
> +	 * HOST_IRQ_STAT differently.
> +	 * Work around is to make sure all pending IRQs
> +	 * are served before leaving handler
> +	 */
> +	irq_stat = readl(mmio + HOST_IRQ_STAT);
> +
> +	spin_unlock(&host->lock);
> +
> +	if (irq_stat)
> +		goto redo;

    You can have a *do*/*while* loop, no need for *goto*.

> +
> +	VPRINTK("EXIT\n");
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
> +void ahci_thunderx_init(struct device *dev, struct ahci_host_priv *hpriv)
> +{
> +	hpriv->irq_handler = ahci_thunderx_irq_intr;
> +}
> +EXPORT_SYMBOL_GPL(ahci_thunderx_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
> +MODULE_DESCRIPTION("Cavium Inc. ThunderX sata config.");

MBR, Sergei

