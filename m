From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata: Compact Flash/PCMCIA driver for XLR
Date: Wed, 09 May 2012 19:48:12 +0400
Message-ID: <4FAA91BC.8070502@mvista.com>
References: <1336488150-19839-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39659 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760022Ab2EIPso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2012 11:48:44 -0400
Received: by lahd3 with SMTP id d3so315204lah.19
        for <linux-ide@vger.kernel.org>; Wed, 09 May 2012 08:48:43 -0700 (PDT)
In-Reply-To: <1336488150-19839-1-git-send-email-jayachandranc@netlogicmicro.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jayachandran C <jayachandranc@netlogicmicro.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Kamlakant Patel <kamlakant.patel@broadcom.com>

Hello.

On 08-05-2012 18:42, Jayachandran C wrote:

> From: Kamlakant Patel<kamlakant.patel@broadcom.com>

> Add driver for the compact flash interface on Netlogic MIPS SoCs.
> The code is based on platform pcmcia driver, but adds interrupt
> handling code to ACK interrupts.

> Signed-off-by: Kamlakant Patel<kamlakant.patel@broadcom.com>
> Signed-off-by: Jayachandran C<jayachandranc@netlogicmicro.com>
[...]

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6bdedd7..ba4a734 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -870,6 +870,15 @@ config PATA_WINBOND_VLB
>   	  Support for the Winbond W83759A controller on Vesa Local Bus
>   	  systems.
>
> +config PATA_XLR_PCMCIA
> +	tristate "Netlogic XLR PATA PCMCIA/CompactFlash support"

    PCMCIA suppport doesn't belong in drivers/ata/. Leave only CompactFlash.

> +	depends on CPU_XLR
> +	help
> +	  This option enables support for PCMCIA/CompactFlash driver for
> +	  Netlogic XLR SoCs.
> +
> +	  If unsure, say N.
> +
>   comment "Generic fallback / legacy drivers"
>
>   config PATA_ACPI
> diff --git a/drivers/ata/pata_xlr_pcmcia.c b/drivers/ata/pata_xlr_pcmcia.c
> new file mode 100644
> index 0000000..84de6d8
> --- /dev/null
> +++ b/drivers/ata/pata_xlr_pcmcia.c

    I suggest to name it pata_xlr_cf.c.

> @@ -0,0 +1,194 @@
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/libata.h>
> +#include <linux/platform_device.h>
> +#include <linux/ata_platform.h>

    Why this one?

> +
> +#define DRV_NAME "pata_xlr_platform"

    So, platform or pcmcia?

+static struct scsi_host_template pata_platform_sht = {

    Why 'pata_platform_sht' and not 'pata_xlr_sht'?

+	ATA_PIO_SHT(DRV_NAME),
+};
[...]
> +static struct ata_port_operations pata_platform_port_ops = {

    Why 'pata_platform_port_ops' and not 'pata_xlr_port_ops'?

> +	.inherits		= &ata_sff_port_ops,
> +	.sff_data_xfer		= ata_sff_data_xfer_noirq,
> +	.cable_detect		= ata_cable_unknown,
> +	.set_mode		= xlr_pata_platform_set_mode,
> +	.sff_irq_check		= xlr_pata_irq_check,
> +	.sff_check_status	= ata_sff_check_status,

    No need to override it, as the implementation is standard.

> +	.sff_irq_clear		= xlr_pata_irq_clear,
> +};
[...]
> +static int __devinit xlr_pata_platform_probe(struct platform_device *pdev)
> +{
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	struct ata_ioports *ioaddr;
> +
> +	struct resource *io_res;
> +	struct resource *irq_res;
> +	struct resource *ack_res;
> +
> +	struct device *dev = &pdev->dev;
> +	int irq = 0;
> +	int irq_flags = 0;
[...]
> +	/*
> +	 * And the IRQ
> +	 */
> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +
> +	if (irq_res && irq_res->start > 0) {
> +		irq = irq_res->start;
> +		irq_flags = irq_res->flags;
> +	}
[...]
> +	ap = host->ports[0];
> +	ap->ops = &pata_platform_port_ops;
> +	ap->private_data = ioremap(ack_res->start, resource_size(ack_res));

   Why not devm_ioremap()? ioremap() may fail and you don't handle it.

[...]
> +
> +	/*
> +	 * Handle the MMIO case
> +	 */
> +	ioaddr =&ap->ioaddr;
> +	ioaddr->data_addr = devm_ioremap(dev, io_res->start,
> +					resource_size(io_res));
> +	ioaddr->cmd_addr = ioaddr->data_addr + PATA_PCMCIA_BASE;
> +	ioaddr->altstatus_addr = ioaddr->data_addr + PATA_PCMCIA_STATUS;

    Wrong, alt. status and status registers are not the same register. It 
should be PATA_PCMCIA_CTL.

> +	ioaddr->ctl_addr = ioaddr->data_addr + PATA_PCMCIA_CTL;
> +
> +	/* Fixup the port shift for platforms that need it */
> +	ioaddr->data_addr	= ioaddr->cmd_addr + (ATA_REG_DATA);
> +	ioaddr->error_addr	= ioaddr->cmd_addr + (ATA_REG_ERR);
> +	ioaddr->feature_addr	= ioaddr->cmd_addr + (ATA_REG_FEATURE);
> +	ioaddr->nsect_addr	= ioaddr->cmd_addr + (ATA_REG_NSECT);
> +	ioaddr->lbal_addr	= ioaddr->cmd_addr + (ATA_REG_LBAL);
> +	ioaddr->lbam_addr	= ioaddr->cmd_addr + (ATA_REG_LBAM);
> +	ioaddr->lbah_addr	= ioaddr->cmd_addr + (ATA_REG_LBAH);
> +	ioaddr->device_addr	= ioaddr->cmd_addr + (ATA_REG_DEVICE);
> +	ioaddr->status_addr	= ioaddr->cmd_addr + (ATA_REG_STATUS);
> +	ioaddr->command_addr	= ioaddr->cmd_addr + (ATA_REG_CMD);

    Why not call ata_sff_std_ports() instead of all these assignments?

> +
> +	ata_port_desc(ap, "%s cmd 0x%x ctl 0x%x", "mmio",

    Why not just "mmio cmd 0x%x ctl 0x%x"?

> +			(unsigned int)ap->ioaddr.cmd_addr,
> +			(unsigned int)ap->ioaddr.ctl_addr);
> +
> +	/* activate */
> +	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
> +				 irq_flags, &pata_platform_sht);

    It's not the same IRQ flags that you can read from the resource, this 
seems wrong.

> +}
> +
> +static struct platform_driver pata_platform_driver = {

    Why 'pata_platfrom_driver' and not 'pata_xlr_driver'?

MBR, Sergei
