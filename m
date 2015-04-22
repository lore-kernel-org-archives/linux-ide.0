From: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCHv3 2/4] phy: core: Add devm_of_phy_get_by_index to phy-core
Date: Wed, 22 Apr 2015 16:04:11 -0700
Message-ID: <1429743853-10254-3-git-send-email-arun.ramamurthy@broadcom.com>
References: <1429743853-10254-1-git-send-email-arun.ramamurthy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429743853-10254-1-git-send-email-arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gregory CLEMENT <gregory>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Some generic drivers, such as ehci, may use multiple phys and for such
drivers referencing phy(s) by name(s) does not make sense. Instead of
inventing new naming schemes and using custom code to iterate through them,
such drivers are better of using nameless phy bindings and using this newly
introduced API to iterate through them.

Signed-off-by: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 Documentation/phy.txt   |  7 ++++++-
 drivers/phy/phy-core.c  | 32 ++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h |  8 ++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/phy.txt b/Documentation/phy.txt
index 371361c..b388c5a 100644
--- a/Documentation/phy.txt
+++ b/Documentation/phy.txt
@@ -76,6 +76,8 @@ struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_optional_get(struct device *dev, const char *string);
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index);
 
 phy_get, phy_optional_get, devm_phy_get and devm_phy_optional_get can
 be used to get the PHY. In the case of dt boot, the string arguments
@@ -86,7 +88,10 @@ successful PHY get. On driver detach, release function is invoked on
 the the devres data and devres data is freed. phy_optional_get and
 devm_phy_optional_get should be used when the phy is optional. These
 two functions will never return -ENODEV, but instead returns NULL when
-the phy cannot be found.
+the phy cannot be found.Some generic drivers, such as ehci, may use multiple
+phys and for such drivers referencing phy(s) by name(s) does not make sense. In
+this case, devm_of_phy_get_by_index can be used to get a phy reference based on
+the index.
 
 It should be noted that NULL is a valid phy reference. All phy
 consumer calls on the NULL phy become NOPs. That is the release calls,
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 3791838..964a84d 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -623,6 +623,38 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 EXPORT_SYMBOL_GPL(devm_of_phy_get);
 
 /**
+ * devm_of_phy_get_by_index() - lookup and obtain a reference to a phy by index.
+ * @dev: device that requests this phy
+ * @np: node containing the phy
+ * @index: index of the phy
+ *
+ * Gets the phy using _of_phy_get(), and associates a device with it using
+ * devres. On driver detach, release function is invoked on the devres data,
+ * then, devres data is freed.
+ *
+ */
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index)
+{
+	struct phy **ptr, *phy;
+
+	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	phy = _of_phy_get(np, index);
+	if (!IS_ERR(phy)) {
+		*ptr = phy;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
+
+/**
  * phy_create() - create a new phy
  * @dev: device that is creating the new phy
  * @node: device node of the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index a0197fa..978d5af 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -133,6 +133,8 @@ struct phy *devm_phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id);
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index);
 void phy_put(struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
 struct phy *of_phy_get(struct device_node *np, const char *con_id);
@@ -261,6 +263,12 @@ static inline struct phy *devm_of_phy_get(struct device *dev,
 	return ERR_PTR(-ENOSYS);
 }
 
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index);
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline void phy_put(struct phy *phy)
 {
 }
-- 
2.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
