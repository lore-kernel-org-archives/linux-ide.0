From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: drivers/ide/ide_platform.c: use resource_size()
Date: Mon, 23 Nov 2009 13:24:20 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5C04@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:56557 "EHLO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbZKWSYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 13:24:15 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Use resource_size() for devm_{ioremap/io_port_map}.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index b579fbe..42965b3 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -81,14 +81,14 @@ static int __devinit plat_ide_probe(struct platform_device *pdev)
 
 	if (mmio) {
 		base = devm_ioremap(&pdev->dev,
-			res_base->start, res_base->end - res_base->start + 1);
+			res_base->start, resource_size(res_base));
 		alt_base = devm_ioremap(&pdev->dev,
-			res_alt->start, res_alt->end - res_alt->start + 1);
+			res_alt->start, resource_size(res_alt));
 	} else {
 		base = devm_ioport_map(&pdev->dev,
-			res_base->start, res_base->end - res_base->start + 1);
+			res_base->start, resource_size(res_base));
 		alt_base = devm_ioport_map(&pdev->dev,
-			res_alt->start, res_alt->end - res_alt->start + 1);
+			res_alt->start, resource_size(res_alt));
 	}
 
 	memset(&hw, 0, sizeof(hw)); 
