From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] ata: ahci: append new hflag AHCI_HFLAG_NO_FBS
Date: Wed, 9 Apr 2014 18:30:18 +0800
Message-ID: <1397039419-9716-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, guohanjun@huawei.com
List-Id: linux-ide@vger.kernel.org

From: Kefeng Wang <kefeng.wang@linaro.org>

Append AHCI_HFLAG_NO_FBS to force turning off FBS flag.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
---
 drivers/ata/ahci.h    |    1 +
 drivers/ata/libahci.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 51af275..60db49b 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -235,6 +235,7 @@ enum {
 						        port start (wait until
 						        error-handling stage) */
 	AHCI_HFLAG_MULTI_MSI		= (1 << 16), /* multiple PCI MSIs */
+	AHCI_HFLAG_NO_FBS		= (1 << 17), /* no FBS */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 6bd4f66..573edb3 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -452,6 +452,11 @@ void ahci_save_initial_config(struct device *dev,
 		cap &= ~HOST_CAP_SNTF;
 	}
 
+	if ((cap & HOST_CAP_FBS) && (hpriv->flags & AHCI_HFLAG_NO_FBS)) {
+		dev_info(dev, "controller can't do FBS, turning off CAP_FBS\n");
+		cap &= ~HOST_CAP_FBS;
+	}
+
 	if (!(cap & HOST_CAP_FBS) && (hpriv->flags & AHCI_HFLAG_YES_FBS)) {
 		dev_info(dev, "controller can do FBS, turning on CAP_FBS\n");
 		cap |= HOST_CAP_FBS;
-- 
1.7.1
