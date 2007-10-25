From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] ahci: implement workaround for ASUS P5W-DH Deluxe
	ahci_broken_hardreset()
Date: Thu, 25 Oct 2007 12:28:45 +0900
Message-ID: <20071025032845.GF11853@htj.dyndns.org>
References: <20071025030224.GE11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:24087 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbXJYD2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 23:28:53 -0400
Received: by rv-out-0910.google.com with SMTP id k20so356758rvb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 20:28:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071025030224.GE11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

P5W-DH Deluxe has ICH9 which doesn't have PMP support but SIMG 4726
hardwired to the second port of AHCI controller at PCI device 1f.2.
The 4726 doesn't work as PMP but as a storage processor which can do
hardware RAID on downstream ports.

When no device is attached to the downstream port of the 4726, pseudo
ATA device for configuration appears.  Unfortunately, ATA emulation on
the device is very lousy and causes long hang during boot.

This patch implements workaround for the board.  If the mainboard is
P5W-DH Deluxe (matched using DMI), only hardreset is used on the
second port of AHCI controller @ 1f.2 and the hardreset doesn't wait
for the first FIS and just proceed to IDENTIFY.

This workaround has been verified in bugzilla report 8923.

  http://bugzilla.kernel.org/show_bug.cgi?id=8923

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -41,6 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
@@ -1199,7 +1200,10 @@ static int ahci_broken_hardreset(struct 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline);
 
-	/* vt8251 needs SError cleared for the port to operate */
+	/* vt8251 needs SError cleared for the port to operate.  ICH8
+	 * on ASUS P5W-DH Deluxe doesn't need this but it doesn't hurt
+	 * either.
+	 */
 	ahci_scr_read(ap, SCR_ERROR, &serror);
 	ahci_scr_write(ap, SCR_ERROR, serror);
 
@@ -1207,8 +1211,15 @@ static int ahci_broken_hardreset(struct 
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 
-	/* vt8251 doesn't clear BSY on signature FIS reception,
-	 * request follow-up softreset.
+	/* vt8251 doesn't clear BSY on signature FIS reception and
+	 * thus follow-up softreset is required.
+	 *
+	 * The pseudo configuration device on SIMG4726 attached to
+	 * ASUS P5W-DH Deluxe doesn't send signature FIS after
+	 * hardreset if no device is attached to the first downstream
+	 * port && the pseudo device locks up on SRST w/ PMP==0.  To
+	 * work around this, ATA_LFLAG_NO_SRST and ASSUME_ATA are set
+	 * for the link.  Return.
 	 */
 	return rc ?: -EAGAIN;
 }
@@ -1955,6 +1966,50 @@ static void ahci_print_info(struct ata_h
 		);
 }
 
+/* On ASUS P5W DH Deluxe, the second port of PCI device 00:1f.2 is
+ * hardwired to on-board SIMG 4726.  The chipset is ICH8 and doesn't
+ * support PMP and the 4726 either directly exports the device
+ * attached to the first downstream port or acts as a hardware storage
+ * controller and emulate a single ATA device (can be RAID 0/1 or some
+ * other configuration).
+ *
+ * When there's no device attached to the first downstream port of the
+ * 4726, "Config Disk" appears, which is a pseudo ATA device to
+ * configure the 4726.  However, ATA emulation of the device is very
+ * lame.  It doesn't send signature D2H Reg FIS after the initial
+ * hardreset, pukes on SRST w/ PMP==0 and has bunch of other issues.
+ *
+ * The following function works around the problem by always using
+ * hardreset on the port without waiting for signature FIS afterward
+ * and just assuming ATA class without follow-up softreset.
+ */
+static void ahci_p5wdh_workaround(struct ata_host *host)
+{
+	static struct dmi_system_id sysids[] = {
+		{
+			.ident = "P5W DH Deluxe",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR,
+					  "ASUSTEK COMPUTER INC"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "P5W DH Deluxe"),
+			},
+		},
+		{ }
+	};
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	if (pdev->bus->number == 0 && pdev->devfn == PCI_DEVFN(0x1f, 2) &&
+	    dmi_check_system(sysids)) {
+		struct ata_port *ap = host->ports[1];
+
+		dev_printk(KERN_INFO, &pdev->dev, "enabling ASUS P5W DH "
+			   "Deluxe on-board SIMG4726 workaround\n");
+
+		ap->ops = &ahci_broken_hrst_ops;
+		ap->link.flags |= ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_ATA;
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -2024,6 +2079,9 @@ static int ahci_init_one(struct pci_dev 
 			ap->ops = &ata_dummy_port_ops;
 	}
 
+	/* apply workaround for ASUS P5W DH Deluxe mainboard */
+	ahci_p5wdh_workaround(host);
+
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
 	if (rc)
