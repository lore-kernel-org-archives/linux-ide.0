From: akpm@linux-foundation.org
Subject: [patch 13/25] libata: ACPI checks for 80wire cable: implementation
Date: Fri, 10 Aug 2007 13:59:42 -0700
Message-ID: <200708102059.l7AKxgNV008605@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55978 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755899AbXHJVQ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Provide actual methods for checking if the ACPI support thinks the cable is
80wire, or doesn't know

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-acpi.c |   38 ++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+)

diff -puN drivers/ata/libata-acpi.c~libata-acpi-checks-for-80wire-cable-implementation drivers/ata/libata-acpi.c
--- a/drivers/ata/libata-acpi.c~libata-acpi-checks-for-80wire-cable-implementation
+++ a/drivers/ata/libata-acpi.c
@@ -296,6 +296,44 @@ static int ata_dev_get_GTF(struct ata_de
 }
 
 /**
+ * ata_acpi_cbl_80wire		-	Check for 80 wire cable
+ * @ap: Port to check
+ *
+ * Return 1 if the ACPI mode data for this port indicates the BIOS selected
+ * an 80wire mode.
+ */
+
+int ata_acpi_cbl_80wire(struct ata_port *ap)
+{
+	struct ata_acpi_gtm gtm;
+	int valid = 0;
+
+	/* No _GTM data, no information */
+	if (ata_acpi_gtm(ap, &gtm) < 0)
+		return 0;
+
+	/* Split timing, DMA enabled */
+	if ((gtm.flags & 0x11) == 0x11 && gtm.drive[0].dma < 55)
+		valid |= 1;
+	if ((gtm.flags & 0x14) == 0x14 && gtm.drive[1].dma < 55)
+		valid |= 2;
+	/* Shared timing, DMA enabled */
+	if ((gtm.flags & 0x11) == 0x01 && gtm.drive[0].dma < 55)
+		valid |= 1;
+	if ((gtm.flags & 0x14) == 0x04 && gtm.drive[0].dma < 55)
+		valid |= 2;
+
+	/* Drive check */
+	if ((valid & 1) && ata_dev_enabled(&ap->device[0]))
+		return 1;
+	if ((valid & 2) && ata_dev_enabled(&ap->device[1]))
+		return 1;
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
+
+/**
  * taskfile_load_raw - send taskfile registers to host controller
  * @dev: target ATA device
  * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
_
