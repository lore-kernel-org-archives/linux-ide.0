From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pata_octeon_cf: use devm_kzalloc() to allocate cf_port
Date: Mon, 14 Apr 2014 18:28:37 +0200
Message-ID: <1927612.nfmGqcZdLy@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>, Guenter Roeck <linux@roeck-us.net>, linux-ide@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

As a nice side effect this fixes the cf_port leak on
dma_coerce_mask_and_coherent() or ata_host_activate()
failure.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Compile tested only.

 drivers/ata/pata_octeon_cf.c |   50 ++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

Index: b/drivers/ata/pata_octeon_cf.c
===================================================================
--- a/drivers/ata/pata_octeon_cf.c	2014-04-14 18:07:45.952340776 +0200
+++ b/drivers/ata/pata_octeon_cf.c	2014-04-14 18:23:58.000359028 +0200
@@ -865,7 +865,7 @@ static int octeon_cf_probe(struct platfo
 	if (node == NULL)
 		return -EINVAL;
 
-	cf_port = kzalloc(sizeof(*cf_port), GFP_KERNEL);
+	cf_port = devm_kzalloc(&pdev->dev, sizeof(*cf_port), GFP_KERNEL);
 	if (!cf_port)
 		return -ENOMEM;
 
@@ -881,10 +881,9 @@ static int octeon_cf_probe(struct platfo
 	n_size = of_n_size_cells(node);
 
 	reg_prop = of_find_property(node, "reg", &reg_len);
-	if (!reg_prop || reg_len < sizeof(__be32)) {
-		rv = -EINVAL;
-		goto free_cf_port;
-	}
+	if (!reg_prop || reg_len < sizeof(__be32))
+		return -EINVAL;
+
 	cs_num = reg_prop->value;
 	cf_port->cs0 = be32_to_cpup(cs_num);
 
@@ -901,16 +900,13 @@ static int octeon_cf_probe(struct platfo
 				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
 				if (!res_dma) {
 					of_node_put(dma_node);
-					rv = -EINVAL;
-					goto free_cf_port;
+					return -EINVAL;
 				}
 				cf_port->dma_base = (u64)devm_ioremap_nocache(&pdev->dev, res_dma->start,
 									 resource_size(res_dma));
-
 				if (!cf_port->dma_base) {
 					of_node_put(dma_node);
-					rv = -EINVAL;
-					goto free_cf_port;
+					return -EINVAL;
 				}
 
 				irq_handler = octeon_cf_interrupt;
@@ -921,41 +917,34 @@ static int octeon_cf_probe(struct platfo
 			of_node_put(dma_node);
 		}
 		res_cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (!res_cs1) {
-			rv = -EINVAL;
-			goto free_cf_port;
-		}
+		if (!res_cs1)
+			return -EINVAL;
+
 		cs1 = devm_ioremap_nocache(&pdev->dev, res_cs1->start,
 					   resource_size(res_cs1));
-
 		if (!cs1)
-			goto free_cf_port;
+			return rv;
+
+		if (reg_len < (n_addr + n_size + 1) * sizeof(__be32))
+			return -EINVAL;
 
-		if (reg_len < (n_addr + n_size + 1) * sizeof(__be32)) {
-			rv = -EINVAL;
-			goto free_cf_port;
-		}
 		cs_num += n_addr + n_size;
 		cf_port->cs1 = be32_to_cpup(cs_num);
 	}
 
 	res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	if (!res_cs0) {
-		rv = -EINVAL;
-		goto free_cf_port;
-	}
+	if (!res_cs0)
+		return -EINVAL;
 
 	cs0 = devm_ioremap_nocache(&pdev->dev, res_cs0->start,
 				   resource_size(res_cs0));
-
 	if (!cs0)
-		goto free_cf_port;
+		return rv;
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host)
-		goto free_cf_port;
+		return rv;
 
 	ap = host->ports[0];
 	ap->private_data = cf_port;
@@ -1020,17 +1009,12 @@ static int octeon_cf_probe(struct platfo
 
 	ata_port_desc(ap, "cmd %p ctl %p", base, ap->ioaddr.ctl_addr);
 
-
 	dev_info(&pdev->dev, "version " DRV_VERSION" %d bit%s.\n",
 		 is_16bit ? 16 : 8,
 		 cf_port->is_true_ide ? ", True IDE" : "");
 
 	return ata_host_activate(host, irq, irq_handler,
 				 IRQF_SHARED, &octeon_cf_sht);
-
-free_cf_port:
-	kfree(cf_port);
-	return rv;
 }
 
 static void octeon_cf_shutdown(struct device *dev)
