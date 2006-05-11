From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/14] libata-link: add PM links
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <1147365023754-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:6444 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751866AbWEKQaf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:35 -0400
Received: by nz-out-0102.google.com with SMTP id 13so244952nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:34 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add link->pmp, ap->nr_pm_links, ap->pm_link[], and implement/update
printk helpers and iterators.

printk helpers are updated such that each component is identified as
follows.

if PM is not attached,

	port	'ataP:'
	link	'ataP:'
	dev	'ataP.DD:'

If PM is attached

	port	'ataP:'
	dev	'ataP.LL:'
	link	'ataP.LL'

ie. link and device are identified their PMP number.

If PM is attached (ap->nr_pm_links != 0), ata_for_each_link() iterates
over PM links, while __ata_for_each_link() iterates over the host link
+ PM links.  If PM is not attached (ap->nr_pm_links == 0), both
iterate over the host link only.

---

 include/linux/libata.h |   52 ++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 46 insertions(+), 6 deletions(-)

1b7ba4a43a2a50e0732a8fbcfe99fc64ba2cdffe
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f31c979..7db9b80 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -471,6 +471,7 @@ struct ata_eh_context {
 
 struct ata_link {
 	struct ata_port		*ap;
+	int			pmp;		/* port multiplier port # */
 
 	unsigned int		active_tag;	/* active tag on this link */
 	u32			sactive;	/* active NCQ commands */
@@ -519,6 +520,9 @@ struct ata_port {
 	struct ata_link		link;	/* host default link */
 	struct ata_device	__dev1;	/* storage for link.device[1] */
 
+	int			nr_pm_links;	/* nr of available PM links */
+	struct ata_link		*pm_link;	/* array of PM links */
+
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 	struct device 		*dev;
@@ -796,11 +800,16 @@ extern void ata_do_eh(struct ata_port *a
 #define ata_port_printk(ap, lv, fmt, args...) \
 	printk(lv"ata%u: "fmt, (ap)->id , ##args)
 
-#define ata_link_printk(link, lv, fmt, args...) \
-	printk(lv"ata%u: "fmt, (link)->ap->id , ##args)
+#define ata_link_printk(link, lv, fmt, args...) do { \
+	if ((link)->ap->nr_pm_links) \
+		printk(lv"ata%u.%02u: "fmt, (link)->ap->id, (link)->pmp , ##args); \
+	else \
+		printk(lv"ata%u: "fmt, (link)->ap->id , ##args); \
+	} while(0)
 
 #define ata_dev_printk(dev, lv, fmt, args...) \
-	printk(lv"ata%u.%02u: "fmt, (dev)->link->ap->id, (dev)->devno , ##args)
+	printk(lv"ata%u.%02u: "fmt, (dev)->link->ap->id, \
+	       (dev)->link->pmp + (dev)->devno , ##args)
 
 /*
  * ata_eh_info helpers
@@ -902,15 +911,46 @@ static inline unsigned int ata_dev_absen
 /*
  * link helpers
  */
+static inline int ata_is_host_link(const struct ata_link *link)
+{
+	return link == &link->ap->link;
+}
+
 static inline int ata_link_max_devices(const struct ata_link *link)
 {
-	if (link->ap->flags & ATA_FLAG_SLAVE_POSS)
+	if (ata_is_host_link(link) && link->ap->flags & ATA_FLAG_SLAVE_POSS)
 		return 2;
 	return 1;
 }
 
-#define ata_port_for_each_link(lk, ap) \
-	for ((lk) = &(ap)->link; (lk); (lk) = NULL)
+static inline struct ata_link *ata_port_first_link(struct ata_port *ap)
+{
+	if (ap->nr_pm_links)
+		return ap->pm_link;
+	return &ap->link;
+}
+
+static inline struct ata_link *ata_port_next_link(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+
+	if (link == &ap->link) {
+		if (!ap->nr_pm_links)
+			return NULL;
+		return ap->pm_link;
+	}
+
+	if (++link - ap->pm_link < ap->nr_pm_links)
+		return link;
+	return NULL;
+}
+
+#define __ata_port_for_each_link(lk, ap) \
+	for ((lk) = &(ap)->link; (lk); (lk) = ata_port_next_link(lk))
+
+#define ata_port_for_each_link(link, ap) \
+	for ((link) = ata_port_first_link(ap); (link); \
+	     (link) = ata_port_next_link(link))
 
 #define ata_link_for_each_dev(dev, link) \
 	for ((dev) = (link)->device; \
-- 
1.2.4


