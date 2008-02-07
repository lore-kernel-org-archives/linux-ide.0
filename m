From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] pata_via: fix SATA cable detection on cx700
Date: Thu, 07 Feb 2008 10:18:53 +0900
Message-ID: <47AA5C7D.7000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:11267 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759335AbYBGBTD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 20:19:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2077000rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 06 Feb 2008 17:19:00 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

The first port of cx700 is SATA.  Fix cable detection.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_via.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 39627ab..d119a68 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -84,6 +84,7 @@ enum {
 	VIA_BAD_ID	= 0x100, /* Has wrong vendor ID (0x1107) */
 	VIA_BAD_AST	= 0x200, /* Don't touch Address Setup Timing */
 	VIA_NO_ENABLES	= 0x400, /* Has no enablebits */
+	VIA_SATA_PATA	= 0x800, /* SATA/PATA combined configuration */
 };
 
 /*
@@ -100,7 +101,7 @@ static const struct via_isa_bridge {
 	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_SATA_PATA },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_NO_ENABLES},
 	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -172,6 +173,9 @@ static int via_cable_detect(struct ata_port *ap) {
 	if (via_cable_override(pdev))
 		return ATA_CBL_PATA40_SHORT;
 
+	if ((config->flags & VIA_SATA_PATA) && ap->port_no == 0)
+		return ATA_CBL_SATA;
+
 	/* Early chips are 40 wire */
 	if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
 		return ATA_CBL_PATA40;
