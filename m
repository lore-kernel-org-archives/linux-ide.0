From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 33/86] pata_hpt3x3: Power Management fix
Date: Wed, 25 Nov 2009 18:06:14 +0100
Message-ID: <20091125170614.5446.69651.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932329AbZKYRG5@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt3x3: Power Management fix

Fix ->resume method to re-enable & re-init PCI device properly
before doing chipset specific setup.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_hpt3x3.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_hpt3x3.c
===================================================================
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -255,8 +255,17 @@ static int hpt3x3_init_one(struct pci_de
 #ifdef CONFIG_PM
 static int hpt3x3_reinit_one(struct pci_dev *dev)
 {
+	struct ata_host *host = dev_get_drvdata(&dev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(dev);
+	if (rc)
+		return rc;
+
 	hpt3x3_init_chipset(dev);
-	return ata_pci_device_resume(dev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
