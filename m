From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 74/86] pata_serverworks: add serverworks_fixup()
Date: Wed, 25 Nov 2009 18:11:15 +0100
Message-ID: <20091125171115.5446.23518.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759377AbZKYRQF@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_serverworks: add serverworks_fixup()

Factor out common code from serverworks_[re]init_one() to
serverworks_fixup().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_serverworks.c |   57 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

Index: b/drivers/ata/pata_serverworks.c
===================================================================
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -371,6 +371,31 @@ static void serverworks_fixup_ht1000(str
 	pci_write_config_byte(pdev, 0x5A, btr);
 }
 
+static int serverworks_fixup(struct pci_dev *pdev)
+{
+	int rc = 0;
+
+	/* Force master latency timer to 64 PCI clocks */
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_SERVERWORKS_OSB4IDE:
+		rc = serverworks_fixup_osb4(pdev);
+		break;
+	case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
+		ata_pci_bmdma_clear_simplex(pdev);
+		/* fall through */
+	case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
+	case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
+		rc = serverworks_fixup_csb(pdev);
+		break;
+	case PCI_DEVICE_ID_SERVERWORKS_HT1000IDE:
+		serverworks_fixup_ht1000(pdev);
+		break;
+	}
+
+	return rc;
+}
 
 static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -408,13 +433,12 @@ static int serverworks_init_one(struct p
 	if (rc)
 		return rc;
 
-	/* Force master latency timer to 64 PCI clocks */
-	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
+	rc = serverworks_fixup(pdev);
 
 	/* OSB4 : South Bridge and IDE */
 	if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
 		/* Select non UDMA capable OSB4 if we can't do fixups */
-		if ( serverworks_fixup_osb4(pdev) < 0)
+		if (rc < 0)
 			ppi[0] = &info[1];
 	}
 	/* setup CSB5/CSB6 : South Bridge and IDE option RAID */
@@ -424,19 +448,13 @@ static int serverworks_init_one(struct p
 
 		 /* If the returned btr is the newer revision then
 		    select the right info block */
-		 if (serverworks_fixup_csb(pdev) == 3)
+		 if (rc == 3)
 		 	ppi[0] = &info[3];
 
 		/* Is this the 3rd channel CSB6 IDE ? */
 		if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)
 			ppi[1] = &ata_dummy_port_info;
 	}
-	/* setup HT1000E */
-	else if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_HT1000IDE)
-		serverworks_fixup_ht1000(pdev);
-
-	if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
-		ata_pci_bmdma_clear_simplex(pdev);
 
 	return ata_pci_sff_init_one(pdev, ppi, &serverworks_sht, NULL);
 }
@@ -451,24 +469,7 @@ static int serverworks_reinit_one(struct
 	if (rc)
 		return rc;
 
-	/* Force master latency timer to 64 PCI clocks */
-	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
-
-	switch (pdev->device) {
-		case PCI_DEVICE_ID_SERVERWORKS_OSB4IDE:
-			serverworks_fixup_osb4(pdev);
-			break;
-		case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
-			ata_pci_bmdma_clear_simplex(pdev);
-			/* fall through */
-		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
-		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
-			serverworks_fixup_csb(pdev);
-			break;
-		case PCI_DEVICE_ID_SERVERWORKS_HT1000IDE:
-			serverworks_fixup_ht1000(pdev);
-			break;
-	}
+	(void)serverworks_fixup(pdev);
 
 	ata_host_resume(host);
 	return 0;
