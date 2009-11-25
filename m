From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 67/86] pata_rz1000: Power Management fix
Date: Wed, 25 Nov 2009 18:10:24 +0100
Message-ID: <20091125171024.5446.80108.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933747AbZKYRRZ@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_rz1000: Power Management fix

Fix ->resume method to re-enable & re-init PCI device properly
before doing chipset specific setup.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_rz1000.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_rz1000.c
===================================================================
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -107,11 +107,20 @@ static int rz1000_init_one (struct pci_d
 #ifdef CONFIG_PM
 static int rz1000_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
 	/* If this fails on resume (which is a "cant happen" case), we
 	   must stop as any progress risks data loss */
 	if (rz1000_fifo_disable(pdev))
 		panic("rz1000 fifo");
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
