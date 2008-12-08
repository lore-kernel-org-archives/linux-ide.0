From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 2/3] pata_hpt366: fix cable detection
Date: Mon, 08 Dec 2008 18:52:52 +0900
Message-ID: <493CEE74.3060601@kernel.org>
References: <493CED7A.2010505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36620 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbYLHJxK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2008 04:53:10 -0500
In-Reply-To: <493CED7A.2010505@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

hpt366 is strange in that its cable detection register uses the higher
bit for master, so the testing should be 2 >> port_no instead of 1 <<
port_no.  Fix it.

Info provided by Alan Cox.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/pata_hpt366.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -215,7 +215,7 @@ static int hpt36x_cable_detect(struct at
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, 0x5A, &ata66);
-	if (ata66 & (1 << ap->port_no))
+	if (ata66 & (2 >> ap->port_no))
 		return ATA_CBL_PATA40;
 	return ATA_CBL_PATA80;
 }
