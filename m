From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] libata: Add missing newline at end of file
Date: Thu, 23 Aug 2018 23:23:06 +0200
Message-ID: <20180823212306.17134-1-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jason Yan <yanaijie@huawei.com>, "Signed-off-by : Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

With gcc 4.1.2:

    drivers/ata/libata-core.c:7396:33: warning: no newline at end of file

Fixes: 2fa4a32613c9182b ("scsi: libsas: dynamically allocate and free ata host")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 984b37647b2f025c..c26dba0ee3ce598f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7393,4 +7393,4 @@ EXPORT_SYMBOL_GPL(ata_cable_unknown);
 EXPORT_SYMBOL_GPL(ata_cable_ignore);
 EXPORT_SYMBOL_GPL(ata_cable_sata);
 EXPORT_SYMBOL_GPL(ata_host_get);
-EXPORT_SYMBOL_GPL(ata_host_put);
\ No newline at end of file
+EXPORT_SYMBOL_GPL(ata_host_put);
-- 
2.17.1
