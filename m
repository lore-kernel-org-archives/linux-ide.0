From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a question about interrupt of IDE controller( bug 5637)
Date: Wed, 05 Dec 2007 13:33:46 +0800
Message-ID: <1196832826.10467.15.camel@yakui_zhao.sh.intel.com>
References: <1196738884.4012.55.camel@yakui_zhao.sh.intel.com>
	 <20071204123828.09fc2648@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60022 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbXLEFlf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 00:41:35 -0500
In-Reply-To: <20071204123828.09fc2648@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, shaohua.li@intel.com, rui.zhang@intel.com

On Tue, 2007-12-04 at 12:38 +0000, Alan Cox wrote:
> > 	When the IDE controller works in legacy mode, the default IRQ for Ide0
> > interface is 14 and IRQ for Ide1 interface is 15. The default interrupt
> > mode for IRQ14/15 is edge/high. If the interrupt of some PCI devices is
> > routed to IRQ14 or 15 and the interrupt mode is switched to Low/Level,
> > an exception will appear.(If the I/O APIC is used as the Interrupt
> > controller, IRQ14/15 nobody cared for. If the I8259 is used as the
> > interrupt controller, maybe some IDE interrupts will be lost). 
> 
> Yes.
> 
> > 	In the Bug 5637: When the system works in acpi mode, there is no PCI
> > interrupt router for IDE pci device in ACPI tables and OS will guess an
> > interrupt for IDE PCI device, which is obtained from IDE PCI
> > configuration space(The IRQ number is 15). OS will register the IRQ 15
> > using acpi_register_gsi and switch the interrupt mode of IRQ 15 to
> > Low/level. Because the interrupt mode for IRQ 15 is uncorrect, there
> > will be interrupt flood and the system reports: IRQ 15 nobody cared.
> > 	
> > 	How to fix this issue? Is IRQ 14/15 always reserved for the IDE
> > device?
> 
> No.
> 
> If the IDE device is in legacy mode then the IRQ is fixed at 14/15 for
> the two channels. If it is in PCI mode then the PCI and ACPI routing
> applies. This is defined in the header of the IDE device.
> 
> Class STORAGE:IDE
> 
> Programming class bit 0 -> channel 0 is legacy (0x1F0, 0x3F6, 14)
> Programming class bit 2 -> channel 1 is legacy (0x170, 0x376. 15)
Thanks for the response.
When IDE device works in legacy mode, the IRQ of IDE is fixed at 14/15
for the two channel. But IDE controller is a PCI device, OS will assign
an interrupt number for the PCI device in which IDE controller resides.
This is realized by calling ide_pci_enable, which will call
pcibios_enable_irq. 
In the bug5637 OS registers the IRQ 15 in the initialization phase of
PCI IDE controller and the interrupt mode is Low/level. So the problem
appears.
