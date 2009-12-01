From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc/macio: Add devres support to macio_device
Date: Tue, 01 Dec 2009 18:08:31 +1100
Message-ID: <20091201070832.37EB8B7B65@ozlabs.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:43775 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290AbZLAHI0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 02:08:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, jeff@garzik.org, tj@kernel.org

This adds some basic devres support. When enabled via macio_enable_devres()
resources requested by drivers will be automatically released.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/macio.h |    2 +
 drivers/macintosh/macio_asic.c   |   47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

--- linux-work.orig/arch/powerpc/include/asm/macio.h	2009-11-30 12:48:33.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/macio.h	2009-11-30 14:16:55.000000000 +1100
@@ -78,6 +78,8 @@ static inline unsigned long macio_resour
 	return res->end - res->start + 1;
 }
 
+extern int macio_enable_devres(struct macio_dev *dev);
+
 extern int macio_request_resource(struct macio_dev *dev, int resource_no, const char *name);
 extern void macio_release_resource(struct macio_dev *dev, int resource_no);
 extern int macio_request_resources(struct macio_dev *dev, const char *name);
Index: linux-work/drivers/macintosh/macio_asic.c
===================================================================
--- linux-work.orig/drivers/macintosh/macio_asic.c	2009-11-30 12:41:12.000000000 +1100
+++ linux-work/drivers/macintosh/macio_asic.c	2009-11-30 14:17:19.000000000 +1100
@@ -538,6 +538,42 @@ void macio_unregister_driver(struct maci
 	driver_unregister(&drv->driver);
 }
 
+/* Managed MacIO resources */
+struct macio_devres {
+	u32	res_mask;
+};
+
+static void maciom_release(struct device *gendev, void *res)
+{
+	struct macio_dev *dev = to_macio_device(gendev);
+	struct macio_devres *dr = res;
+	int i, max;
+
+	max = min(dev->n_resources, 32);
+	for (i = 0; i < max; i++) {
+		if (dr->res_mask & (1 << i))
+			macio_release_resource(dev, i);
+	}
+}
+
+int macio_enable_devres(struct macio_dev *dev)
+{
+	struct macio_devres *dr;
+
+	dr = devres_find(&dev->ofdev.dev, maciom_release, NULL, NULL);
+	if (!dr) {
+		dr = devres_alloc(maciom_release, sizeof(*dr), GFP_KERNEL);
+		if (!dr)
+			return -ENOMEM;
+	}
+	return devres_get(&dev->ofdev.dev, dr, NULL, NULL) != NULL;
+}
+
+static struct macio_devres * find_macio_dr(struct macio_dev *dev)
+{
+	return devres_find(&dev->ofdev.dev, maciom_release, NULL, NULL);
+}
+
 /**
  *	macio_request_resource - Request an MMIO resource
  * 	@dev: pointer to the device holding the resource
@@ -555,6 +591,8 @@ void macio_unregister_driver(struct maci
 int macio_request_resource(struct macio_dev *dev, int resource_no,
 			   const char *name)
 {
+	struct macio_devres *dr = find_macio_dr(dev);
+
 	if (macio_resource_len(dev, resource_no) == 0)
 		return 0;
 		
@@ -562,6 +600,9 @@ int macio_request_resource(struct macio_
 				macio_resource_len(dev, resource_no),
 				name))
 		goto err_out;
+
+	if (dr && resource_no < 32)
+		dr->res_mask |= 1 << resource_no;
 	
 	return 0;
 
@@ -582,10 +623,14 @@ err_out:
  */
 void macio_release_resource(struct macio_dev *dev, int resource_no)
 {
+	struct macio_devres *dr = find_macio_dr(dev);
+
 	if (macio_resource_len(dev, resource_no) == 0)
 		return;
 	release_mem_region(macio_resource_start(dev, resource_no),
 			   macio_resource_len(dev, resource_no));
+	if (dr && resource_no < 32)
+		dr->res_mask &= ~(1 << resource_no);
 }
 
 /**
@@ -744,3 +789,5 @@ EXPORT_SYMBOL(macio_request_resource);
 EXPORT_SYMBOL(macio_release_resource);
 EXPORT_SYMBOL(macio_request_resources);
 EXPORT_SYMBOL(macio_release_resources);
+EXPORT_SYMBOL(macio_enable_devres);
+
