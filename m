From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v2 03/19] libata: samsung_cf: fix handling platform_get_irq
 result
Date: Fri, 25 Sep 2015 08:43:31 +0200
Message-ID: <1443163411-25668-1-git-send-email-a.hajda@samsung.com>
References: <20150924145317.GA25415@mtj.duckdns.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150924145317.GA25415@mtj.duckdns.org>
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
v2: changed type of irq field
---
 drivers/ata/pata_samsung_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index cbb5a47..f6facd6 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -70,7 +70,7 @@ struct s3c_ide_info {
 	struct clk *clk;
 	void __iomem *ide_addr;
 	void __iomem *sfr_addr;
-	unsigned int irq;
+	int irq;
 	enum s3c_cpu_type cpu_type;
 	unsigned int fifo_status_reg;
 };
-- 
1.9.1
