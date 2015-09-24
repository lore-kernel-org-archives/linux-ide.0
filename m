From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 03/19] libata: samsung_cf: fix handling platform_get_irq result
Date: Thu, 24 Sep 2015 16:00:11 +0200
Message-ID: <1443103227-25612-4-git-send-email-a.hajda@samsung.com>
References: <1443103227-25612-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1443103227-25612-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The function can return negative value.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2046107

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi,

To avoid problems with too many mail recipients I have sent whole
patchset only to LKML. Anyway patches have no dependencies.

Regards
Andrzej
---
 drivers/ata/pata_samsung_cf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index cbb5a47..e028763 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -510,8 +510,6 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	info->irq = platform_get_irq(pdev, 0);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	info->ide_addr = devm_ioremap_resource(dev, res);
@@ -551,9 +549,10 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 
 	info->cpu_type = cpu_type;
 
+	ret = platform_get_irq(pdev, 0);
+	info->irq = ret > 0 ? ret : 0;
 	if (info->irq <= 0) {
 		ap->flags |= ATA_FLAG_PIO_POLLING;
-		info->irq = 0;
 		ata_port_desc(ap, "no IRQ, using PIO polling\n");
 	}
 
-- 
1.9.1
