From: Kamal Mostafa <kamal@canonical.com>
Subject: [3.13.y.z extended stable] Patch "ahci: Do not receive interrupts sent by dummy ports" has been added to staging queue
Date: Tue, 10 Jun 2014 11:46:33 -0700
Message-ID: <1402425993-26161-1-git-send-email-kamal@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34108 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaFJSqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2014 14:46:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Kamal Mostafa <kamal@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    ahci: Do not receive interrupts sent by dummy ports

to the linux-3.13.y-queue branch of the 3.13.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11.3.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From 92cee439ba690337e4831e4a8ac86405118d4ca8 Mon Sep 17 00:00:00 2001
From: Alexander Gordeev <agordeev@redhat.com>
Date: Thu, 17 Apr 2014 18:06:15 +0200
Subject: ahci: Do not receive interrupts sent by dummy ports

commit 2cf532f5e67c0cfe38c8c100e49280cdadacd2be upstream.

In multiple MSI mode all AHCI ports (including dummy) get assigned
separate MSI vectors and (as result of execution
pci_enable_msi_exact() function) separate IRQ numbers, (mapped to the
MSI vectors).

Therefore, although interrupts from dummy ports are not desired they
are still enabled. We do not request IRQs for dummy ports, but that
only means we do not assign AHCI-specific ISRs to corresponding IRQ
numbers.

As result, dummy port interrupts still could come and traverse all the
way from the PCI device to the kernel, causing unnecessary overhead.

This update disables IRQs for dummy ports and prevents the described
issue.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org
Fixes: 5ca72c4f7c41 ("AHCI: Support multiple MSIs")
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/ata/ahci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 337d126..bc5579e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1171,12 +1171,16 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ahci_port_priv *pp = host->ports[i]->private_data;

-		/* pp is NULL for dummy ports */
-		if (pp)
-			rc = devm_request_threaded_irq(host->dev,
-						       irq + i, ahci_hw_interrupt,
-						       ahci_thread_fn, IRQF_SHARED,
-						       pp->irq_desc, host->ports[i]);
+		/* Do not receive interrupts sent by dummy ports */
+		if (!pp) {
+			disable_irq(irq + i);
+			continue;
+		}
+
+		rc = devm_request_threaded_irq(host->dev, irq + i,
+					       ahci_hw_interrupt,
+					       ahci_thread_fn, IRQF_SHARED,
+					       pp->irq_desc, host->ports[i]);
 		if (rc)
 			goto out_free_irqs;
 	}
--
1.9.1

