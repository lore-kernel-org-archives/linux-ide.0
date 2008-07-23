From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] ide: ide-cd.c blocklen is a big-endian value
Date: Wed, 23 Jul 2008 15:31:36 -0700
Message-ID: <1216852296.30386.21.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-next <linux-next@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Noticed by sparse between next-20080722 and next-20080723

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ide/ide-cd.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 3a6fef5..a384500 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1318,17 +1318,17 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 	 * Sanity check the given block size
 	 */
 	switch (capbuf.blocklen) {
-	case 512:
-	case 1024:
-	case 2048:
-	case 4096:
+	case __constant_cpu_to_be32(512):
+	case __constant_cpu_to_be32(1024):
+	case __constant_cpu_to_be32(2048):
+	case __constant_cpu_to_be32(4096):
 		break;
 	default:
 		printk(KERN_ERR "%s: weird block size %u\n",
 			drive->name, capbuf.blocklen);
 		printk(KERN_ERR "%s: default to 2kb block size\n",
 			drive->name);
-		capbuf.blocklen = 2048;
+		capbuf.blocklen = __constant_cpu_to_be32(2048);
 		break;
 	}
 
-- 
1.5.6.4.570.g052e
