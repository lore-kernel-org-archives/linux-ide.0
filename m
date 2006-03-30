From: "Anatoli Antonovitch" <antonovi@ati.com>
Subject: [PATCH 2.6.16-g6ac37e95-dirty] ide: ATI SB600 IDE support
Date: Thu, 30 Mar 2006 16:49:12 -0500
Message-ID: <CAB45F03F8EF5B4992E343DBFC52032803076EB0@torcaexmb1.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-haw.frontbridge.com ([12.129.219.97]:12484 "EHLO
	outbound2-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750993AbWC3Vta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 16:49:30 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Description
This patch adds support for the IDE device on ATI SB600

Patch
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
02f6cf2..4402e60 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -356,6 +356,10 @@
 #define PCI_DEVICE_ID_ATI_IXP300_SATA   0x436e
 #define PCI_DEVICE_ID_ATI_IXP400_IDE	0x4376
 #define PCI_DEVICE_ID_ATI_IXP400_SATA   0x4379
+#define PCI_DEVICE_ID_ATI_IXP400_SATA2  0x437a
+#define PCI_DEVICE_ID_ATI_IXP600_SATA	0x4380
+#define PCI_DEVICE_ID_ATI_IXP600_SRAID	0x4381
+#define PCI_DEVICE_ID_ATI_IXP600_IDE	0x438c
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005

diff --git a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c index
df9ee9a..900efd1 100644
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -348,6 +348,7 @@ static struct pci_device_id atiixp_pci_t
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, 
+PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);

Signed-off-by: Felix Kuehling <fkuehlin@ati.com>


