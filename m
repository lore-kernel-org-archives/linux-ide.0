From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ata: libahci: Use devm_kcalloc() in
 ahci_platform_get_resources()
Date: Tue, 18 Apr 2017 22:02:45 +0200
Message-ID: <75fcbbf1-5011-e6fe-7999-7286ffe742a0@users.sourceforge.net>
References: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:59363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932475AbdDRUCy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 18 Apr 2017 16:02:54 -0400
In-Reply-To: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 21:15:48 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "devm_kcalloc".

  This issue was detected by using the Coccinelle software.

* Delete the local variable "sz" which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/libahci_platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index c68ea903b5bf..2bce61f7482f 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -350,7 +350,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct clk *clk;
 	struct device_node *child;
-	int i, sz, enabled_ports = 0, rc = -ENOMEM, child_nodes;
+	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -402,8 +402,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	if (!child_nodes)
 		hpriv->nports = 1;
 
-	sz = hpriv->nports * sizeof(*hpriv->phys);
-	hpriv->phys = devm_kzalloc(dev, sz, GFP_KERNEL);
+	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys),
+				   GFP_KERNEL);
 	if (!hpriv->phys) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.12.2

