From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/3] drivers: phy: Add support for optional phys
Date: Sat,  1 Feb 2014 15:15:56 +0100
Message-ID: <1391264157-2112-2-git-send-email-andrew@lunn.ch>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49899 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932797AbaBAOQZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Feb 2014 09:16:25 -0500
In-Reply-To: <1391264157-2112-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, kishon@ti.com
Cc: linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Add devm_phy_optional_get, which should be used when the phy is
optional. It does not return an error when the phy does not exist,
rather it returns NULL, which is considered as a valid phy, but
results in NOPs when used with the consumer API.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/phy.txt   | 18 +++++++++++-------
 drivers/phy/phy-core.c  | 27 +++++++++++++++++++++++++--
 include/linux/phy/phy.h |  7 +++++++
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/Documentation/phy.txt b/Documentation/phy.txt
index 2e24b993e95f..1f34a44975ba 100644
--- a/Documentation/phy.txt
+++ b/Documentation/phy.txt
@@ -76,13 +76,17 @@ it. This framework provides the following APIs to get a reference to the PHY.
 
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
-
-phy_get and devm_phy_get can be used to get the PHY. In the case of dt boot,
-the string arguments should contain the phy name as given in the dt data and
-in the case of non-dt boot, it should contain the label of the PHY.
-The only difference between the two APIs is that devm_phy_get associates the
-device with the PHY using devres on successful PHY get. On driver detach,
-release function is invoked on the the devres data and devres data is freed.
+struct phy *devm_phy_optional_get(struct device *dev, const char *string);
+
+phy_get, devm_phy_get and devm_phy_optional_get can be used to get the
+PHY. In the case of dt boot, the string arguments should contain the
+phy name as given in the dt data and in the case of non-dt boot, it
+should contain the label of the PHY.  The two devm_phy_get associates
+the device with the PHY using devres on successful PHY get. On driver
+detach, release function is invoked on the the devres data and devres
+data is freed. devm_phy_optional_get should be used when the phy is
+optional. It does not return an error when the phy cannot be found, it
+returns NULL.
 
 It should be noted that NULL is a valid phy reference. All phy
 consumer calls on the NULL phy become NOPs. That is the release calls,
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 74d34b5cc75c..4992523111b5 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -390,13 +390,13 @@ struct phy *phy_get(struct device *dev, const char *string)
 			string);
 		phy = of_phy_get(dev, index);
 		if (IS_ERR(phy)) {
-			dev_err(dev, "unable to find phy\n");
+			dev_dbg(dev, "unable to find phy\n");
 			return phy;
 		}
 	} else {
 		phy = phy_lookup(dev, string);
 		if (IS_ERR(phy)) {
-			dev_err(dev, "unable to find phy\n");
+			dev_dbg(dev, "unable to find phy\n");
 			return phy;
 		}
 	}
@@ -441,6 +441,29 @@ struct phy *devm_phy_get(struct device *dev, const char *string)
 EXPORT_SYMBOL_GPL(devm_phy_get);
 
 /**
+ * devm_phy_optional_get() - lookup and obtain a reference to an optional phy.
+ * @dev: device that requests this phy
+ * @string: the phy name as given in the dt data or phy device name
+ * for non-dt case
+ *
+ * Gets the phy using phy_get(), and associates a device with it using
+ * devres. On driver detach, release function is invoked on the devres data,
+ * then, devres data is freed. This differs to devm_phy_get() in that if the
+ * phy does not exist, it is not considered an error. Instead the NULL phy
+ * is returned, which can be passed to all other phy consumer calls.
+ */
+struct phy *devm_phy_optional_get(struct device *dev, const char *string)
+{
+	struct phy *phy = devm_phy_get(dev, string);
+
+	if (PTR_ERR(phy) == -ENODEV)
+		phy = NULL;
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_phy_optional_get);
+
+/**
  * phy_create() - create a new phy
  * @dev: device that is creating the new phy
  * @ops: function pointers for performing phy operations
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 6d722695e027..8a425533468c 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -129,6 +129,7 @@ int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
+struct phy *devm_phy_optional_get(struct device *dev, const char *string);
 void phy_put(struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
 struct phy *of_phy_simple_xlate(struct device *dev,
@@ -209,6 +210,12 @@ static inline struct phy *devm_phy_get(struct device *dev, const char *string)
 	return ERR_PTR(-ENOSYS);
 }
 
+static inline struct phy *devm_phy_optional_get(struct device *dev,
+						const char *string)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline void phy_put(struct phy *phy)
 {
 }
-- 
1.8.5.2

