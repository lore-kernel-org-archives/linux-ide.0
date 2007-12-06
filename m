From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a question about interrupt of IDE controller( bug 5637)
Date: Thu, 06 Dec 2007 09:30:16 +0800
Message-ID: <1196904616.29019.12.camel@yakui_zhao.sh.intel.com>
References: <1196738884.4012.55.camel@yakui_zhao.sh.intel.com>
	 <20071204123828.09fc2648@the-village.bc.nu>
	 <1196832826.10467.15.camel@yakui_zhao.sh.intel.com>
	 <20071205141809.615d1f59@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61741 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbXLFBkK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 20:40:10 -0500
In-Reply-To: <20071205141809.615d1f59@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, len.brown@intel.com, shaohua.li@intel.com, rui.zhang@intel.com

On Wed, 2007-12-05 at 14:18 +0000, Alan Cox wrote:
> > When IDE device works in legacy mode, the IRQ of IDE is fixed at 14/15
> > for the two channel. But IDE controller is a PCI device, OS will assign
> > an interrupt number for the PCI device in which IDE controller resides.
> > This is realized by calling ide_pci_enable, which will call
> > pcibios_enable_irq. 
> 
> And pcibios_enable_irq should see interrupt in as 0 in that case. It also
> knows about this but it seems the ACPI one doesn't.
> 
> I don't have a problem system but this would be my guess as to what we need
> 
> --- drivers/acpi/pci_irq.c~	2007-12-05 14:07:47.389727744 +0000
> +++ drivers/acpi/pci_irq.c	2007-12-05 14:07:47.389727744 +0000
> @@ -429,6 +429,13 @@
>  					  &polarity, &link,
>  					  acpi_pci_allocate_irq);
>  
> +	if (irq < 0) {
> +		/* IDE legacy mode controller IRQs are magic. Why do compat
> +		   extensions always make such a nasty mess */
> +		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE && 
> +						(dev->class & 0x05) == 0)
> +			return 0;
> +	}
>  	/*
>  	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
>  	 * driver reported one, then use it. Exit in any case.
The above patch can fix the issue in Bug5637. But if IDE controller
works in legcay mode and PRT tells us the interrupt for some PCI devices
is 14/15, should we make it pci-like interrupt(level trigger, low
active)? 
Thanks.
