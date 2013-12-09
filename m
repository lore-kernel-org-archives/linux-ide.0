From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] pci: imx: enable pcie msi support
Date: Mon, 9 Dec 2013 12:16:23 +0100
Message-ID: <201312091216.23906.marex@denx.de>
References: <1386581119-2962-1-git-send-email-richard.zhuhongxing@gmail.com> <1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:45349 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933235Ab3LIMhD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Dec 2013 07:37:03 -0500
In-Reply-To: <1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: jbe@pengutronix.de, hrhaan@gmail.com, shawn.guo@linaro.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Monday, December 09, 2013 at 10:25:19 AM, Richard Zhu wrote:
> From: Richard Zhu <r65037@freescale.com>
> 
> eanble pcie msi support on imx6 platforms
> * add check_device api in the msi chip.
> * add the quirks into pcie_port struct for the deviation
> from standard routines.
> 
> Signed-off-by: Richard Zhu <richard.zhuhongxing@gmail.com>
[...]

> diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c index e33b68b..96d2b78 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -308,23 +308,28 @@ static int dw_msi_setup_irq(struct msi_chip *chip,
> struct pci_dev *pdev, return -EINVAL;
>  	}
> 
> -	pci_read_config_word(pdev, desc->msi_attrib.pos+PCI_MSI_FLAGS,
> -				&msg_ctr);
> -	msgvec = (msg_ctr&PCI_MSI_FLAGS_QSIZE) >> 4;
> -	if (msgvec == 0)
> -		msgvec = (msg_ctr & PCI_MSI_FLAGS_QMASK) >> 1;
> -	if (msgvec > 5)
> -		msgvec = 0;
> -
> -	irq = assign_irq((1 << msgvec), desc, &pos);
> -	if (irq < 0)
> -		return irq;
> -
> -	msg_ctr &= ~PCI_MSI_FLAGS_QSIZE;
> -	msg_ctr |= msgvec << 4;
> -	pci_write_config_word(pdev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
> -				msg_ctr);
> -	desc->msi_attrib.multiple = msgvec;
> +	if (pp->quirks & DW_PCIE_QUIRK_NO_MSI_VEC) {
> +		irq = assign_irq(1, desc, &pos);
> +		set_irq_flags(irq, IRQF_VALID);

What does this do exactly please ? I don't quite understand how this code works. 
A beefy comment how this works and why it's needed would really help.

> +	} else {
> +		pci_read_config_word(pdev, desc->msi_attrib.pos+PCI_MSI_FLAGS,
> +					&msg_ctr);
> +		msgvec = (msg_ctr&PCI_MSI_FLAGS_QSIZE) >> 4;
> +		if (msgvec == 0)
> +			msgvec = (msg_ctr & PCI_MSI_FLAGS_QMASK) >> 1;
> +		if (msgvec > 5)
> +			msgvec = 0;
> +
> +		irq = assign_irq((1 << msgvec), desc, &pos);
> +		if (irq < 0)
> +			return irq;
> +
> +		msg_ctr &= ~PCI_MSI_FLAGS_QSIZE;
> +		msg_ctr |= msgvec << 4;
> +		pci_write_config_word(pdev, desc->msi_attrib.pos + 
PCI_MSI_FLAGS,
> +					msg_ctr);
> +		desc->msi_attrib.multiple = msgvec;
> +	}
> 
>  	msg.address_lo = virt_to_phys((void *)pp->msi_data);
>  	msg.address_hi = 0x0;
> @@ -339,9 +344,30 @@ static void dw_msi_teardown_irq(struct msi_chip *chip,
> unsigned int irq) clear_irq(irq);
>  }
> 
> +static int dw_msi_check_device(struct msi_chip *chip, struct pci_dev
> *pdev, +		int nvec, int type)
> +{
> +	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> +	u32 val;

Can we not have a callback here into the MX6 PCIe driver instead of having this 
code here? Then we would likely not need these quirk flags at all.

> +	if (pp->quirks & DW_PCIE_QUIRK_MSI_SELF_EN) {
> +		if ((type == PCI_CAP_ID_MSI) || (type == PCI_CAP_ID_MSIX)) {
> +			/* Set MSI enable of RC here */
> +			val = readl(pp->dbi_base + 0x50);
> +			if ((val & (PCI_MSI_FLAGS_ENABLE << 16)) == 0) {
> +				val |= PCI_MSI_FLAGS_ENABLE << 16;
> +				writel(val, pp->dbi_base + 0x50);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct msi_chip dw_pcie_msi_chip = {
>  	.setup_irq = dw_msi_setup_irq,
>  	.teardown_irq = dw_msi_teardown_irq,
> +	.check_device = dw_msi_check_device,
>  };
> 
>  int dw_pcie_link_up(struct pcie_port *pp)
[...]
