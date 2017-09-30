From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] libata: make ata_port_type const
Date: Sat, 30 Sep 2017 22:10:40 +0530
Message-ID: <1506789640-10748-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-ide@vger.kernel.org

Make this const as it is only stored in the const field of a device
structure. Make the declaration in header const too.

Structure found using Coccinelle and changes done by hand.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 65f7574..29e3516 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5824,7 +5824,7 @@ void ata_host_resume(struct ata_host *host)
 }
 #endif
 
-struct device_type ata_port_type = {
+const struct device_type ata_port_type = {
 	.name = "ata_port",
 #ifdef CONFIG_PM
 	.pm = &ata_port_pm_ops,
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 839d487..18bf1e9 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -51,7 +51,7 @@ enum {
 extern int libata_fua;
 extern int libata_noacpi;
 extern int libata_allow_tpm;
-extern struct device_type ata_port_type;
+extern const struct device_type ata_port_type;
 extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
 extern void ata_force_cbl(struct ata_port *ap);
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
-- 
1.9.1
