From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_uli: hardreset is broken
Date: Sat, 21 Jun 2008 16:07:32 +0900
Message-ID: <485CA8B4.7040609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34999 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYFUHHw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Jun 2008 03:07:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, casteyde.christian@free.fr

sata_uli can't do hardresets reliably and lock up.  This went
unnoticed till now as softreset was the default and hardreset was only
used after softreset failed.

Reported by Christian Casteyde in bz#10860.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christian Casteyde <casteyde.christian@free.fr>
---
 drivers/ata/sata_uli.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index f277cea..db529b8 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -83,6 +83,7 @@ static struct ata_port_operations uli_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 	.scr_read		= uli_scr_read,
 	.scr_write		= uli_scr_write,
+	.hardreset		= ATA_OP_NULL,
 };
 
 static const struct ata_port_info uli_port_info = {
