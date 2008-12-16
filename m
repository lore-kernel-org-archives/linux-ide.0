From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/9] ide: remove ide_pci_enablebit_t typedef
Date: Tue, 16 Dec 2008 20:32:04 +0100
Message-ID: <20081216193204.3959.51518.sendpatchset@localhost.localdomain>
References: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:64756 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867AbYLPTcM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 14:32:12 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so4417971bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 11:32:12 -0800 (PST)
In-Reply-To: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove ide_pci_enablebit_t typedef

Remove needless parens while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    2 +-
 include/linux/ide.h     |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -471,7 +471,7 @@ void ide_pci_setup_ports(struct pci_dev 
 	 */
 
 	for (port = 0; port < channels; ++port) {
-		const ide_pci_enablebit_t *e = &(d->enablebits[port]);
+		const struct ide_pci_enablebit *e = &d->enablebits[port];
 
 		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
 		    (tmp & e->mask) != e->val)) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1301,11 +1301,11 @@ static inline int ide_hwif_setup_dma(ide
 }
 #endif
 
-typedef struct ide_pci_enablebit_s {
+struct ide_pci_enablebit {
 	u8	reg;	/* byte pci reg holding the enable-bit */
 	u8	mask;	/* mask to isolate the enable-bit */
 	u8	val;	/* value of masked reg when "enabled" */
-} ide_pci_enablebit_t;
+};
 
 enum {
 	/* Uses ISA control ports not PCI ones. */
@@ -1394,7 +1394,8 @@ struct ide_port_info {
 	const struct ide_port_ops	*port_ops;
 	const struct ide_dma_ops	*dma_ops;
 
-	ide_pci_enablebit_t	enablebits[2];
+	struct ide_pci_enablebit	enablebits[2];
+
 	hwif_chipset_t		chipset;
 
 	u16			max_sectors;	/* if < than the default one */
