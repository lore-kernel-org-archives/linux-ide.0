From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/5] ide: remove ide_host_alloc_all()
Date: Tue, 19 Aug 2008 20:34:10 +0200
Message-ID: <200808192034.10833.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:24560 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbYHSShV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 14:37:21 -0400
Received: by gv-out-0910.google.com with SMTP id e6so45195gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 11:37:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Remove no longer used ide_host_alloc_all().

* Add MAX_HOST_PORTS define and use it instead of MAX_HWIFS
  as the maximum number of host ports possible.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   31 +++++++++----------------------
 include/linux/ide.h     |    5 +++--
 2 files changed, 12 insertions(+), 24 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1544,8 +1544,7 @@ static void ide_free_port_slot(int idx)
 	mutex_unlock(&ide_cfg_mtx);
 }
 
-struct ide_host *ide_host_alloc_all(const struct ide_port_info *d,
-				    hw_regs_t **hws)
+struct ide_host *ide_host_alloc(const struct ide_port_info *d, hw_regs_t **hws)
 {
 	struct ide_host *host;
 	int i;
@@ -1554,7 +1553,7 @@ struct ide_host *ide_host_alloc_all(cons
 	if (host == NULL)
 		return NULL;
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		ide_hwif_t *hwif;
 		int idx;
 
@@ -1596,18 +1595,6 @@ struct ide_host *ide_host_alloc_all(cons
 
 	return host;
 }
-EXPORT_SYMBOL_GPL(ide_host_alloc_all);
-
-struct ide_host *ide_host_alloc(const struct ide_port_info *d, hw_regs_t **hws)
-{
-	hw_regs_t *hws_all[MAX_HWIFS];
-	int i;
-
-	for (i = 0; i < MAX_HWIFS; i++)
-		hws_all[i] = (i < 4) ? hws[i] : NULL;
-
-	return ide_host_alloc_all(d, hws_all);
-}
 EXPORT_SYMBOL_GPL(ide_host_alloc);
 
 int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
@@ -1616,7 +1603,7 @@ int ide_host_register(struct ide_host *h
 	ide_hwif_t *hwif, *mate = NULL;
 	int i, j = 0;
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		hwif = host->ports[i];
 
 		if (hwif == NULL) {
@@ -1644,7 +1631,7 @@ int ide_host_register(struct ide_host *h
 		ide_port_init_devices(hwif);
 	}
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		hwif = host->ports[i];
 
 		if (hwif == NULL)
@@ -1661,7 +1648,7 @@ int ide_host_register(struct ide_host *h
 			ide_port_tune_devices(hwif);
 	}
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		hwif = host->ports[i];
 
 		if (hwif == NULL)
@@ -1685,7 +1672,7 @@ int ide_host_register(struct ide_host *h
 			ide_acpi_port_init_devices(hwif);
 	}
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		hwif = host->ports[i];
 
 		if (hwif == NULL)
@@ -1698,7 +1685,7 @@ int ide_host_register(struct ide_host *h
 			hwif_register_devices(hwif);
 	}
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		hwif = host->ports[i];
 
 		if (hwif == NULL)
@@ -1743,7 +1730,7 @@ void ide_host_free(struct ide_host *host
 	ide_hwif_t *hwif;
 	int i;
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		hwif = host->ports[i];
 
 		if (hwif == NULL)
@@ -1761,7 +1748,7 @@ void ide_host_remove(struct ide_host *ho
 {
 	int i;
 
-	for (i = 0; i < MAX_HWIFS; i++) {
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
 		if (host->ports[i])
 			ide_unregister(host->ports[i]);
 	}
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -830,8 +830,10 @@ typedef struct hwif_s {
 #endif
 } ____cacheline_internodealigned_in_smp ide_hwif_t;
 
+#define MAX_HOST_PORTS 4
+
 struct ide_host {
-	ide_hwif_t	*ports[MAX_HWIFS];
+	ide_hwif_t	*ports[MAX_HOST_PORTS];
 	unsigned int	n_ports;
 	struct device	*dev[2];
 	unsigned int	(*init_chipset)(struct pci_dev *);
@@ -1474,7 +1476,6 @@ void ide_undecoded_slave(ide_drive_t *);
 
 void ide_port_apply_params(ide_hwif_t *);
 
-struct ide_host *ide_host_alloc_all(const struct ide_port_info *, hw_regs_t **);
 struct ide_host *ide_host_alloc(const struct ide_port_info *, hw_regs_t **);
 void ide_host_free(struct ide_host *);
 int ide_host_register(struct ide_host *, const struct ide_port_info *,
