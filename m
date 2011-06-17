From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ahci: move ahci_sb600_softreset to libahci.c and
 rename it
Date: Fri, 17 Jun 2011 14:07:04 +0200
Message-ID: <20110617120704.GH2611@htj.dyndns.org>
References: <20110615101436.GT8141@htj.dyndns.org>
 <1308307158-1796-1-git-send-email-yuanlmm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41893 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757934Ab1FQMHJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2011 08:07:09 -0400
Content-Disposition: inline
In-Reply-To: <1308307158-1796-1-git-send-email-yuanlmm@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuan-Hsin Chen <yuanlmm@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Yuan-Hsin Chen <yhchen@faraday-tech.com>

Hello, Yuan-Hsin.

Yeap, we're getting almost there.  :)

On Fri, Jun 17, 2011 at 06:39:18PM +0800, Yuan-Hsin Chen wrote:
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 12c5282..e20f8d7 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -312,6 +312,7 @@ extern struct device_attribute *ahci_sdev_attrs[];
>  	.sdev_attrs		= ahci_sdev_attrs
>  
>  extern struct ata_port_operations ahci_ops;
> +extern struct ata_port_operations ahci_pmp_ops;

But I don't like ahci_pmp_ops name.  ahci_ops works just fine for pmp.
It's a workaround ops.  Maybe something like ahci_pmp_retry_srst_ops?

> +static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
> +			  unsigned long deadline);

Similarly, ahci_pmp_retry_srst_softreset()

> +struct ata_port_operations ahci_pmp_ops = {
> +	.inherits		= &ahci_ops,
> +	.softreset		= ahci_pmp_softreset,
> +	.pmp_softreset		= ahci_pmp_softreset,
> +};

Isn't overriding .softreset enough?  .pmp_softreset is used only for
downstream links.

> +static int ahci_pmp_check_ready(struct ata_link *link)
> +{
> +	void __iomem *port_mmio = ahci_port_base(link->ap);
> +	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
> +
> +	/*
> +	 * There is no need to check TFDATA if BAD PMP is found due to HW bug,
> +	 * which can save timeout delay.
> +	 */
> +	if (irq_status & PORT_IRQ_BAD_PMP)
> +		return -EIO;
> +
> +	printk("%s:TFT 0x%x\n", __func__, status);

You probably want ata_link_printk(link, KERN_DEBUG, ...);

Thanks.

-- 
tejun
