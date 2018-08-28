From: Rob Herring <robh@kernel.org>
Subject: [PATCH] ata: ahci: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:10 -0500
Message-ID: <20180828015252.28511-9-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ata/libahci_platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index c92c10d55374..8ac2be869dd9 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -303,8 +303,8 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
 		/* No PHY support. Check if PHY is required. */
 		if (of_find_property(node, "phys", NULL)) {
 			dev_err(dev,
-				"couldn't get PHY in node %s: ENOSYS\n",
-				node->name);
+				"couldn't get PHY in node %pOFn: ENOSYS\n",
+				node);
 			break;
 		}
 		/* fall through */
@@ -316,8 +316,8 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
 
 	default:
 		dev_err(dev,
-			"couldn't get PHY in node %s: %d\n",
-			node->name, rc);
+			"couldn't get PHY in node %pOFn: %d\n",
+			node, rc);
 
 		break;
 	}
-- 
2.17.1
