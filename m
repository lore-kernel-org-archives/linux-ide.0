From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: a question about interrupt of IDE controller( bug 5637)
Date: Tue, 4 Dec 2007 12:38:28 +0000
Message-ID: <20071204123828.09fc2648@the-village.bc.nu>
References: <1196738884.4012.55.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54176 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753102AbXLDMmx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 07:42:53 -0500
In-Reply-To: <1196738884.4012.55.camel@yakui_zhao.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-ide@vger.kernel.org, shaohua.li@intel.com, rui.zhang@intel.com

> 	When the IDE controller works in legacy mode, the default IRQ for Ide0
> interface is 14 and IRQ for Ide1 interface is 15. The default interrupt
> mode for IRQ14/15 is edge/high. If the interrupt of some PCI devices is
> routed to IRQ14 or 15 and the interrupt mode is switched to Low/Level,
> an exception will appear.(If the I/O APIC is used as the Interrupt
> controller, IRQ14/15 nobody cared for. If the I8259 is used as the
> interrupt controller, maybe some IDE interrupts will be lost). 

Yes.

> 	In the Bug 5637: When the system works in acpi mode, there is no PCI
> interrupt router for IDE pci device in ACPI tables and OS will guess an
> interrupt for IDE PCI device, which is obtained from IDE PCI
> configuration space(The IRQ number is 15). OS will register the IRQ 15
> using acpi_register_gsi and switch the interrupt mode of IRQ 15 to
> Low/level. Because the interrupt mode for IRQ 15 is uncorrect, there
> will be interrupt flood and the system reports: IRQ 15 nobody cared.
> 	
> 	How to fix this issue? Is IRQ 14/15 always reserved for the IDE
> device?

No.

If the IDE device is in legacy mode then the IRQ is fixed at 14/15 for
the two channels. If it is in PCI mode then the PCI and ACPI routing
applies. This is defined in the header of the IDE device.

Class STORAGE:IDE

Programming class bit 0 -> channel 0 is legacy (0x1F0, 0x3F6, 14)
Programming class bit 2 -> channel 1 is legacy (0x170, 0x376. 15)

