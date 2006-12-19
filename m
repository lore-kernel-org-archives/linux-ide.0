From: Ben Collins <ben.collins@ubuntu.com>
Subject: [PATCH 2.6.20-git] sata_svw: Check for errors from ata_device_add()
Date: Tue, 19 Dec 2006 17:59:13 -0500
Message-ID: <1166569153.5210.116.camel@gullible>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933032AbWLSW7d@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Without this patch, G5 oopses on boot. I've had this in Ubuntu since
2.6.17, but I forgot it was in there. Still required with 2.6.20.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index d89c959..85911b4 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -473,11 +473,11 @@ static int k2_sata_init_one (struct pci_
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (ata_device_add(probe_ent))
+		return 0;
 
-	return 0;
+	/* Failed to add, no device present */
+	rc = -ENODEV;
 
 err_out_free_ent:
 	kfree(probe_ent);
