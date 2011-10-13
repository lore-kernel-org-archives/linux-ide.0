From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] pata_legacy: use PIO mask defines
Date: Thu, 13 Oct 2011 15:08:40 +0200
Message-ID: <201110131508.40873.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-dy0-f46.google.com ([209.85.220.46]:36825 "EHLO
	mail-dy0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab1JMNUx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 09:20:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_legacy: use PIO mask defines

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
earlier references:
https://lkml.org/lkml/2009/11/25/363

 drivers/ata/pata_legacy.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: b/drivers/ata/pata_legacy.c
===================================================================
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -817,29 +817,29 @@ static struct ata_port_operations winbon
 };
 
 static struct legacy_controller controllers[] = {
-	{"BIOS",	&legacy_port_ops, 	0x1F,
+	{"BIOS",	&legacy_port_ops, 	ATA_PIO4,
 			ATA_FLAG_NO_IORDY,	0,			NULL },
-	{"Snooping", 	&simple_port_ops, 	0x1F,
+	{"Snooping", 	&simple_port_ops, 	ATA_PIO4,
 			0,			0,			NULL },
-	{"PDC20230",	&pdc20230_port_ops,	0x7,
+	{"PDC20230",	&pdc20230_port_ops,	ATA_PIO2,
 			ATA_FLAG_NO_IORDY,
 			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE,	NULL },
-	{"HT6560A",	&ht6560a_port_ops,	0x07,
+	{"HT6560A",	&ht6560a_port_ops,	ATA_PIO2,
 			ATA_FLAG_NO_IORDY,	0,			NULL },
-	{"HT6560B",	&ht6560b_port_ops,	0x1F,
+	{"HT6560B",	&ht6560b_port_ops,	ATA_PIO4,
 			ATA_FLAG_NO_IORDY,	0,			NULL },
-	{"OPTI82C611A",	&opti82c611a_port_ops,	0x0F,
+	{"OPTI82C611A",	&opti82c611a_port_ops,	ATA_PIO3,
 			0,			0,			NULL },
-	{"OPTI82C46X",	&opti82c46x_port_ops,	0x0F,
+	{"OPTI82C46X",	&opti82c46x_port_ops,	ATA_PIO3,
 			0,			0,			NULL },
-	{"QDI6500",	&qdi6500_port_ops,	0x07,
+	{"QDI6500",	&qdi6500_port_ops,	ATA_PIO2,
 			ATA_FLAG_NO_IORDY,
 			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE,    qdi_port },
-	{"QDI6580",	&qdi6580_port_ops,	0x1F,
+	{"QDI6580",	&qdi6580_port_ops,	ATA_PIO4,
 			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE, qdi_port },
-	{"QDI6580DP",	&qdi6580dp_port_ops,	0x1F,
+	{"QDI6580DP",	&qdi6580dp_port_ops,	ATA_PIO4,
 			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE, qdi_port },
-	{"W83759A",	&winbond_port_ops,	0x1F,
+	{"W83759A",	&winbond_port_ops,	ATA_PIO4,
 			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE,
 								winbond_port }
 };
