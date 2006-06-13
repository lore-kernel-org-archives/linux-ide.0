From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/7] sata_nv: kill struct nv_host
Date: Wed, 14 Jun 2006 06:31:03 +0900
Message-ID: <11502342631698-git-send-email-htejun@gmail.com>
References: <11502342632913-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:15557 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932244AbWFMVay (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:30:54 -0400
Received: by wr-out-0506.google.com with SMTP id 58so243227wri
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:30:53 -0700 (PDT)
In-Reply-To: <11502342632913-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

struct nv_host is sata_nv's host_set->private_data.  It contains two
fields nv_host_desc which points to a static desc entry and unused
host_flags.  Kill nv_host and make host_set->private_data directly
point to the nv_host_desc entry.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   24 ++----------------------
 1 files changed, 2 insertions(+), 22 deletions(-)

43cafdaf0396f38f989c6538777f69ac5397cbc4
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 716581e..ee674dd 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -156,12 +156,6 @@ static struct nv_host_desc nv_device_tbl
 	},
 };
 
-struct nv_host
-{
-	struct nv_host_desc	*host_desc;
-	unsigned long		host_flags;
-};
-
 static struct pci_driver nv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
@@ -290,17 +284,12 @@ static void nv_scr_write (struct ata_por
 
 static void nv_host_stop (struct ata_host_set *host_set)
 {
-	struct nv_host *host = host_set->private_data;
-
-	kfree(host);
-
 	ata_pci_host_stop(host_set);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
 	int pci_dev_busy = 0;
@@ -342,19 +331,12 @@ static int nv_init_one (struct pci_dev *
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
+	probe_ent->private_data = &nv_device_tbl[ent->driver_data];
 
 	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
 	if (!probe_ent->mmio_base) {
 		rc = -EIO;
-		goto err_out_free_host;
+		goto err_out_free_ent;
 	}
 
 	base = (unsigned long)probe_ent->mmio_base;
@@ -374,8 +356,6 @@ static int nv_init_one (struct pci_dev *
 
 err_out_iounmap:
 	pci_iounmap(pdev, probe_ent->mmio_base);
-err_out_free_host:
-	kfree(host);
 err_out_free_ent:
 	kfree(probe_ent);
 err_out_regions:
-- 
1.3.2


