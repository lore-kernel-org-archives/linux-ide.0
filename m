From: Colin King <colin.king@canonical.com>
Subject: [PATCH] libata: zpodd: make arrays cdb static, reduces object code size
Date: Wed,  6 Sep 2017 09:56:29 +0100
Message-ID: <20170906085629.23938-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays cdb on the stack, instead make them static.
Makes the object code smaller by 230 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   3797	    240	      0	   4037	    fc5	drivers/ata/libata-zpodd.o

After:
   text	   data	    bss	    dec	    hex	filename
   3407	    400	      0	   3807	    edf	drivers/ata/libata-zpodd.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/libata-zpodd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 8a01d09ac4db..23a62e4015d0 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -34,7 +34,7 @@ struct zpodd {
 static int eject_tray(struct ata_device *dev)
 {
 	struct ata_taskfile tf;
-	const char cdb[] = {  GPCMD_START_STOP_UNIT,
+	static const char cdb[] = {  GPCMD_START_STOP_UNIT,
 		0, 0, 0,
 		0x02,     /* LoEj */
 		0, 0, 0, 0, 0, 0, 0,
@@ -55,7 +55,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 	unsigned int ret;
 	struct rm_feature_desc *desc = (void *)(buf + 8);
 	struct ata_taskfile tf;
-	char cdb[] = {  GPCMD_GET_CONFIGURATION,
+	static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
 			0, 0, 0,/* reserved */
-- 
2.14.1
