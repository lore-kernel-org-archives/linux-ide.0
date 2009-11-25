From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 71/86] pata_sch: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:10:53 +0100
Message-ID: <20091125171053.5446.22658.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52976 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933772AbZKYRLb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:11:31 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_sch: add 32-bit PIO support

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_sch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_sch.c
===================================================================
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -76,7 +76,7 @@ static struct scsi_host_template sch_sht
 };
 
 static struct ata_port_operations sch_pata_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.cable_detect		= ata_cable_unknown,
 	.set_piomode		= sch_set_piomode,
 	.set_dmamode		= sch_set_dmamode,
