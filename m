From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/4] libata: ACPI checks for 80wire cable
Date: Thu, 26 Jul 2007 18:36:44 +0100
Message-ID: <20070726183644.5dbbb691@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:46893 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762636AbXGZR3x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 13:29:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Provide actual methods for checking if the ACPI support thinks the cable
is 80wire, or doesn't know

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-acpi.c linux-2.6.23rc1-mm1/drivers/ata/libata-acpi.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-acpi.c	2007-07-26 15:01:53.015737336 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/libata-acpi.c	2007-07-26 15:15:48.676697560 +0100
@@ -296,6 +296,44 @@
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
