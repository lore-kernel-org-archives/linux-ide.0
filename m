From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ide: Use kmalloc_array() in hwif_init()
Date: Sat, 24 Sep 2016 09:49:07 +0200
Message-ID: <c28ba397-0b6c-fe47-24d8-002545b4844f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 09:39:03 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ide/ide-probe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 0b63fac..645a67b 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -973,8 +973,9 @@ static int hwif_init(ide_hwif_t *hwif)
 	if (!hwif->sg_max_nents)
 		hwif->sg_max_nents = PRD_ENTRIES;
 
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist)*hwif->sg_max_nents,
-				 GFP_KERNEL);
+	hwif->sg_table = kmalloc_array(hwif->sg_max_nents,
+				       sizeof(*hwif->sg_table),
+				       GFP_KERNEL);
 	if (!hwif->sg_table) {
 		printk(KERN_ERR "%s: unable to allocate SG table.\n", hwif->name);
 		goto out;
-- 
2.10.0
