From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/3] pata_hpt366: fix cable detection,
Date: Tue, 09 Dec 2008 17:13:19 +0900
Message-ID: <493E289F.1010000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42378 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbYLIIN4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 03:13:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rt>

pata_hpt366 is strange in that its two channels occupy two PCI
functions and both are primary channels and bit1 of PCI configuration
register 0x5A indicates cable for both channels.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ata/pata_hpt366.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -211,11 +211,15 @@ static u32 hpt36x_find_mode(struct ata_p
 
 static int hpt36x_cable_detect(struct ata_port *ap)
 {
-	u8 ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 ata66;
 
+	/*
+	 * Each channel of pata_hpt366 occupies separate PCI function
+	 * as the primary channel and bit1 indicates the cable type.
+	 */
 	pci_read_config_byte(pdev, 0x5A, &ata66);
-	if (ata66 & (1 << ap->port_no))
+	if (ata66 & 2)
 		return ATA_CBL_PATA40;
 	return ATA_CBL_PATA80;
 }
