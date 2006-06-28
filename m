From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH-stable 1/2] ata_piix: add host_set private structure
Date: Thu, 29 Jun 2006 01:51:28 +0900
Message-ID: <20060628165128.GB23844@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:54675 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751373AbWF1QvJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 12:51:09 -0400
Received: by wr-out-0506.google.com with SMTP id i24so426152wra
        for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 09:51:08 -0700 (PDT)
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

Jeff, these two patches are to fix the following bug.

http://bugzilla.kernel.org/show_bug.cgi?id=6724

After review, please push it to -stable.  Thanks.

 drivers/scsi/ata_piix.c |   55 +++++++++++++++++++++++++++++++++--------------
 1 files changed, 39 insertions(+), 16 deletions(-)

19957796b5c24892ab61bd9425d5c3e7630bd609
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 6dc8814..9f734fe 100644
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
 
 static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
@@ -250,7 +255,7 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -278,10 +283,10 @@ static const struct ata_port_operations 
 
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
@@ -296,7 +301,7 @@ static struct piix_map_db ich5_map_db = 
 	},
 };
 
-static struct piix_map_db ich6_map_db = {
+static const struct piix_map_db ich6_map_db = {
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
@@ -307,7 +312,7 @@ static struct piix_map_db ich6_map_db = 
 	},
 };
 
-static struct piix_map_db ich6m_map_db = {
+static const struct piix_map_db ich6m_map_db = {
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
@@ -318,6 +323,14 @@ static struct piix_map_db ich6m_map_db =
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
@@ -356,7 +369,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* i6300esb_sata */
@@ -368,7 +380,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* ich6_sata */
@@ -380,7 +391,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6_sata_ahci */
@@ -393,7 +403,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6m_sata_ahci */
@@ -406,7 +415,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6m_map_db,
 	},
 };
 
@@ -510,7 +518,8 @@ static int piix_pata_probe_reset(struct 
 static unsigned int piix_sata_probe (struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	const unsigned int *map = ap->host_set->private_data;
+	struct piix_host_priv *hpriv = ap->host_set->private_data;
+	const unsigned int *map = hpriv->map;
 	int base = 2 * ap->hard_port_no;
 	unsigned int present_mask = 0;
 	int port, i;
@@ -774,9 +783,10 @@ static int __devinit piix_check_450nx_er
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
@@ -817,8 +827,7 @@ static void __devinit piix_init_sata_map
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "invalid MAP value %u\n", map_value);
 
-	pinfo[0].private_data = (void *)map;
-	pinfo[1].private_data = (void *)map;
+	hpriv->map = map;
 }
 
 /**
@@ -841,6 +850,7 @@ static int piix_init_one (struct pci_dev
 	static int printed_version;
 	struct ata_port_info port_info[2];
 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
+	struct piix_host_priv *hpriv;
 	unsigned long host_flags;
 
 	if (!printed_version++)
@@ -851,8 +861,14 @@ static int piix_init_one (struct pci_dev
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
 
@@ -868,7 +884,8 @@ static int piix_init_one (struct pci_dev
 
 	/* Initialize SATA map */
 	if (host_flags & ATA_FLAG_SATA)
-		piix_init_sata_map(pdev, port_info);
+		piix_init_sata_map(pdev, port_info,
+				   piix_map_db_table[ent->driver_data]);
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
@@ -891,6 +908,12 @@ static int piix_init_one (struct pci_dev
 	return ata_pci_init_one(pdev, ppinfo, 2);
 }
 
+static void piix_host_stop(struct ata_host_set *host_set)
+{
+	kfree(host_set->private_data);
+	ata_host_stop(host_set);
+}
+
 static int __init piix_init(void)
 {
 	int rc;
-- 
1.3.2

