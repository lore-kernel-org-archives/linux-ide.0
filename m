From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/68] ide: add hwif->port_no field
Date: Fri, 29 Jan 2010 17:05:12 +0100
Message-ID: <20100129160512.21495.75268.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753601Ab0A2QF3@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add hwif->port_no field

Add port_no field to ide_hwif_t matching port_no field used in
struct ata_port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -682,7 +682,12 @@ typedef struct hwif_s {
 
 	u8 major;	/* our major number */
 	u8 index;	/* 0 for ide0; 1 for ide1; ... */
-	u8 channel;	/* for dual-port chips: 0=primary, 1=secondary */
+
+	union {
+		/* for dual-port chips: 0=primary, 1=secondary */
+		u8 channel;
+		u8 port_no;
+	};
 
 	u32 host_flags;
 
