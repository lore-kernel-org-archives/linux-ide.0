From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 03/11] ata: fix sparse warning in sata_via.c
Date: Wed, 13 Feb 2008 21:14:11 -0800
Message-ID: <1202966051.2748.17.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:7963 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYBNFON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:14:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so160092rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:14:12 -0800 (PST)
In-Reply-To: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

drivers/ata/sata_via.c:336:2: warning: returning void-valued expression

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/sata_via.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 30caa03..0d03f44 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -333,8 +333,8 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 
 static void vt6420_error_handler(struct ata_port *ap)
 {
-	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
-				  NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset, NULL,
+			   ata_std_postreset);
 }
 
 static int vt6421_pata_cable_detect(struct ata_port *ap)
-- 
1.5.4.1.1278.gc75be


