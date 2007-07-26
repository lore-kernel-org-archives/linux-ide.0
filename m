From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/4] libata: ACPI checks for 80wire cable
Date: Thu, 26 Jul 2007 18:36:47 +0100
Message-ID: <20070726183647.1ee7f2d4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:46894 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751168AbXGZR3x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 13:29:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

We can use the ACPI mode information with several drivers as a hint to
cable type. If the ACPI mode set by the BIOS is faster than UDMA33 then
we know the BIOS thinks there are 80wire cables. If it doesn't set such a
mode or it has no ACPI method then we get no further information and can
rely on existing approaches

Introduce the function headers needed. Null it out for non ACPI boxes

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/include/linux/libata.h linux-2.6.23rc1-mm1/include/linux/libata.h
--- linux.vanilla-2.6.23rc1-mm1/include/linux/libata.h	2007-07-26 15:02:58.000000000 +0100
+++ linux-2.6.23rc1-mm1/include/linux/libata.h	2007-07-26 15:37:59.000000000 +0100
@@ -883,6 +916,12 @@
 				  ATA_TIMING_CYCLE | ATA_TIMING_UDMA,
 };
 
+/* libata-acpi.c */
+#ifdef CONFIG_ATA_ACPI
+extern int ata_acpi_cbl_80wire(struct ata_port *ap);
+#else
+static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
+#endif
 
 #ifdef CONFIG_PCI
 struct pci_bits {
