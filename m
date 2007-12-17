From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch]: ACPI : Not register gsi for PCI IDE controller in legacy
	mode
Date: Mon, 17 Dec 2007 15:13:29 +0800
Message-ID: <1197875609.7945.70.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27712 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761960AbXLQHcr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 02:32:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Subject: ACPI : Not register gsi for PCI IDE controller in legacy mode
>From : Alan Cox <alan@lxorguk.ukuu.org.uk>

When PCI IDE controller works in legacy mode and no PRT entry is found 
in ACPI PRT table, OSPM will neither read the irq number from the IDE
PCI configuration space nor call the function of acpi_register_gsi to
register gsi.

http://bugzilla.kernel.org/show_bug.cgi?id=5637

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Alan Cox  <alan@lxorguk.ukuu.org.uk>

---
 drivers/acpi/pci_irq.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6.24-rc5/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.24-rc5.orig/drivers/acpi/pci_irq.c
+++ linux-2.6.24-rc5/drivers/acpi/pci_irq.c
@@ -429,6 +429,15 @@ int acpi_pci_irq_enable(struct pci_dev *
 					  &polarity, &link,
 					  acpi_pci_allocate_irq);
 
+	if (irq < 0) {
+		/*
+		 * IDE legacy mode controller IRQs are magic. Why do compat
+		 * extensions always make such a nasty mess.
+		 */
+		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE &&
+				(dev->class & 0x05) == 0)
+			return 0;
+	}
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.


