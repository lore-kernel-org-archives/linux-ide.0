From: Len Brown <lenb@kernel.org>
Subject: Re: [Patch]: ACPI : Not register gsi for PCI IDE controller in legacy mode
Date: Thu, 10 Jan 2008 22:53:28 -0500
Message-ID: <200801102253.28523.lenb@kernel.org>
References: <1197875609.7945.70.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1197875609.7945.70.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Applied to acpi test tree for .25.
Do you think this is .24 and a 23.stable candidate?

thanks,
-Len


On Monday 17 December 2007 02:13, Zhao Yakui wrote:
> Subject: ACPI : Not register gsi for PCI IDE controller in legacy mode
> >From : Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> When PCI IDE controller works in legacy mode and no PRT entry is found 
> in ACPI PRT table, OSPM will neither read the irq number from the IDE
> PCI configuration space nor call the function of acpi_register_gsi to
> register gsi.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5637
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Alan Cox  <alan@lxorguk.ukuu.org.uk>
> 
> ---
>  drivers/acpi/pci_irq.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux-2.6.24-rc5/drivers/acpi/pci_irq.c
> ===================================================================
> --- linux-2.6.24-rc5.orig/drivers/acpi/pci_irq.c
> +++ linux-2.6.24-rc5/drivers/acpi/pci_irq.c
> @@ -429,6 +429,15 @@ int acpi_pci_irq_enable(struct pci_dev *
>  					  &polarity, &link,
>  					  acpi_pci_allocate_irq);
>  
> +	if (irq < 0) {
> +		/*
> +		 * IDE legacy mode controller IRQs are magic. Why do compat
> +		 * extensions always make such a nasty mess.
> +		 */
> +		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE &&
> +				(dev->class & 0x05) == 0)
> +			return 0;
> +	}
>  	/*
>  	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
>  	 * driver reported one, then use it. Exit in any case.
> 
> 
