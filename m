From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Sun, 8 Jul 2007 15:26:10 +0200
Message-ID: <200707081526.10741.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:5731 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084AbXGHOAA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:00 -0400
Received: by mu-out-0910.google.com with SMTP id i10so570149mue
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 06:59:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/legacy/qd65xx.c |    3 +--
 drivers/ide/pci/sis5513.c   |    1 +
 include/linux/pci_ids.h     |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)


Bartlomiej Zolnierkiewicz (1):
      qd65xx: fix PIO mode selection

Uwe Koziolek (1):
      sis5513: adding PCI-ID


diff --git a/drivers/ide/legacy/qd65xx.c b/drivers/ide/legacy/qd65xx.c
index d1414a7..7783745 100644
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -258,8 +258,7 @@ static void qd6580_tune_drive (ide_drive_t *drive, u8 pio)
 	int recovery_time = 415; /* worst case values from the dos driver */
 
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
-		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
-		pio = min_t(u8, pio, 4);
+		pio = ide_get_best_pio_mode(drive, pio, 4, &d);
 
 		switch (pio) {
 			case 0: break;
diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
index bb6cc4a..ec0adad 100644
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -872,6 +872,7 @@ static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_devi
 static struct pci_device_id sis5513_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9a03b47..5b1c999 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -661,6 +661,7 @@
 #define PCI_DEVICE_ID_SI_965		0x0965
 #define PCI_DEVICE_ID_SI_966		0x0966
 #define PCI_DEVICE_ID_SI_968		0x0968
+#define PCI_DEVICE_ID_SI_1180		0x1180
 #define PCI_DEVICE_ID_SI_5511		0x5511
 #define PCI_DEVICE_ID_SI_5513		0x5513
 #define PCI_DEVICE_ID_SI_5517		0x5517
