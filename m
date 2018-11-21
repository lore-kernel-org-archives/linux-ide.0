From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ata: pata_macio: add of_node_put()
Date: Wed, 21 Nov 2018 08:04:39 -0500
Message-ID: <20181121130439.22255-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b.zolnierkie@samsung.com, axboe@kernel.dk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-ide@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/ata/pata_macio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9588e685d994..8cc9c429ad95 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_port *ap)
 		struct device_node *root = of_find_node_by_path("/");
 		const char *model = of_get_property(root, "model", NULL);
 
+		of_node_put(root);
+
 		if (cable && !strncmp(cable, "80-", 3)) {
 			/* Some drives fail to detect 80c cable in PowerBook
 			 * These machine use proprietary short IDE cable
-- 
2.17.0
