From: Zhao Yakui <yakui.zhao@intel.com>
Subject: a question about interrupt of IDE controller( bug 5637)
Date: Tue, 04 Dec 2007 11:28:04 +0800
Message-ID: <1196738884.4012.55.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24977 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXLDDPz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 22:15:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: shaohua.li@intel.com, rui.zhang@intel.com

Hi, All
	I have a question about the interrupt of IDE controller. There is a
regression between 2.6.13 and 2.6.12. More details can be found in the
following link:
	http://bugzilla.kernel.org/show_bug.cgi?id=5637
	
	When the IDE controller works in legacy mode, the default IRQ for Ide0
interface is 14 and IRQ for Ide1 interface is 15. The default interrupt
mode for IRQ14/15 is edge/high. If the interrupt of some PCI devices is
routed to IRQ14 or 15 and the interrupt mode is switched to Low/Level,
an exception will appear.(If the I/O APIC is used as the Interrupt
controller, IRQ14/15 nobody cared for. If the I8259 is used as the
interrupt controller, maybe some IDE interrupts will be lost). 
		
	In the Bug 5637: When the system works in acpi mode, there is no PCI
interrupt router for IDE pci device in ACPI tables and OS will guess an
interrupt for IDE PCI device, which is obtained from IDE PCI
configuration space(The IRQ number is 15). OS will register the IRQ 15
using acpi_register_gsi and switch the interrupt mode of IRQ 15 to
Low/level. Because the interrupt mode for IRQ 15 is uncorrect, there
will be interrupt flood and the system reports: IRQ 15 nobody cared.
	
	How to fix this issue? Is IRQ 14/15 always reserved for the IDE
device?  

Thanks.
	

	
	
	
