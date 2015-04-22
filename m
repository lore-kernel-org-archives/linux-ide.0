From: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCHv3 3/4] usb: ehci-platform: Use devm_of_phy_get_by_index
Date: Wed, 22 Apr 2015 16:04:12 -0700
Message-ID: <1429743853-10254-4-git-send-email-arun.ramamurthy@broadcom.com>
References: <1429743853-10254-1-git-send-email-arun.ramamurthy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429743853-10254-1-git-send-email-arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gregory CLEMENT <gregory>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Getting phys by index instead of phy names so that we do
not have to create a naming scheme when multiple phys
are present

Signed-off-by: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/host/ehci-platform.c | 69 ++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index d8a75a5..145bf19 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -88,15 +88,13 @@ static int ehci_platform_power_on(struct platform_device *dev)
 	}
 
 	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-		if (priv->phys[phy_num]) {
-			ret = phy_init(priv->phys[phy_num]);
-			if (ret)
-				goto err_exit_phy;
-			ret = phy_power_on(priv->phys[phy_num]);
-			if (ret) {
-				phy_exit(priv->phys[phy_num]);
-				goto err_exit_phy;
-			}
+		ret = phy_init(priv->phys[phy_num]);
+		if (ret)
+			goto err_exit_phy;
+		ret = phy_power_on(priv->phys[phy_num]);
+		if (ret) {
+			phy_exit(priv->phys[phy_num]);
+			goto err_exit_phy;
 		}
 	}
 
@@ -104,10 +102,8 @@ static int ehci_platform_power_on(struct platform_device *dev)
 
 err_exit_phy:
 	while (--phy_num >= 0) {
-		if (priv->phys[phy_num]) {
-			phy_power_off(priv->phys[phy_num]);
-			phy_exit(priv->phys[phy_num]);
-		}
+		phy_power_off(priv->phys[phy_num]);
+		phy_exit(priv->phys[phy_num]);
 	}
 err_disable_clks:
 	while (--clk >= 0)
@@ -123,10 +119,8 @@ static void ehci_platform_power_off(struct platform_device *dev)
 	int clk, phy_num;
 
 	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-		if (priv->phys[phy_num]) {
-			phy_power_off(priv->phys[phy_num]);
-			phy_exit(priv->phys[phy_num]);
-		}
+		phy_power_off(priv->phys[phy_num]);
+		phy_exit(priv->phys[phy_num]);
 	}
 
 	for (clk = EHCI_MAX_CLKS - 1; clk >= 0; clk--)
@@ -154,7 +148,6 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ehci_platform_priv *priv;
 	struct ehci_hcd *ehci;
-	const char *phy_name;
 	int err, irq, phy_num, clk = 0;
 
 	if (usb_disabled())
@@ -204,36 +197,22 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 		priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
 				"phys", "#phy-cells");
-		priv->num_phys = priv->num_phys > 0 ? priv->num_phys : 1;
 
-		priv->phys = devm_kcalloc(&dev->dev, priv->num_phys,
-				sizeof(struct phy *), GFP_KERNEL);
-		if (!priv->phys)
-			return -ENOMEM;
+		if (priv->num_phys > 0) {
+			priv->phys = devm_kcalloc(&dev->dev, priv->num_phys,
+					    sizeof(struct phy *), GFP_KERNEL);
+			if (!priv->phys)
+				return -ENOMEM;
+		} else
+			priv->num_phys = 0;
 
 		for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-				err = of_property_read_string_index(
-						dev->dev.of_node,
-						"phy-names", phy_num,
-						&phy_name);
-
-				if (err < 0) {
-					if (priv->num_phys > 1) {
-						dev_err(&dev->dev, "phy-names not provided");
-						goto err_put_hcd;
-					} else
-						phy_name = "usb";
-				}
