From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] ata_piix: add host_set private structure
Date: Thu, 29 Jun 2006 01:58:28 +0900
Message-ID: <20060628165828.GD23844@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:2139 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751453AbWF1Q6N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 12:58:13 -0400
Received: by nf-out-0910.google.com with SMTP id h2so784052nfe
        for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 09:58:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Add host_set private structure piix_host_priv.  Currently the only
field is ->map which used to be stored directly at
host_set->private_data.  This change allows more host_set private
fields to be added.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

And the same patches against #upstream.  Thanks.

 drivers/scsi/ata_piix.c |   56 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 40 insertions(+), 16 deletions(-)

25aba001520a631616fc0f8025f1bf4c8323bf38
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 94b1261..bf41dd3 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -144,8 +144,13 @@ struct piix_map_db {
 	const int map[][4];
 };
 
+struct piix_host_priv {
+	const int *map;
+};
+
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
+static void piix_host_stop(struct ata_host_set *host_set);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 static void piix_pata_error_handler(struct ata_port *ap);
@@ -254,7 +259,7 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -284,10 +289,10 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
-static struct piix_map_db ich5_map_db = {
+static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
 	.map = {
 		/* PM   PS   SM   SS       MAP  */
@@ -302,7 +307,7 @@ static struct piix_map_db ich5_map_db = 
 	},
 };
 
-static struct piix_map_db ich6_map_db = {
+static const struct piix_map_db ich6_map_db = {
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
@@ -313,7 +318,7 @@ static struct piix_map_db ich6_map_db = 
 	},
 };
 
-static struct piix_map_db ich6m_map_db = {
+static const struct piix_map_db ich6m_map_db = {
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
@@ -324,6 +329,14 @@ static struct piix_map_db ich6m_map_db =
 	},
 };
 
+static const struct piix_map_db *piix_map_db_table[] = {
+	[ich5_sata]		= &ich5_map_db,
+	[esb_sata]		= &ich5_map_db,
+	[ich6_sata]		= &ich6_map_db,
+	[ich6_sata_ahci]	= &ich6_map_db,
+	[ich6m_sata_ahci]	= &ich6m_map_db,
+};
+
 static struct ata_port_info piix_port_info[] = {
 	/* piix4_pata */
 	{
@@ -362,7 +375,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* i6300esb_sata */
@@ -374,7 +386,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* ich6_sata */
@@ -386,7 +397,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6_sata_ahci */
@@ -399,7 +409,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6m_sata_ahci */
@@ -412,7 +421,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6m_map_db,
 	},
 };
 
@@ -508,7 +516,8 @@ static void piix_pata_error_handler(stru
 static int piix_sata_prereset(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	const unsigned int *map = ap->host_set->private_data;
+	struct piix_host_priv *hpriv = ap->host_set->private_data;
+	const unsigned int *map = hpriv->map;
 	int base = 2 * ap->hard_port_no;
 	unsigned int present_mask = 0;
 	int port, i;
@@ -762,9 +771,10 @@ static int __devinit piix_check_450nx_er
 }
 
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
-					 struct ata_port_info *pinfo)
+					 struct ata_port_info *pinfo,
+					 const struct piix_map_db *map_db)
 {
-	struct piix_map_db *map_db = pinfo[0].private_data;
+	struct piix_host_priv *hpriv = pinfo[0].private_data;
 	const unsigned int *map;
 	int i, invalid_map = 0;
 	u8 map_value;
@@ -805,8 +815,7 @@ static void __devinit piix_init_sata_map
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "invalid MAP value %u\n", map_value);
 
-	pinfo[0].private_data = (void *)map;
-	pinfo[1].private_data = (void *)map;
+	hpriv->map = map;
 }
 
 /**
@@ -829,6 +838,7 @@ static int piix_init_one (struct pci_dev
 	static int printed_version;
 	struct ata_port_info port_info[2];
 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
+	struct piix_host_priv *hpriv;
 	unsigned long host_flags;
 
 	if (!printed_version++)
@@ -839,8 +849,14 @@ static int piix_init_one (struct pci_dev
 	if (!in_module_init)
 		return -ENODEV;
 
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
+
 	port_info[0] = piix_port_info[ent->driver_data];
 	port_info[1] = piix_port_info[ent->driver_data];
+	port_info[0].private_data = hpriv;
+	port_info[1].private_data = hpriv;
 
 	host_flags = port_info[0].host_flags;
 
@@ -856,7 +872,8 @@ static int piix_init_one (struct pci_dev
 
 	/* Initialize SATA map */
 	if (host_flags & ATA_FLAG_SATA)
-		piix_init_sata_map(pdev, port_info);
+		piix_init_sata_map(pdev, port_info,
+				   piix_map_db_table[ent->driver_data]);
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
@@ -879,6 +896,13 @@ static int piix_init_one (struct pci_dev
 	return ata_pci_init_one(pdev, ppinfo, 2);
 }
 
+static void piix_host_stop(struct ata_host_set *host_set)
+{
+	if (host_set->next == NULL)
+		kfree(host_set->private_data);
+	ata_host_stop(host_set);
+}
+
 static int __init piix_init(void)
 {
 	int rc;
-- 
1.3.2

