From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ata_piix: enable 32bit PIO on SATA piix
Date: Mon, 11 Jan 2010 17:03:11 +0900
Message-ID: <4B4ADB3F.2080505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59919 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651Ab0AKH5i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 02:57:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Commit 871af1210f13966ab911ed2166e4ab2ce775b99d enabled 32bit PIO for
PATA piix but didn't for SATA.  There's no reason not to use 32bit PIO
on SATA piix.  Enable it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/ata_piix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: ata/drivers/ata/ata_piix.c
===================================================================
--- ata.orig/drivers/ata/ata_piix.c
+++ ata/drivers/ata/ata_piix.c
@@ -329,7 +329,7 @@ static struct ata_port_operations ich_pa
 };
 
 static struct ata_port_operations piix_sata_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 };
 
 static struct ata_port_operations piix_sidpr_sata_ops = {
