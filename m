From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 1/4] PHY: Add function set_speed to generic PHY framework
Date: Tue, 19 Nov 2013 16:53:14 -0700
Message-ID: <1384905197-3566-2-git-send-email-lho@apm.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:53251 "HELO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751745Ab3KSXxb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Nov 2013 18:53:31 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so5891171pdi.10
        for <linux-ide@vger.kernel.org>; Tue, 19 Nov 2013 15:53:30 -0800 (PST)
In-Reply-To: <1384905197-3566-1-git-send-email-lho@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, Loc Ho <lho@apm.com>

PHY: Add function set_speed to generic PHY framework

This patch adds function set_speed to the generic PHY
framework operation structure. This function can be
called to instruct the PHY underlying layer at specified
lane to configure for specified speed in hertz.

Signed-off-by: Loc Ho <lho@apm.com>
---
 include/linux/phy/phy.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9351a16..df9b1d1 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -32,6 +32,7 @@ struct phy;
  * @exit: operation to be performed while exiting
  * @power_on: powering on the phy
  * @power_off: powering off the phy
+ * @set_speed: set operation speed in hz
  * @owner: the module owner containing the ops
  */
 struct phy_ops {
@@ -39,6 +40,7 @@ struct phy_ops {
 	int	(*exit)(struct phy *phy);
 	int	(*power_on)(struct phy *phy);
 	int	(*power_off)(struct phy *phy);
+	int	(*set_speed)(struct phy *phy, int lane, u64 speed);
 	struct module *owner;
 };
 
@@ -341,4 +343,24 @@ out:
 	return ret;
 }
 
+static inline int phy_set_speed(struct phy *phy, int lane, u64 speed)
+{
+	int ret = -ENOTSUPP;
+
+	mutex_lock(&phy->mutex);
+	if (phy->ops->set_speed) {
+		ret =  phy->ops->set_speed(phy, lane, speed);
+		if (ret < 0) {
+			dev_err(&phy->dev, "phy set speed failed --> %d\n",
+				ret);
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+
 #endif /* __DRIVERS_PHY_H */
-- 
1.5.5

