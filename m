From: raymond pang <raymondpangxd@gmail.com>
Subject: [PATCH] libata: fix using DMA buffers on stack
Date: Tue, 26 Mar 2019 03:07:14 +0000
Message-ID: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
a stack virtual address. Stack DMA buffers must be avoided.

Signed-off-by: raymond pang <raymondpangxd@gmail.com>
---
 drivers/ata/libata-zpodd.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index b3ed8f9..5ca0ce5 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -52,38 +52,54 @@ static int eject_tray(struct ata_device *dev)
 /* Per the spec, only slot type and drawer type ODD can be supported */
 static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 {
-    char buf[16];
+    char *buf;
     unsigned int ret;
-    struct rm_feature_desc *desc = (void *)(buf + 8);
+    struct rm_feature_desc *desc;
     struct ata_taskfile tf;
     static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
             2,      /* only 1 feature descriptor requested */
             0, 3,   /* 3, removable medium feature */
             0, 0, 0,/* reserved */
-            0, sizeof(buf),
+            0, 16,
             0, 0, 0,
     };

+    buf = kzalloc(16, GFP_KERNEL);
+    if (!buf) {
+        ata_dev_err(dev, "zpodd mech type buffer allocation failed\n");
+        return ODD_MECH_TYPE_UNSUPPORTED;
+    }
+    desc = (void *)(buf + 8);
+
     ata_tf_init(dev, &tf);
     tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
     tf.command = ATA_CMD_PACKET;
     tf.protocol = ATAPI_PROT_PIO;
-    tf.lbam = sizeof(buf);
+    tf.lbam = 16;

     ret = ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
-                buf, sizeof(buf), 0);
-    if (ret)
+                buf, 16, 0);
+    if (ret) {
+        kzfree(buf);
         return ODD_MECH_TYPE_UNSUPPORTED;
+    }

-    if (be16_to_cpu(desc->feature_code) != 3)
+    if (be16_to_cpu(desc->feature_code) != 3) {
+        kzfree(buf);
         return ODD_MECH_TYPE_UNSUPPORTED;
+    }

-    if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1)
+    if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1) {
+        kzfree(buf);
         return ODD_MECH_TYPE_SLOT;
-    else if (desc->mech_type == 1 && desc->load == 0 && desc->eject == 1)
+    } else if (desc->mech_type == 1 && desc->load == 0 &&
+           desc->eject == 1) {
+        kzfree(buf);
         return ODD_MECH_TYPE_DRAWER;
-    else
+    } else {
+        kzfree(buf);
         return ODD_MECH_TYPE_UNSUPPORTED;
+    }
 }

 /* Test if ODD is zero power ready by sense code */
--
1.9.1
