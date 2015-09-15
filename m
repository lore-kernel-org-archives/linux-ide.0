From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH v2] ata: pata_macio: Fix module autoload for OF platform
 driver
Date: Tue, 15 Sep 2015 18:31:14 +0200
Message-ID: <20150915163114.GA5152@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37909 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbbIOQbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Sep 2015 12:31:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

Link: https://lkml.org/lkml/2015/7/30/519
Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/ata/pata_macio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index b002858..e60adbb 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1344,6 +1344,7 @@ static struct of_device_id pata_macio_match[] =
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, pata_macio_patch);
 
 static struct macio_driver pata_macio_driver =
 {
-- 
2.4.6

