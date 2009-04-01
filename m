From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata: ahci enclosure management bios workaround
Date: Wed, 1 Apr 2009 16:38:53 -0500
Message-ID: <20090401213853.GA6012@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:42178 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbZDAVlP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 17:41:15 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

During driver initialization ahci_start_port may not be able
to turn LEDs off because the hardware may still be transmitting
a message. And since the BIOS may not be setting the LEDs to an
off state when the controller is configured in AHCI mode, the
drive LEDs may end up in a fault state. This patch will check
to see if the controller is setup in AHCI mode and wait for
the EM transmit bit to clear if needed during driver initialization.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/ahci.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 788bba2..4694712 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -78,6 +78,7 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 					ssize_t size);
 #define MAX_SLOTS 8
+#define MAX_RETRY 15
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -218,6 +219,7 @@ enum {
 	AHCI_HFLAG_NO_HOTPLUG		= (1 << 7), /* ignore PxSERR.DIAG.N */
 	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
 	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
+	AHCI_HFLAG_BIOS_WORKAROUND      = (1 << 10), /* EM ahci mode */
 
 	/* ap->flags bits */
 
@@ -226,6 +228,8 @@ enum {
 					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN |
 					  ATA_FLAG_IPM,
 
+	SCC_REG                         = 0x0A, /* Sub Class Code Register */
+	AHCI_MODE                       = 0x06, /* AHCI mode */
 	ICH_MAP				= 0x90, /* ICH MAP register */
 
 	/* em_ctl bits */
@@ -322,6 +326,7 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf);
 static ssize_t ahci_activity_store(struct ata_device *dev,
 				   enum sw_activity val);
 static void ahci_init_sw_activity(struct ata_link *link);
+static int ahci_ems_bios_workaround(struct pci_dev *pdev);
 
 static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
@@ -1115,6 +1120,9 @@ static void ahci_start_port(struct ata_port *ap)
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ata_link *link;
 	struct ahci_em_priv *emp;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	ssize_t rc;
+	int i;
 
 	/* enable FIS reception */
 	ahci_start_fis_rx(ap);
@@ -1126,7 +1134,16 @@ static void ahci_start_port(struct ata_port *ap)
 	if (ap->flags & ATA_FLAG_EM) {
 		ata_for_each_link(link, ap, EDGE) {
 			emp = &pp->em_priv[link->pmp];
-			ahci_transmit_led_message(ap, emp->led_state, 4);
+			if (hpriv->flags & AHCI_HFLAG_BIOS_WORKAROUND) {
+				for (i = 0; i < MAX_RETRY; i++) {
+					rc = ahci_transmit_led_message(ap, emp->led_state, 4);
+					if (rc == -EBUSY)
+						udelay(100);
+					else
+						break;
+				}
+			} else
+				ahci_transmit_led_message(ap, emp->led_state, 4);
 		}
 	}
 
@@ -1331,7 +1348,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 	em_ctl = readl(mmio + HOST_EM_CTL);
 	if (em_ctl & EM_CTL_TM) {
 		spin_unlock_irqrestore(ap->lock, flags);
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	/*
@@ -2553,6 +2570,23 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
 	}
 }
 
+static int ahci_ems_bios_workaround(struct pci_dev *pdev)
+{
+	u8 tmp;
+
+	/* Transmit bit may still be busy in AHCI mode */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device >= 0x2821) {
+		pci_read_config_byte(pdev, SCC_REG, &tmp);
+
+		if (tmp & AHCI_MODE)
+			return 1;
+		else
+			return 0;
+	}
+
+	return 0;
+}
+
 static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id broken_systems[] = {
@@ -2656,6 +2690,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
 		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
 
+	/* Enclosure management transmit bit maybe busy during driver init */
+	if (ahci_ems_bios_workaround(pdev))
+		hpriv->flags |= AHCI_HFLAG_BIOS_WORKAROUND;
+
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
 		pci_enable_msi(pdev);
 
