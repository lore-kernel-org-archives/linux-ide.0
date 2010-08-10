From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 10 Aug 2010 16:56:19 +0100
Message-ID: <20100810155559.7620.79711.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40485 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351Ab0HJQd0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Aug 2010 12:33:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

Intel IDE-R devices are part of the Intel AMT management setup. They don't
have any special configuration registers or settings so the ata_generic
driver will support them fully.

Rather than add a huge table of IDs for each chipset and keep sending in
new ones this patch autodetects them.

(And yes Jeff I'll resurrect the delay patches in a couple of weeks)

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/ata_generic.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 1 deletions(-)


diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index cc5f772..476f194 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -35,6 +35,7 @@
 enum {
 	ATA_GEN_CLASS_MATCH		= (1 << 0),
 	ATA_GEN_FORCE_DMA		= (1 << 1),
+	ATA_GEN_INTEL_IDER		= (1 << 2),
 };
 
 /**
@@ -109,6 +110,44 @@ static struct ata_port_operations generic_port_ops = {
 static int all_generic_ide;		/* Set to claim all devices */
 
 /**
+ *	is_intel_ider		-	identify intel IDE-R devices
+ *	@dev: PCI device
+ *
+ *	Distinguish Intel IDE-R controller devices from other Intel IDE
+ *	devices. IDE-R devices have no timing registers and are in
+ *	most respects virtual. They should be driven by the ata_generic
+ *	driver.
+ */
+
+static int is_intel_ider(struct pci_dev *dev)
+{
+	/* For Intel IDE the value at 0xF8 is only zero on IDE-R
+	   interfaces */
+	u32 r;
+	u16 t;
+
+	pci_read_config_dword(dev, 0xF8, &r);
+	/* Not IDE-R: punt so that ata_(old)piix gets it */
+	if (r != 0)
+		return 0;
+	/* 0xF8 is also be zero on some early Intel IDE devices
+	   but they will have a sane timing register */
+	pci_read_config_word(dev, 0x40, &t);
+	if (t != 0)
+		return 0;
+	/* Finally check if the timing register is writable so that
+	   we eliminate any early devices hot-docked in a docking
+	   station */
+	pci_write_config_word(dev, 0x40, 1);
+	pci_read_config_word(dev, 0x40, &t);
+	if (t) {
+		pci_write_config_word(dev, 0x40, 0);
+		return 0;
+	}
+	return 1;
+}
+
+/**
  *	ata_generic_init		-	attach generic IDE
  *	@dev: PCI device found
  *	@id: match entry
@@ -134,6 +173,10 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 	if ((id->driver_data & ATA_GEN_CLASS_MATCH) && all_generic_ide == 0)
 		return -ENODEV;
 
+	if (id->driver_data && ATA_GEN_INTEL_IDER)
+		if (!is_intel_ider(dev))
+			return -ENODEV;
+
 	/* Devices that need care */
 	if (dev->vendor == PCI_VENDOR_ID_UMC &&
 	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
@@ -186,7 +229,11 @@ static struct pci_device_id ata_generic[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_3),  },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_5),  },
-#endif	
+#endif
+	/* Intel, IDE class device */
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 
+	  .driver_data = ATA_GEN_INTEL_IDER },
 	/* Must come last. If you add entries adjust this table appropriately */
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL),
 	  .driver_data = ATA_GEN_CLASS_MATCH },

