From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] libata: reimplement link iterator
Date: Thu, 31 Jul 2008 17:02:41 +0900
Message-ID: <1217491364-19725-3-git-send-email-tj@kernel.org>
References: <1217491364-19725-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42765 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbYGaIFj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 04:05:39 -0400
In-Reply-To: <1217491364-19725-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, JosephChan@via.com.tw
Cc: Tejun Heo <tj@kernel.org>

Implement __ata_port_next_link() and reimplement
__ata_port_for_each_link() and ata_port_for_each_link() using it.
This removes relatively large inlined code and makes iteration easier
to extend.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   30 ++++++++++++++++++++++++++++++
 include/linux/libata.h    |   33 ++++++++-------------------------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 03151a1..f7049cd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -162,6 +162,35 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
+/*
+ * Iterator helpers.  Don't use directly.
+ *
+ * LOCKING:
+ * Host lock or EH context.
+ */
+struct ata_link *__ata_port_next_link(struct ata_port *ap,
+				      struct ata_link *link, bool dev_only)
+{
+	/* NULL link indicates start of iteration */
+	if (!link) {
+		if (dev_only && sata_pmp_attached(ap))
+			return ap->pmp_link;
+		return &ap->link;
+	}
+
+	/* we just iterated over the host link, what's next? */
+	if (ata_is_host_link(link)) {
+		if (!sata_pmp_attached(ap))
+			return NULL;
+		return ap->pmp_link;
+	}
+
+	/* iterate to the next PMP link */
+	if (++link < ap->pmp_link + ap->nr_pmp_links)
+		return link;
+	return NULL;
+}
+
 /**
  *	ata_force_cbl - force cable type according to libata.force
  *	@ap: ATA port of interest
@@ -6207,6 +6236,7 @@ EXPORT_SYMBOL_GPL(ata_base_port_ops);
 EXPORT_SYMBOL_GPL(sata_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
+EXPORT_SYMBOL_GPL(__ata_port_next_link);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1418a21..42c4b6f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1261,34 +1261,17 @@ static inline int ata_link_active(struct ata_link *link)
 	return ata_tag_valid(link->active_tag) || link->sactive;
 }
 
-static inline struct ata_link *ata_port_first_link(struct ata_port *ap)
-{
-	if (sata_pmp_attached(ap))
-		return ap->pmp_link;
-	return &ap->link;
-}
-
-static inline struct ata_link *ata_port_next_link(struct ata_link *link)
-{
-	struct ata_port *ap = link->ap;
-
-	if (ata_is_host_link(link)) {
-		if (!sata_pmp_attached(ap))
-			return NULL;
-		return ap->pmp_link;
-	}
-
-	if (++link < ap->nr_pmp_links + ap->pmp_link)
-		return link;
-	return NULL;
-}
+extern struct ata_link *__ata_port_next_link(struct ata_port *ap,
+					     struct ata_link *link,
+					     bool dev_only);
 
-#define __ata_port_for_each_link(lk, ap) \
-	for ((lk) = &(ap)->link; (lk); (lk) = ata_port_next_link(lk))
+#define __ata_port_for_each_link(link, ap) \
+	for ((link) = __ata_port_next_link((ap), NULL, false); (link); \
+	     (link) = __ata_port_next_link((ap), (link), false))
 
 #define ata_port_for_each_link(link, ap) \
-	for ((link) = ata_port_first_link(ap); (link); \
-	     (link) = ata_port_next_link(link))
+	for ((link) = __ata_port_next_link((ap), NULL, true); (link); \
+	     (link) = __ata_port_next_link((ap), (link), true))
 
 #define ata_link_for_each_dev(dev, link) \
 	for ((dev) = (link)->device; \
-- 
1.5.4.5

