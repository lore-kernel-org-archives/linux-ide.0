From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [Patch] enable AHCI mode on certain ich chipsets
Date: Wed, 16 Feb 2011 14:45:56 -0500
Message-ID: <4D5C2974.4070608@garzik.org>
References: <20110216090548.GQ5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38592 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1BPTqB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2011 14:46:01 -0500
In-Reply-To: <20110216090548.GQ5778@Redstar.dorchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joerg Dorchain <joerg@dorchain.net>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>

On 02/16/2011 04:05 AM, Joerg Dorchain wrote:
> Hello all,
>
> this patch allows to force ICH7/8/9 into AHCI mode.  This is needed
> because some BIOSes do not make AHCI-mode operation available to the
> user.
> As the Intel documentation states that the OS should not carry
> out the operation - the user must force this on the kernel
> commandline using quirk_ich_force_ahci
>
> As this quirk gets called whilst the PCI subsystem is
> walking the PCI bus, we declare this quirk against the LPC
> (device 00:1f.0), so that we can frob 00:1f.2 before the PCI
> code has scanned it.
> Note: the pci id might change due to this (e.g. from 27c4 to 27c5)
>
> For working suspend/resume, the next patch is required, too.
>
> Bye,
>
> Joerg
>
>
> Signed-Off-By: joerg Dorchain<joerg@dorchain.net>
>
> --- linux/drivers/pci/quirks.c.orig	2011-02-04 18:29:03.000000000 +0100
> +++ linux/drivers/pci/quirks.c	2011-02-12 07:07:57.000000000 +0100
> @@ -2684,6 +2684,74 @@
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
>
>   /*
> + * Force ICH7/8/9 into AHCI mode.  This is needed because some
> + * BIOSes do not make AHCI-mode operation available to the user.
> + * As the Intel documentation states that the OS should not carry
> + * out the operation - the user must force this on the kernel
> + * commandline using quirk_ich_force_ahci
> + *
> + * As this quirk gets called whilst the PCI subsystem is
> + * walking the PCI bus, we declare this quirk against the LPC
> + * (device 00:1f.0), so that we can frob 00:1f.2 before the PCI
> + * code has scanned it.
> + * Note: the pci id might change due to this (e.g. from 27c4 to 27c5)
> + *
> + */
> +
> +static bool ich_force_ahci_mode; /* defaults to false */
> +
> +static int __init ich789_force_ahci_mode_setup(char *str)
> +{
> +	ich_force_ahci_mode = true;
> +	return 0;
> +}
> +early_param("quirk_ich_force_ahci", ich789_force_ahci_mode_setup);
> +
> +static void ich789_force_ahci_mode(struct pci_dev *pdev)
> +{
> +	u8 amrval;
> +	u8 sclkgc;
> +	const int ich89_address_map_reg = 0x90;
> +	const int ich89_sata_clock_gen_config_reg = 0x9c;
> +
> +	if (!ich_force_ahci_mode)
> +		return;
> +
> +	/* ICH8 datasheet section 12.1.33 */
> +	if (!pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +		ich89_address_map_reg,&amrval)) {
> +
> +		if (amrval&  (BIT(6) | BIT(7))) {
> +			dev_printk(KERN_DEBUG,&pdev->dev,
> +				"ICH7/8/9 SATA controller not in IDE mode.  Not modifying.\n");
> +			return;
> +		}
> +		if (amrval&  (BIT(0) | BIT(1)))
> +			dev_printk(KERN_DEBUG,&pdev->dev,
> +				"ICH7/8/9 in SATA/PATA combined mode.  Untested.\n");
> +		/* AHCI mode */
> +		amrval |= BIT(6);
> +		amrval&= ~BIT(7);
> +		pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +			ich89_sata_clock_gen_config_reg,&sclkgc);
> +		dev_printk(KERN_DEBUG,&pdev->dev, "sclkgc is %#0x\n", sclkgc);
> +		pci_bus_write_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +			ich89_address_map_reg, amrval);
> +		dev_printk(KERN_DEBUG,&pdev->dev, "Forced ICH7/8/9 mode PIIX->AHCI\n");

How is the assignment of the AHCI BAR handled?  Does this happen 
automatically because it's an early fixup?

That is traditionally the stumbling block...

	Jeff


