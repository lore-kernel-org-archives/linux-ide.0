From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ata: libahci: Use kcalloc() in
 ahci_platform_get_resources()
Date: Tue, 18 Apr 2017 22:01:45 +0200
Message-ID: <11086550-7b2b-9284-1512-fb501904f8a2@users.sourceforge.net>
References: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 21:07:34 +0200

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/libahci_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index aaa761b9081c..c68ea903b5bf 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -408,8 +408,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	sz = hpriv->nports * sizeof(*hpriv->target_pwrs);
-	hpriv->target_pwrs = kzalloc(sz, GFP_KERNEL);
+	hpriv->target_pwrs = kcalloc(hpriv->nports,
+				     sizeof(*hpriv->target_pwrs),
+				     GFP_KERNEL);
 	if (!hpriv->target_pwrs) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.12.2

