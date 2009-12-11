From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] pata_octeon_cf.c: use resource_size()
Date: Thu, 10 Dec 2009 20:03:10 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901FB0FB6@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:56468 "EHLO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757766AbZLKBDH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Dec 2009 20:03:07 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

It appears the size for cs1 is calculated using the wrong resource.
Use the function resource_size to get the correct value.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index d6f6956..37ef416 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -853,7 +853,7 @@ static int __devinit octeon_cf_probe(struct platform_device *pdev)
 			return -EINVAL;
 
 		cs1 = devm_ioremap_nocache(&pdev->dev, res_cs1->start,
-					   res_cs0->end - res_cs1->start + 1);
+					   resource_size(res_cs1));
 
 		if (!cs1)
 			return -ENOMEM; 
