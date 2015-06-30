From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] ata: pmp: add quirk for Marvell 4140 SATA PMP
Date: Tue, 30 Jun 2015 16:09:49 +0200
Message-ID: <1435673389-10729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45986 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752821AbbF3OKC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jun 2015 10:10:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Lior Amsalem <alior@marvell.com>

This commit adds the necessary quirk to make the Marvell 4140 SATA PMP
work properly. This PMP doesn't like SRST on port number 4 (the host
port) so this commit marks this port as not supporting SRST.

Signed-off-by: Lior Amsalem <alior@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/libata-pmp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 7ccc084..85aa761 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -460,6 +460,13 @@ static void sata_pmp_quirks(struct ata_port *ap)
 				       ATA_LFLAG_NO_SRST |
 				       ATA_LFLAG_ASSUME_ATA;
 		}
+	} else if (vendor == 0x11ab && devid == 0x4140) {
+		/* Marvell 4140 quirks */
+		ata_for_each_link(link, ap, EDGE) {
+			/* port 4 is for SEMB device and it doesn't like SRST */
+			if (link->pmp == 4)
+				link->flags |= ATA_LFLAG_DISABLED;
+		}
 	}
 }
 
-- 
2.4.5

