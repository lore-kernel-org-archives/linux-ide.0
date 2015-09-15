From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH] ata: pata_macio: Fix module autoload for OF platform driver
Date: Tue, 15 Sep 2015 17:45:52 +0200
Message-ID: <20150915154552.GA3060@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32785 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbbIOPp4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Sep 2015 11:45:56 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hello,

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 drivers/ata/pata_macio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index a02f76f..aba634e 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1344,6 +1344,7 @@ static struct of_device_id pata_macio_match[] =
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, pata_macio_match);
 
 static struct macio_driver pata_macio_driver =
 {
-- 
2.4.6

