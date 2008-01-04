From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/15] ide: remove unused ide_hwgroup_t fields
Date: Fri, 04 Jan 2008 22:25:01 +0100
Message-ID: <20080104212501.6978.42272.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120AbYADVNZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833654ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:24 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -628,8 +628,7 @@ typedef int (ide_expiry_t)(ide_drive_t *
 typedef struct hwgroup_s {
 		/* irq handler, if active */
 	ide_startstop_t	(*handler)(ide_drive_t *);
-		/* irq handler, suspended if active */
-	ide_startstop_t	(*handler_save)(ide_drive_t *);
+
 		/* BOOL: protects all fields below */
 	volatile int busy;
 		/* BOOL: wake us up on timer expiry */
@@ -644,25 +643,18 @@ typedef struct hwgroup_s {
 		/* ptr to current hwif in linked-list */
 	ide_hwif_t *hwif;
 
-		/* for pci chipsets */
-	struct pci_dev *pci_dev;
-
 		/* current request */
 	struct request *rq;
+
 		/* failsafe timer */
 	struct timer_list timer;
-		/* local copy of current write rq */
-	struct request wrq;
 		/* timeout value during long polls */
 	unsigned long poll_timeout;
 		/* queried upon timeouts */
 	int (*expiry)(ide_drive_t *);
-		/* ide_system_bus_speed */
-	int pio_clock;
+
 	int req_gen;
 	int req_gen_timer;
-
-	unsigned char cmd_buf[4];
 } ide_hwgroup_t;
 
 typedef struct ide_driver_s ide_driver_t;
