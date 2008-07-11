From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH] PCI: Add support for multiple MSI
Date: Fri, 11 Jul 2008 17:28:28 +0900
Message-ID: <487719AC.9070609@jp.fujitsu.com>
References: <20080711005719.GO14894@parisc-linux.org> <1215738002-4961-2-git-send-email-matthew@wil.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1215738002-4961-2-git-send-email-matthew@wil.cx>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com, Matthew Wilcox <willy@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

Hi,

First of all, it seems that mask/unmask of MSI has problems.
 - Per-vector masking is optional for MSI, so I think that allocating
   multiple messages for a function without masking capability would be
   not good idea, since all vector in the block will be masked/unmasked
   at once without any agreement.
 - Even if the function supports per-vector masking, current
   mask/unmask_msi_irq() functions assume that MSI uses only one vector,
   therefore they only set/unset the first bit of the maskbits which
   for the first vector of the block.  The bits for other vectors are
   initialized as 'masked' but no one unmask them.

Matthew Wilcox wrote:
> + * Allocate IRQs for a device with the MSI capability.
> + * This function returns a negative errno if an error occurs.  If it
> + * is unable to allocate the number of interrupts requested, it returns
> + * the number of interrupts it might be able to allocate.  If it successfully
> + * allocates at least the number of interrupts requested, it returns 0 and
> + * updates the @dev's irq member to the lowest new interrupt number; the
> + * other interrupt numbers allocated to this device are consecutive.
> + */
> +int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
>  {
>  	int status;
>  
> -	status = pci_msi_check_device(dev, 1, PCI_CAP_ID_MSI);
> +	/* MSI only supports up to 32 interrupts */
> +	if (nvec > 32)
> +		return 32;

I think we should return -EINVAL here.
No one guarantee that 32 interrupts is able to be allocate at this time.

And also I think -EINVAL should be returned if nvec is greater than
the number of encoded in the function's "Multiple Message Capable", but
I could not find any mention about handling of such over-capability request
in PCI Bus Spec. 3.0.

> +
> +	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI);
>  	if (status)
>  		return status;
>  
>  	WARN_ON(!!dev->msi_enabled);
>  
> -	/* Check whether driver already requested for MSI-X irqs */
> +	/* Check whether driver already requested MSI-X irqs */
>  	if (dev->msix_enabled) {
>  		printk(KERN_INFO "PCI: %s: Can't enable MSI.  "
>  			"Device already has MSI-X enabled\n",
>  			pci_name(dev));
>  		return -EINVAL;
>  	}
> -	status = msi_capability_init(dev);
> +
> +	status = msi_capability_init(dev, nvec);
>  	return status;
>  }
> -EXPORT_SYMBOL(pci_enable_msi);
> +EXPORT_SYMBOL(pci_enable_msi_block);

Thanks,
H.Seto
