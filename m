Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB48EEB3
	for <linux-ide@vger.kernel.org>; Sat, 10 Aug 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723258034; cv=none; b=AHp6Euy8gzs66/Q6LMJKhmBVPd4fLdER+OO1aqsqY43TBVjaTEE++GXxTx9qB9vbBxR2uMlAdaFcsHzNxFPa8xotg1txQhFXzCLABharJXsgnZgvSSHqMiaUhguiVFxBrs52HwWeXGlQLHJnOwE2TfzqOjRtaiWL0J1QFEa0FHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723258034; c=relaxed/simple;
	bh=tz0hWajwnqMD7Xu6OntdsK4VxU7zM3257AXHQ4lAnoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hkBk852x4gk0Ex0qeW1r7aNaBK5RM88oQP3Geydpu51G08vP/qQx5q62/E4rREl0ZM6snlint9yRiyOMEuNMqD9RvReAqc6bKKppWy5yjtsiMO/Kfl04P1OgX/J0vVKw1rhN61HnX9LJlkZxku/lKtZvHroc82mmo4xh5HBpCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WglYG4sxNzcdBF;
	Sat, 10 Aug 2024 10:46:58 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id D4F731400C9;
	Sat, 10 Aug 2024 10:47:08 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 10 Aug
 2024 10:47:08 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <hdegoede@redhat.com>, <axboe@kernel.dk>, <dlemoal@kernel.org>,
	<cassel@kernel.org>, <linux-ide@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v3] ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()
Date: Sat, 10 Aug 2024 10:34:26 +0800
Message-ID: <20240810023426.110624-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500003.china.huawei.com (7.202.181.241)

for_each_child_of_node_scoped() can put the device_node automatically.
So let's use it to make the code simpler by avoiding the need to
explicitly call of_node_put().

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
v2: Improve the patch subject
v3: Improve the commit message

 drivers/ata/libahci_platform.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 581704e61f28..7a8064520a35 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -410,7 +410,6 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 				      struct device *dev)
 {
-	struct device_node *child;
 	u32 port;
 
 	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
@@ -419,14 +418,12 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 	of_property_read_u32(dev->of_node,
 			     "ports-implemented", &hpriv->saved_port_map);
 
-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node_scoped(dev->of_node, child) {
 		if (!of_device_is_available(child))
 			continue;
 
-		if (of_property_read_u32(child, "reg", &port)) {
-			of_node_put(child);
+		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
-		}
 
 		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
 			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
@@ -460,7 +457,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct device_node *child;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -579,7 +575,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	}
 
 	if (child_nodes) {
-		for_each_child_of_node(dev->of_node, child) {
+		for_each_child_of_node_scoped(dev->of_node, child) {
 			u32 port;
 			struct platform_device *port_dev __maybe_unused;
 
@@ -588,7 +584,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 			if (of_property_read_u32(child, "reg", &port)) {
 				rc = -EINVAL;
-				of_node_put(child);
 				goto err_out;
 			}
 
@@ -606,18 +601,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
-				if (rc == -EPROBE_DEFER) {
-					of_node_put(child);
+				if (rc == -EPROBE_DEFER)
 					goto err_out;
-				}
 			}
 #endif
 
 			rc = ahci_platform_get_phy(hpriv, port, dev, child);
-			if (rc) {
-				of_node_put(child);
+			if (rc)
 				goto err_out;
-			}
 
 			enabled_ports++;
 		}
-- 
2.17.1

