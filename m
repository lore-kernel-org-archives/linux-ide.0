From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] ata:sata_nv - Change 1 to true for bool type variable.
Date: Tue, 26 May 2015 01:38:25 +0530
Message-ID: <1432584505-5274-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-ide@vger.kernel.org

The variable swncq_enabled is bool type. Hence initialize it
with true instead of 1.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/ata/sata_nv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 7ece85f..734f563 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -599,7 +599,7 @@ MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
 static bool adma_enabled;
-static bool swncq_enabled = 1;
+static bool swncq_enabled = true;
 static bool msi_enabled;
 
 static void nv_adma_register_mode(struct ata_port *ap)
-- 
1.7.9.5
