From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] sata_mv: Use devm_kcalloc() in mv_platform_probe()
Date: Tue, 18 Apr 2017 22:03:51 +0200
Message-ID: <139a8a18-37ae-a87f-9fec-a05670325f66@users.sourceforge.net>
References: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:51975 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932475AbdDRUD5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 18 Apr 2017 16:03:57 -0400
In-Reply-To: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 21:36:43 +0200

* Multiplications for the size determination of memory allocations
  indicated that array data structures should be processed.
  Thus use the corresponding function "devm_kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of data types by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/sata_mv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index b66bcda88320..49abe386c7f6 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4118,13 +4118,15 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	if (!host || !hpriv)
 		return -ENOMEM;
-	hpriv->port_clks = devm_kzalloc(&pdev->dev,
-					sizeof(struct clk *) * n_ports,
+	hpriv->port_clks = devm_kcalloc(&pdev->dev,
+					n_ports,
+					sizeof(*hpriv->port_clks),
 					GFP_KERNEL);
 	if (!hpriv->port_clks)
 		return -ENOMEM;
-	hpriv->port_phys = devm_kzalloc(&pdev->dev,
-					sizeof(struct phy *) * n_ports,
+	hpriv->port_phys = devm_kcalloc(&pdev->dev,
+					n_ports,
+					sizeof(*hpriv->port_phys),
 					GFP_KERNEL);
 	if (!hpriv->port_phys)
 		return -ENOMEM;
-- 
2.12.2

