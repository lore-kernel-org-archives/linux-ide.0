From: akpm@linux-foundation.org
Subject: [patch 12/25] libata: ACPI checks for 80wire cable: headers
Date: Fri, 10 Aug 2007 13:59:41 -0700
Message-ID: <200708102059.l7AKxfm8008602@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54931 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763339AbXHJVQO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

We can use the ACPI mode information with several drivers as a hint to cable
type.  If the ACPI mode set by the BIOS is faster than UDMA33 then we know the
BIOS thinks there are 80wire cables.  If it doesn't set such a mode or it has
no ACPI method then we get no further information and can rely on existing
approaches

Introduce the function headers needed. Null it out for non ACPI boxes

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/libata.h |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN include/linux/libata.h~libata-acpi-checks-for-80wire-cable-headers include/linux/libata.h
--- a/include/linux/libata.h~libata-acpi-checks-for-80wire-cable-headers
+++ a/include/linux/libata.h
@@ -1053,6 +1053,12 @@ static inline int ata_port_max_devices(c
 	return 1;
 }
 
+/* libata-acpi.c */
+#ifdef CONFIG_ATA_ACPI
+extern int ata_acpi_cbl_80wire(struct ata_port *ap);
+#else
+static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
+#endif
 
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
_
