From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH 3/5] x86, MSI: Minor readability fixes
Date: Thu, 16 Aug 2012 16:48:18 +0200
Message-ID: <b8b8f73e30bfb77ff0837820492773ce13469ba3.1345124063.git.agordeev@redhat.com>
References: <cover.1345124063.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756235Ab2HPOsj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2012 10:48:39 -0400
Content-Disposition: inline
In-Reply-To: <cover.1345124063.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Yinghai Lu <yinghai@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@linux.intel.com>, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 arch/x86/kernel/apic/io_apic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 5a5c92b..888f3b9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3142,7 +3142,7 @@ static int msi_compose_msg(struct pci_dev *pdev, unsigned int irq,
 
 	if (irq_remapped(cfg)) {
 		compose_remapped_msi_msg(pdev, irq, dest, msg, hpet_id);
-		return err;
+		return 0;
 	}
 
 	if (x2apic_enabled())
@@ -3169,7 +3169,7 @@ static int msi_compose_msg(struct pci_dev *pdev, unsigned int irq,
 			MSI_DATA_DELIVERY_LOWPRI) |
 		MSI_DATA_VECTOR(cfg->vector);
 
-	return err;
+	return 0;
 }
 
 static int
@@ -3251,7 +3251,7 @@ int setup_msix_irqs(struct pci_dev *dev, int nvec)
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
 		irq = create_irq_nr(irq_want, node);
 		if (irq == 0)
-			return -1;
+			return -ENOSPC;
 		irq_want = irq + 1;
 		if (!irq_remapping_enabled)
 			goto no_ir;
-- 
1.7.7.6


-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
