From: Tejun Heo <tj@kernel.org>
Subject: Re: Allow (forced) AHCI mode on Intel 5 series, 3400 series chipsets
Date: Mon, 8 Aug 2011 12:07:31 +0200
Message-ID: <20110808100731.GI23937@htj.dyndns.org>
References: <4E3D9EF9.4050906@vmars.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35723 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab1HHKHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Aug 2011 06:07:36 -0400
Received: by fxh19 with SMTP id 19so5203422fxh.19
        for <linux-ide@vger.kernel.org>; Mon, 08 Aug 2011 03:07:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E3D9EF9.4050906@vmars.tuwien.ac.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bernhard Froemel <froemel@vmars.tuwien.ac.at>
Cc: linux-ide@vger.kernel.org, joerg@dorchain.net, sshtylyov@mvista.com

Hello,

On Sat, Aug 06, 2011 at 10:07:21PM +0200, Bernhard Froemel wrote:
> The EFI/bios on the Apple Macbook Pro 6 series (and other Intel Chipset
> based Macs and Macbook (Pros)) is ignorant of the SATA controller
> AHCI/IDE mode settings. It is not possible to configure the EFI/bios to
> set the SATA controller into the AHCI mode and even if the controller is
> put into AHCI mode (e.g. by the bootloader) it is not correctly restored
> during sleep/suspend-wakeup cycles. The attached patch attempts to fix
> this by
> 1) registering the actual SATA controller mode and/or forcibly set it to
> AHCI mode (kernel command parameter: i5s_3400s_force_ahci=1) during
> system boot
> 2) restoring the AHCI mode after wakeup depending on the mode the
> controller was during system boot
> 
> The patch should have no impact on systems where an EFI/bios takes care
> about setting and correctly restoring the SATA controller mode: For
> those systems the kernel command parameter 'i5s_3400s_force_ahci=1' only
> acts as an additional feature to override the actual EFI/bios setting.
...
> +static int __init i5s_3400s_force_ahci_setup(char *str)
> +{
> +	if (!strcmp(str, "1"))
> +		i5s_3400s_force_ahci = 1;
> +	return 0;
> +}
> +early_param("i5s_3400s_force_ahci", i5s_3400s_force_ahci_setup);

Just setting variable if the parameter is specified would be enough.

> +static void __devinit i5s_3400s_fixup(struct pci_dev *dev)
> +{
> +	u16 amap;
> +	pci_bus_read_config_word(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 2),
> +		I5S_REG_AMAP, &amap);
> +	if (amap & 0x60) {
> +		printk(KERN_DEBUG I5S_PREFIX
> +			"SATA controller mode: AHCI (0x%04x)\n", amap);
> +		i5s_3400s_force_ahci = 1;
> +	} else {
> +		printk(KERN_DEBUG I5S_PREFIX
> +			"SATA controller mode: NON AHCI (0x%04x)\n", amap);
> +		if (i5s_3400s_force_ahci && (amap & 0xE0) == 0) {
> +			amap |= 0x60;
> +			printk(KERN_DEBUG I5S_PREFIX
> +				"Putting SATA controller into AHCI (0x%04x)\n",
> +				amap);
> +			pci_bus_write_config_word(dev->bus,
> +				PCI_DEVFN(PCI_SLOT(dev->devfn), 2),
> +				I5S_REG_AMAP, amap);
> +		}
> +	}
> +}
> +static void i5s_3400s_fixup_resume(struct pci_dev *dev)
> +{
> +	u16 amap;
> +	pci_bus_read_config_word(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 2),
> +		I5S_REG_AMAP, &amap);
> +	if (!(amap & 0x60)) {
> +		printk(KERN_DEBUG I5S_PREFIX
> +			"SATA controller mode: NON AHCI (0x%04x)\n", amap);
> +		amap &= ~BIT(7);
> +		amap |= 0x60;
> +	  printk(KERN_DEBUG I5S_PREFIX
> +			"Restoring AHCI mode of SATA controller (0x%04x)\n",
> +			amap);
> +		/* MAP - Address Map Register:  AHCI mode + 6 SATA ports */
> +		pci_bus_write_config_word(dev->bus,
> +			PCI_DEVFN(PCI_SLOT(dev->devfn), 2), I5S_REG_AMAP,
> +			amap);
> +	} else {
> +		printk(KERN_DEBUG I5S_PREFIX
> +			"SATA controller mode: AHCI (0x%04x)\n", amap);
> +	}
> +}

Shouldn't the resume fixup also check force_ahci?  It looks like it
would put the controller into ahci mode even if it was in ide mode
during boot.

At any rate, unless there's a broken BIOS which boots into ahci mode
but resumes into ide mode, I personally don't feel too enthusiastic
about forcing the controller into ahci mode depending on a kernel
paramster.  If it can be decided automatically and enabled by default,
for sure.  If not, it's not gonna be all that useful anyway.

Thanks.

-- 
tejun
