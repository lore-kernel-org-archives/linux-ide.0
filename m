From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc6+mboxjeff 1/3] pata_sis: compilation fix
Date: Sat, 30 Jun 2007 03:42:36 +0200
Message-ID: <200706300342.37838.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39584 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752205AbXF3CNH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 22:13:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

The exported symbol ata_port_info sis_info133_for_sata has 
not to be declared static.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/pata_sis.c	2007-06-30 02:42:43.000000000 +0200
+++ b/drivers/ata/pata_sis.c	2007-06-30 02:52:06.000000000 +0200
@@ -774,7 +774,7 @@
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_ops,
 };
-static const struct ata_port_info sis_info133_for_sata = {
+const struct ata_port_info sis_info133_for_sata = {
 	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */

