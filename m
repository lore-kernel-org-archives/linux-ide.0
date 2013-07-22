From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-3.11-fixes] libata: make it clear that
 sata_inic162x is experimental
Date: Mon, 22 Jul 2013 17:13:07 -0400
Message-ID: <20130722211307.GA16776@mtj.dyndns.org>
References: <20130627160606.3447.9939.reportbug@storm.xmen.local>
 <20130627165114.GK4752@decadent.org.uk>
 <1372353297.24346.4.camel@phoenix>
 <20130627173142.GM4752@decadent.org.uk>
 <1372375714.330.17.camel@phoenix>
 <1372383087.23847.35.camel@deadeye.wl.decadent.org.uk>
 <1372427725.23094.17.camel@phoenix>
 <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
 <20130701061726.GA10717@mtj.dyndns.org>
 <1372668742.17064.23.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:48815 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab3GVVNM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jul 2013 17:13:12 -0400
Received: by mail-qa0-f50.google.com with SMTP id f14so894435qak.2
        for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2013 14:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1372668742.17064.23.camel@phoenix>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Braure de Calignon <braurede@free.fr>
Cc: Ben Hutchings <ben@decadent.org.uk>, 714295@bugs.debian.org, linux-ide@vger.kernel.org, risc4all@yahoo.com

Hello, guys.

I've committed the following patch to for-3.11-fixes.  It's
unfortunate but I can't see a good way out at this point.  :(

Thanks.

------------- 8< ----------------

>From bb9696192826a7d9279caf872e95b41bc26c7eff Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 22 Jul 2013 16:53:36 -0400

sata_inic162x never reached a state where it's reliable enough for
production use and data corruption is a relatively common occurrence.
Make the driver generate warning about the issues and mark the Kconfig
option as experimental.

If the situation doesn't improve, we'd be better off making it depend
on CONFIG_BROKEN.  Let's wait for several cycles and see if the kernel
message draws any attention.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Martin Braure de Calignon <braurede@free.fr>
Reported-by: Ben Hutchings <ben@decadent.org.uk>
Reported-by: risc4all@yahoo.com
---
 drivers/ata/Kconfig         |  2 +-
 drivers/ata/sata_inic162x.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 80dc988..5cddaf8 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -107,7 +107,7 @@ config SATA_FSL
 	  If unsure, say N.
 
 config SATA_INIC162X
-	tristate "Initio 162x SATA support"
+	tristate "Initio 162x SATA support (Very Experimental)"
 	depends on PCI
 	help
 	  This option enables support for Initio 162x Serial ATA.
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index e451317..5c54d95 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -6,6 +6,18 @@
  *
  * This file is released under GPL v2.
  *
+ * **** WARNING ****
+ *
+ * This driver never worked properly and unfortunately data corruption is
+ * relatively common.  There isn't anyone working on the driver and there's
+ * no support from the vendor.  Do not use this driver in any production
+ * environment.
+ *
+ * http://thread.gmane.org/gmane.linux.debian.devel.bugs.rc/378525/focus=54491
+ * https://bugzilla.kernel.org/show_bug.cgi?id=60565
+ *
+ * *****************
+ *
  * This controller is eccentric and easily locks up if something isn't
  * right.  Documentation is available at initio's website but it only
  * documents registers (not programming model).
@@ -807,6 +819,8 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
+	dev_alert(&pdev->dev, "inic162x support is broken with common data corruption issues and will be disabled by default, contact linux-ide@vger.kernel.org if in production use\n");
+
 	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, NR_PORTS);
 	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
-- 
1.8.3.1

