From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] sata_nv: kill struct nv_host_desc and nv_host
Date: Sat, 17 Jun 2006 15:49:55 +0900
Message-ID: <11505269952012-git-send-email-htejun@gmail.com>
References: <11505269953650-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:15034 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932428AbWFQGuA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 02:50:00 -0400
Received: by wr-out-0506.google.com with SMTP id i31so707625wra
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2006 23:49:59 -0700 (PDT)
In-Reply-To: <11505269953650-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

nv_host_desc and nv_host are used to discern different generations of
nv controllers.  Kill those.  New EH/hotplug implementation will use
standard port_info/ata_port_operations for that.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   50 ++----------------------------------------------
 1 files changed, 2 insertions(+), 48 deletions(-)

17f86185988378c641cac6a70a2a3244b9f69909
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 70f8194..e9c4547 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -89,7 +89,6 @@ static irqreturn_t nv_interrupt (int irq
 				 struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static void nv_host_stop (struct ata_host_set *host_set);
 
 enum nv_host_type
 {
@@ -137,30 +136,6 @@ static const struct pci_device_id nv_pci
 	{ 0, } /* terminate list */
 };
 
-struct nv_host_desc
-{
-	enum nv_host_type	host_type;
-};
-static struct nv_host_desc nv_device_tbl[] = {
-	{
-		.host_type	= GENERIC,
-	},
-	{
-		.host_type	= NFORCE2,
-	},
-	{
-		.host_type	= NFORCE3,
-	},
-	{	.host_type	= CK804,
-	},
-};
-
-struct nv_host
-{
-	struct nv_host_desc	*host_desc;
-	unsigned long		host_flags;
-};
-
 static struct pci_driver nv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
@@ -208,7 +183,7 @@ static const struct ata_port_operations 
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= nv_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 /* FIXME: The hardware provides the necessary SATA PHY controls
@@ -287,19 +262,9 @@ static void nv_scr_write (struct ata_por
 	iowrite32(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void nv_host_stop (struct ata_host_set *host_set)
-{
-	struct nv_host *host = host_set->private_data;
-
-	kfree(host);
-
-	ata_pci_host_stop(host_set);
-}
-
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
 	int pci_dev_busy = 0;
@@ -341,19 +306,10 @@ static int nv_init_one (struct pci_dev *
 	if (!probe_ent)
 		goto err_out_regions;
 
-	host = kmalloc(sizeof(struct nv_host), GFP_KERNEL);
-	if (!host)
-		goto err_out_free_ent;
-
-	memset(host, 0, sizeof(struct nv_host));
-	host->host_desc = &nv_device_tbl[ent->driver_data];
-
-	probe_ent->private_data = host;
-
 	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
 	if (!probe_ent->mmio_base) {
 		rc = -EIO;
-		goto err_out_free_host;
+		goto err_out_free_ent;
 	}
 
 	base = (unsigned long)probe_ent->mmio_base;
@@ -373,8 +329,6 @@ static int nv_init_one (struct pci_dev *
 
 err_out_iounmap:
 	pci_iounmap(pdev, probe_ent->mmio_base);
-err_out_free_host:
-	kfree(host);
 err_out_free_ent:
 	kfree(probe_ent);
 err_out_regions:
-- 
1.3.2


