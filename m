From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] sata_fsl: fix error handling of irq_of_parse_and_map
Date: Fri, 14 Nov 2014 13:39:05 -0800
Message-ID: <20141114213905.GA25228@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:48115 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbaKNVjI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Nov 2014 16:39:08 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so18107758iec.7
        for <linux-ide@vger.kernel.org>; Fri, 14 Nov 2014 13:39:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Joe Perches <joe@perches.com>, Paul Bolle <pebolle@tiscali.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

irq_of_parse_and_map() returns 0 on error (the result is unsigned int),
so testing for negative result never works.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

Not tested, found by casual code inspection.

 drivers/ata/sata_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 4217415..f9054cd 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1488,7 +1488,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	host_priv->csr_base = csr_base;
 
 	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	if (irq < 0) {
+	if (!irq) {
 		dev_err(&ofdev->dev, "invalid irq from platform\n");
 		goto error_exit_with_cleanup;
 	}
-- 
2.1.0.rc2.206.gedb03e5


-- 
Dmitry
