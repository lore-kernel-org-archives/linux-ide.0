From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] ahci: add a module parameter to ignore the SSS flags for
 async scanning
Date: Mon, 26 Jan 2009 16:28:56 -0800
Message-ID: <20090126162856.0720ce17@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43137 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbZA0A3A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 19:29:00 -0500
Received: from [192.102.209.1] (helo=localhost.localdomain)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1LRbp3-0001Hx-Qo
	for linux-ide@vger.kernel.org; Tue, 27 Jan 2009 00:28:58 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


>From f1adba17389764dd6f2ff654d61e8c32dbedbbef Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Mon, 26 Jan 2009 02:05:44 -0800
Subject: [PATCH] ahci: add a module parameter to ignore the SSS flags for async scanning

The SSS flag, which directs the OS to spin up one disk at a time
to not have the PSU blow out, sometimes gets set even when not needed.
The effect of this is a longer-than-needed boot time.

This patch adds a module parameter that makes the driver ignore SSS
at least as far as the parallel scan during boot is concerned...

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/ata/ahci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9603967..969c5e1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -61,9 +61,14 @@
 #define EM_MSG_LED_VALUE_ON           0x00010000
 
 static int ahci_skip_host_reset;
+static int ahci_ignore_sss;
+
 module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
 MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");
 
+module_param_named(ignore_sss, ahci_ignore_sss, int, 0444);
+MODULE_PARM_DESC(ignore_sss, "Ignore staggered spinup flag (0=don't ignore, 1=ignore)");
+
 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
 static void ahci_disable_alpm(struct ata_port *ap);
@@ -2660,8 +2665,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	host->iomap = pcim_iomap_table(pdev);
 	host->private_data = hpriv;
 
-	if (!(hpriv->cap & HOST_CAP_SSS))
+	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
 		host->flags |= ATA_HOST_PARALLEL_SCAN;
+	else
+		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
 
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
-- 
1.6.0.5


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
