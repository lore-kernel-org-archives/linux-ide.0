From: Andrew Lunn <andrew@lunn.ch>
Subject: [Patch v4 2/3] drivers: phy: Add support for optional phys
Date: Tue,  4 Feb 2014 18:33:12 +0100
Message-ID: <1391535193-24165-2-git-send-email-andrew@lunn.ch>
References: <1391535193-24165-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50989 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbaBDRdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Feb 2014 12:33:46 -0500
In-Reply-To: <1391535193-24165-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, kishon@ti.com
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Add devm_phy_optional_get and phy_optioanl_get, which should be used
when the phy is optional. They does not return an error when the phy
does not exist, rather they returns NULL, which is considered as a valid
phy, but results in NOPs when used with the consumer API.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
v2
 Add phy_optional_get()
 Improve the comments about the optional functions.
 Drop the dev_err()->dev_dbg() changes.
v4
 Add Tested-by
---
 Documentation/phy.txt   | 20 +++++++++++++-------
 drivers/phy/phy-core.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h | 14 ++++++++++++++
 3 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/Documentation/phy.txt b/Documentation/phy.txt
index 2e24b993e95f..ebff6ee52441 100644
--- a/Documentation/phy.txt
+++ b/Documentation/phy.txt
@@ -75,14 +75,20 @@ Before the controller can make use of the PHY, it has to get a reference to
 it. This framework provides the following APIs to get a reference to the PHY.
 
 struct phy *phy_get(struct device *dev, const char *string);
+struct phy *phy_optional_get(struct device *dev, const char *string);
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
+phy_get, phy_optional_get, devm_phy_get and devm_phy_optional_get can
+be used to get the PHY. In the case of dt boot, the string arguments
+should contain the phy name as given in the dt data and in the case of
+non-dt boot, it should contain the label of the PHY.  The two
+devm_phy_get associates the device with the PHY using devres on
+successful PHY get. On driver detach, release function is invoked on
+the the devres data and devres data is freed. phy_optional_get and
+devm_phy_optional_get should be used when the phy is optional. These
+two functions will never return -ENODEV, but instead returns NULL when
+the phy cannot be found.
 
 It should be noted that NULL is a valid phy reference. All phy
 consumer calls on the NULL phy become NOPs. That is the release calls,
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a9cdeee20d91..5f5b0f4be5be 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -426,6 +426,27 @@ struct phy *phy_get(struct device *dev, const char *string)
 EXPORT_SYMBOL_GPL(phy_get);
 
 /**
+ * phy_optional_get() - lookup and obtain a reference to an optional phy.
+ * @dev: device that requests this phy
+ * @string: the phy name as given in the dt data or the name of the controller
+ * port for non-dt case
+ *
+ * Returns the phy driver, after getting a refcount to it; or
+ * NULL if there is no such phy.  The caller is responsible for
+ * calling phy_put() to release that count.
+ */
+struct phy *phy_optional_get(struct device *dev, const char *string)
+{
+	struct phy *phy = phy_get(dev, string);
+
+	if (PTR_ERR(phy) == -ENODEV)
+		phy = NULL;
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(phy_optional_get);
+
+/**
  * devm_phy_get() - lookup and obtain a reference to a phy.
  * @dev: device that requests this phy
  * @string: the phy name as given in the dt data or phy device name
@@ -456,6 +477,30 @@ struct phy *devm_phy_get(struct device *dev, const char *string)
 EXPORT_SYMBOL_GPL(devm_phy_get);
 
 /**
+ * devm_phy_optional_get() - lookup and obtain a reference to an optional phy.
+ * @dev: device that requests this phy
+ * @string: the phy name as given in the dt data or phy device name
+ * for non-dt case
+ *
+ * Gets the phy using phy_get(), and associates a device with it using
+ * devres. On driver detach, release function is invoked on the devres
+ * data, then, devres data is freed. This differs to devm_phy_get() in
+ * that if the phy does not exist, it is not considered an error and
+ * -ENODEV will not be returned. Instead the NULL phy is returned,
+ * which can be passed to all other phy consumer calls.
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
index e273e5ac19c9..3f83459dbb20 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -146,7 +146,9 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 	phy->attrs.bus_width = bus_width;
 }
 struct phy *phy_get(struct device *dev, const char *string);
+struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
+struct phy *devm_phy_optional_get(struct device *dev, const char *string);
 void phy_put(struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
 struct phy *of_phy_simple_xlate(struct device *dev,
@@ -232,11 +234,23 @@ static inline struct phy *phy_get(struct device *dev, const char *string)
 	return ERR_PTR(-ENOSYS);
 }
 
+static inline struct phy *phy_optional_get(struct device *dev,
+					   const char *string)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline struct phy *devm_phy_get(struct device *dev, const char *string)
 {
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

