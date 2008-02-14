From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 10/11] ata: fix sparse warning in pata_acpi.c
Date: Wed, 13 Feb 2008 21:14:31 -0800
Message-ID: <1202966071.2748.26.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:23231 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYBNFOf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:14:35 -0500
Received: by py-out-1112.google.com with SMTP id u52so305312pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:14:34 -0800 (PST)
In-Reply-To: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

drivers/ata/pata_acpi.c:80:2: warning: returning void-valued expression

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/pata_acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 244098a..bdc3b9d 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -77,8 +77,8 @@ static int pacpi_cable_detect(struct ata_port *ap)
 
 static void pacpi_error_handler(struct ata_port *ap)
 {
-	return ata_bmdma_drive_eh(ap, pacpi_pre_reset, ata_std_softreset,
-				  NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, pacpi_pre_reset, ata_std_softreset, NULL,
+			   ata_std_postreset);
 }
 
 /**
-- 
1.5.4.1.1278.gc75be


