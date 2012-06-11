From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] ata: Compact Flash driver for Netlogic XLR/XLS
Date: Mon, 11 Jun 2012 21:02:15 +0400
Message-ID: <4FD62497.30906@mvista.com>
References: <1339403309-4855-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46619 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab2FKRC4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2012 13:02:56 -0400
Received: by lbbgm6 with SMTP id gm6so2962039lbb.19
        for <linux-ide@vger.kernel.org>; Mon, 11 Jun 2012 10:02:55 -0700 (PDT)
In-Reply-To: <1339403309-4855-1-git-send-email-jayachandranc@netlogicmicro.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jayachandran C <jayachandranc@netlogicmicro.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Kamlakant Patel <kamlakant.patel@broadcom.com>

Hello.

On 11-06-2012 12:28, Jayachandran C wrote:

> From: Kamlakant Patel<kamlakant.patel@broadcom.com>

> Add a platform ATA driver for the CF interface on Netlogic XLR/XLS
> MIPS SoCs. Chipselect 6 on the peripheral IO bus on these SoCs can
> be configured to act as a Compact Flash interface.

> The driver expects three resources to be passed to it:
>   0 - memory region corresponding to the CF chipselect
>   1 - memory region of the flash interrupt ack register in the
>       flash configuration region
>   2 - and the IRQ resource for the Compact Flash.

> Signed-off-by: Kamlakant Patel<kamlakant.patel@broadcom.com>
> Signed-off-by: Jayachandran C<jayachandranc@netlogicmicro.com>

    Jayachandran, after our chat on #mipslinux I thought your next driver will 
be for drivers/pcmcia/ since you're not going to use the True-IDE mode of the 
PCMCIA interface.

> diff --git a/drivers/ata/pata_xlr_cf.c b/drivers/ata/pata_xlr_cf.c
> new file mode 100644
> index 0000000..7d699c4
> --- /dev/null
> +++ b/drivers/ata/pata_xlr_cf.c
> @@ -0,0 +1,170 @@
[...]
> +#define XLR_CF_REG_BASE	0x1f0
> +#define XLR_CF_REG_CTRL	0x3f6

    These port addresses are the offsets in the PCMCIA I/O space of the I/O 
card you insert. In True IDE mode they are replaced by -CEx signals IIRC.

> +
> +struct pata_xlr_priv {
> +	void __iomem	*xlr_cf_ackreg;

    Why not just make that register pointer the private data directly?

> +static bool pata_xlr_irq_check(struct ata_port *port)
> +{
> +	struct pata_xlr_priv *priv = port->private_data;
> +	unsigned int reg;
> +
> +	reg = readl(priv->xlr_cf_ackreg);
> +	return (reg != 0);

    Parens not needed.

> +static int __devinit pata_xlr_cf_probe(struct platform_device *pdev)
> +{
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	struct ata_ioports *ioaddr;
> +	struct resource *io_res, *irq_res, *ack_res;
> +	struct pata_xlr_priv *priv;
> +	struct device *dev =&pdev->dev;
> +	void __iomem *iodata_addr;
> +	int irq = 0;
> +
> +	/* Simple resource validation */
> +	if (pdev->num_resources != 3) {
> +		dev_err(&pdev->dev, "invalid number of resources\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Get the I/O base */
> +	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (io_res == NULL)
> +		return -EINVAL;
> +
> +	ack_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (ack_res == NULL)
> +		return -EINVAL;
> +
> +	/* And the IRQ */
> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

    You can use paltform_get_irq() and save on 'irq_res'.

> +	if (irq_res && irq_res->start>  0)
> +		irq = irq_res->start;
> +
> +	ioaddr = &ap->ioaddr;
> +	ioaddr->data_addr = iodata_addr;

    This is incorrect and overriden by ata_sff_std_ports() later.

> +	ioaddr->cmd_addr = ioaddr->data_addr + XLR_CF_REG_BASE;
> +	ioaddr->altstatus_addr = ioaddr->data_addr + XLR_CF_REG_CTRL;
> +	ioaddr->ctl_addr = ioaddr->data_addr + XLR_CF_REG_CTRL;
> +
> +	ata_sff_std_ports(ioaddr);
> +
> +	ata_port_desc(ap, "mmio cmd 0x%x ctl 0x%x",

    Why not use "0x%p" without the casts?

> +			(unsigned int)ap->ioaddr.cmd_addr,
> +			(unsigned int)ap->ioaddr.ctl_addr);
> +
> +	/* activate */
> +	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
> +				 IRQF_DISABLED, &pata_xlr_sht);

    IRQF_DISABLED is a nop now. Don't add another use of this deprecated flag.

MBR, Sergei
