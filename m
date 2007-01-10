From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/13] devres: implement managed IO region interface
Date: Wed, 10 Jan 2007 14:35:36 +0900
Message-ID: <11684073361953-git-send-email-htejun@gmail.com>
References: <11684073353213-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932664AbXAJFgA@vger.kernel.org>
In-Reply-To: <11684073353213-git-send-email-htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

Implement managed IO region interface - devm_request_region() and
devm_release_region().  Except for the first @dev argument and being
managed, these take the same arguments and have the same effect as
non-managed coutnerparts.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/ioport.h |   20 +++++++++++++++
 kernel/resource.c      |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 15228d7..6859a3b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -137,4 +137,24 @@ static inline int __deprecated check_region(resource_size_t s,
 {
 	return __check_region(&ioport_resource, s, n);
 }
+
+/* Wrappers for managed devices */
+struct device;
+#define devm_request_region(dev,start,n,name) \
+	__devm_request_region(dev, &ioport_resource, (start), (n), (name))
+#define devm_request_mem_region(dev,start,n,name) \
+	__devm_request_region(dev, &iomem_resource, (start), (n), (name))
+
+extern struct resource * __devm_request_region(struct device *dev,
+				struct resource *parent, resource_size_t start,
+				resource_size_t n, const char *name);
+
+#define devm_release_region(start,n) \
+	__devm_release_region(dev, &ioport_resource, (start), (n))
+#define devm_release_mem_region(start,n) \
+	__devm_release_region(dev, &iomem_resource, (start), (n))
+
+extern void __devm_release_region(struct device *dev, struct resource *parent,
+				  resource_size_t start, resource_size_t n);
+
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 7b9a497..2a3f886 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
 #include <asm/io.h>
 
 
@@ -618,6 +619,67 @@ void __release_region(struct resource *parent, resource_size_t start,
 EXPORT_SYMBOL(__release_region);
 
 /*
+ * Managed region resource
+ */
+struct region_devres {
+	struct resource *parent;
+	resource_size_t start;
+	resource_size_t n;
+};
+
+static void devm_region_release(struct device *dev, void *res)
+{
+	struct region_devres *this = res;
+
+	__release_region(this->parent, this->start, this->n);
+}
+
+static int devm_region_match(struct device *dev, void *res, void *match_data)
+{
+	struct region_devres *this = res, *match = match_data;
+
+	return this->parent == match->parent &&
+		this->start == match->start && this->n == match->n;
+}
+
+struct resource * __devm_request_region(struct device *dev,
+				struct resource *parent, resource_size_t start,
+				resource_size_t n, const char *name)
+{
+	struct region_devres *dr = NULL;
+	struct resource *res;
+
+	dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
+			  GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	dr->parent = parent;
+	dr->start = start;
+	dr->n = n;
+
+	res = __request_region(parent, start, n, name);
+	if (res)
+		devres_add(dev, dr);
+	else
+		devres_free(dr);
+
+	return res;
+}
+EXPORT_SYMBOL(__devm_request_region);
+
+void __devm_release_region(struct device *dev, struct resource *parent,
+			   resource_size_t start, resource_size_t n)
+{
+	struct region_devres match_data = { parent, start, n };
+
+	__release_region(parent, start, n);
+	WARN_ON(devres_destroy(dev, devm_region_release, devm_region_match,
+			       &match_data));
+}
+EXPORT_SYMBOL(__devm_release_region);
+
+/*
  * Called from init/main.c to reserve IO ports.
  */
 #define MAXRESERVE 4
-- 
1.4.4.3
