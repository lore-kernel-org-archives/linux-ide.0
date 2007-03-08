From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-acpi: Add infrastructure for drivers to use
 _GTM/_STM methods
Date: Thu, 8 Mar 2007 23:15:04 +0000
Message-ID: <20070308231504.3d22eb3e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60606 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030759AbXCHWKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:10:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c linux-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c	2007-03-08 15:59:20.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c	2007-03-08 16:44:25.000000000 +0000
@@ -15,7 +15,7 @@
 #include <linux/libata.h>
 #include <linux/pci.h>
 #include "libata.h"
-
+#include "libata-acpi.h"
 #include <acpi/acpi_bus.h>
 #include <acpi/acnames.h>
 #include <acpi/acnamesp.h>
@@ -685,3 +703,88 @@
 }
 
 
+int ata_acpi_gtm(const struct ata_port *ap, void *handle, struct acpi_gtm *gtm)
+{
+	acpi_status status;
+	struct acpi_buffer output;
+
+	output.length = ACPI_ALLOCATE_BUFFER;
+	output.pointer = NULL;
+
+	status = acpi_evaluate_object(handle, "_GTM", NULL, &output);
+
+	if (ACPI_FAILURE(status)) {
+		ata_port_printk(ap, KERN_ERR, "ACPI get timing mode failed.\n");
+		return -EINVAL;
+	}
+	if (output.length < sizeof(struct acpi_gtm) || output.pointer == NULL) {
+		ata_port_printk(ap, KERN_ERR, "ACPI get timing provided invalid data.\n");
+		return -EINVAL;
+	}
+	memcpy(gtm, output.pointer, sizeof(struct acpi_gtm));
+	kfree(output.pointer);
+	return 0;
+}
+
+int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm)
+{
+	acpi_status status;
+	struct acpi_object_list         input;
+	union acpi_object               in_params[3];
+
+	in_params[0].type = ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length = sizeof(struct acpi_gtm);
+	in_params[0].buffer.pointer = (u8 *)stm;
+	/* Buffers for id may need byteswapping ? */
+	in_params[1].type = ACPI_TYPE_BUFFER;
+	in_params[1].buffer.length = 512;
+	in_params[1].buffer.pointer = (u8 *)ap->device[0].id;
+	in_params[2].type = ACPI_TYPE_BUFFER;
+	in_params[2].buffer.length = 512;
+	in_params[2].buffer.pointer = (u8 *)ap->device[1].id;
+
+	input.count = 3;
+	input.pointer = in_params;
+
+	status = acpi_evaluate_object(handle, "_STM", &input, NULL);
+
+	if (ACPI_FAILURE(status)) {
+		ata_port_printk(ap, KERN_ERR, "ACPI set timing mode failed.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void *ata_pata_find_handle(struct device *dev, int port)
+{
+	acpi_handle handle;
+	acpi_integer devfn;
+
+	if (noacpi)
+		return NULL;
+	if (pata_get_dev_handle(dev, &handle, &devfn) < 0)
+		return NULL;
+	return acpi_get_child(handle, port);
+}
+
+void *ata_pata_acpi_handle(const struct ata_port *ap)
+{
+	return ata_pata_find_handle(ap->host->dev, ap->port_no);
+}
+
+int ata_pata_acpi_present(struct pci_dev *pdev)
+{
+	int present = 0;
+
+	if(ata_pata_find_handle(&pdev->dev, 0))
+		present |= 1;
+	if(ata_pata_find_handle(&pdev->dev, 1))
+		present |= 2;
+	return present;
+}
+
+
+EXPORT_SYMBOL_GPL(ata_acpi_gtm);
+EXPORT_SYMBOL_GPL(ata_acpi_stm);
+EXPORT_SYMBOL_GPL(ata_pata_acpi_handle);
+EXPORT_SYMBOL_GPL(ata_pata_acpi_present);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-acpi.h linux-2.6.21-rc3-mm2/drivers/ata/libata-acpi.h
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-acpi.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-acpi.h	2007-03-08 16:44:25.000000000 +0000
@@ -0,0 +1,47 @@
+/*
+ *  libata-acpi.h - helper library for ATA ACPI drivers
+ *
+ *  Copyright 2007 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2007 Alan Cox
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ */
+
+#ifndef __LIBATA_ACPI_H__
+#define __LIBATA_ACPI_H__
+
+struct acpi_drive
+{
+	u32 pio;
+	u32 dma;
+};
+
+struct acpi_gtm {
+	struct acpi_drive drive[2];
+	u32 flags;
+};
+
+extern int ata_acpi_gtm(const struct ata_port *p, void *handle, struct acpi_gtm *gtm);
+extern int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm);
+extern void *ata_pata_acpi_handle(const struct ata_port *ap);
+extern int ata_pata_acpi_present(struct pci_dev *pdev);
+
+#endif
