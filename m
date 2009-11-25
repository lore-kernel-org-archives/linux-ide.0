From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 57/86] pata_opti: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:09:10 +0100
Message-ID: <20091125170910.5446.60507.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:28343 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298AbZKYRJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:09:49 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_opti: add 32-bit PIO support

There shouldn't be any problems with it as IDE opti621 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_opti.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ata/pata_opti.c
===================================================================
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -157,6 +157,8 @@ static struct ata_port_operations opti_p
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= opti_set_piomode,
 	.prereset	= opti_pre_reset,
+	.sff_data_xfer	= ata_sff_data_xfer32,
+	.port_start	= ata_sff_port_start32,
 };
 
 static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
