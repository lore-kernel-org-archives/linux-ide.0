From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] pata_octeon_cf: use of_property_read_{bool|u32}()
Date: Sun, 27 Aug 2017 22:55:09 +0300
Message-ID: <20170827195613.904715064@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34164 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdH0T4T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 27 Aug 2017 15:56:19 -0400
Received: by mail-lf0-f53.google.com with SMTP id d17so15181433lfe.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Aug 2017 12:56:18 -0700 (PDT)
Content-Disposition: inline; filename=pata_octeon_cf-use-of_property_read_-bool-u32.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, "\"open list:LIBATA PATA DRIVERS\"" <linux-ide@vger.kernel.org>
Cc: linux-mips@linux-mips.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The Octeon CF driver basically  open-codes of_property_read_{bool|u32}()
using  of_{find|get}_property() calls in its  probe() method.  Using the
modern DT APIs saves 2 LoCs and 16 bytes of object code (MIPS gcc 3.4.3).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/ata/pata_octeon_cf.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: libata/drivers/ata/pata_octeon_cf.c
===================================================================
--- libata.orig/drivers/ata/pata_octeon_cf.c
+++ libata/drivers/ata/pata_octeon_cf.c
@@ -840,7 +840,6 @@ static int octeon_cf_probe(struct platfo
 	struct property *reg_prop;
 	int n_addr, n_size, reg_len;
 	struct device_node *node;
-	const void *prop;
 	void __iomem *cs0;
 	void __iomem *cs1 = NULL;
 	struct ata_host *host;
@@ -850,7 +849,7 @@ static int octeon_cf_probe(struct platfo
 	void __iomem *base;
 	struct octeon_cf_port *cf_port;
 	int rv = -ENOMEM;
-
+	u32 bus_width;
 
 	node = pdev->dev.of_node;
 	if (node == NULL)
@@ -860,11 +859,10 @@ static int octeon_cf_probe(struct platfo
 	if (!cf_port)
 		return -ENOMEM;
 
-	cf_port->is_true_ide = (of_find_property(node, "cavium,true-ide", NULL) != NULL);
+	cf_port->is_true_ide = of_property_read_bool(node, "cavium,true-ide");
 
-	prop = of_get_property(node, "cavium,bus-width", NULL);
-	if (prop)
-		is_16bit = (be32_to_cpup(prop) == 16);
+	if (of_property_read_u32(node, "cavium,bus-width", &bus_width) == 0)
+		is_16bit = (bus_width == 16);
 	else
 		is_16bit = false;
 

