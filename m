From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] sata_rcar: extend PM methods
Date: Sat, 17 Jan 2015 02:00:36 +0300
Message-ID: <2490673.vl8J86zUxO@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>

In order to make it possible to restore from hibernation not only in Linux but
also in e.g. U-Boot, we have to extend  sata_rcar_{suspend|resume}() to {freeze|
thaw}() PM  methods and implement  the  restore() PM method.

Signed-off-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
[Sergei: killed unused variable, changed the order of initializers, modified
copyrights, renamed, modified changelog.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'for-next' branch of Tejun Heo's 'libata.git' repo.

 drivers/ata/sata_rcar.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -2,8 +2,8 @@
  * Renesas R-Car SATA driver
  *
  * Author: Vladimir Barinov <source@cogentembedded.com>
- * Copyright (C) 2013 Cogent Embedded, Inc.
- * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013-2015 Cogent Embedded, Inc.
+ * Copyright (C) 2013-2015 Renesas Solutions Corp.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -992,9 +992,30 @@ static int sata_rcar_resume(struct devic
 	return 0;
 }
 
+static int sata_rcar_restore(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct sata_rcar_priv *priv = host->private_data;
+
+	clk_prepare_enable(priv->clk);
+
+	sata_rcar_setup_port(host);
+
+	/* initialize host controller */
+	sata_rcar_init_controller(host);
+
+	ata_host_resume(host);
+
+	return 0;
+}
+
 static const struct dev_pm_ops sata_rcar_pm_ops = {
 	.suspend	= sata_rcar_suspend,
 	.resume		= sata_rcar_resume,
+	.freeze		= sata_rcar_suspend,
+	.thaw		= sata_rcar_resume,
+	.poweroff	= sata_rcar_suspend,
+	.restore	= sata_rcar_restore,
 };
 #endif
 

