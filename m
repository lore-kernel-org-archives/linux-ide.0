From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] libata: ensure host is free'd on error exit paths
Date: Tue, 27 Mar 2018 14:26:01 +0100
Message-ID: <20180327132601.12749-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The host structure is not being kfree'd on two error exit paths
leading to memory leaks. Add in new err_free label and kfree host.

Detected by CoverityScan, CID#1466103 ("Resource leak")

Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc2c48b8ae45..8bc71ca61e7f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6108,7 +6108,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 		return NULL;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
-		return NULL;
+		goto err_free;
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
 	if (!dr)
@@ -6140,6 +6140,8 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 
  err_out:
 	devres_release_group(dev, NULL);
+ err_free:
+	kfree(host);
 	return NULL;
 }
 
-- 
2.15.1
