From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/18] [PATCH] libata-link: add PMP links
Date: Mon, 16 Oct 2006 07:54:41 +0900
Message-ID: <11609528812917-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:5047 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422935AbWJOWyz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:55 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626639nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:54 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add link->pmp, ap->nr_pmp_links, ap->pmp_link[], and implement/update
link helpers.

printk helpers are updated such that port and link are identifed as
'ataP:' if no PMP is attached, while device is identified as
'ataP.DD:'.  If PMP is attached, they become 'ataP:', 'ataP.LL:' and
'ataP.LL' - ie. link and device are identified their PMP number.

If PPM is attached (ap->nr_pmp_links != 0), ata_for_each_link()
iterates over PMP links, while __ata_for_each_link() iterates over the
host link + PMP links.  If PMP is not attached (ap->nr_pmp_links ==
0), both iterate over only the host link.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 +++--
 include/linux/libata.h    |   52 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2813bb8..0ef6ab0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5395,13 +5395,14 @@ void ata_dev_init(struct ata_device *dev
  *	ata_link_init - Initialize an ata_link structure
  *	@ap: ATA port link is attached to
  *	@link: Link structure to initialize
+ *	@pmp: Port multiplier port number
  *
  *	Initialize @link.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-static void ata_link_init(struct ata_port *ap, struct ata_link *link)
+static void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 {
 	struct ata_device *dev;
 
@@ -5409,6 +5410,7 @@ static void ata_link_init(struct ata_por
 	memset(link, 0, offsetof(struct ata_link, device[0]));
 
 	link->ap = ap;
+	link->pmp = pmp;
 	link->active_tag = ATA_TAG_POISON;
 	link->hw_sata_spd_limit = UINT_MAX;
 	link->reset_tries = ATA_EH_RESET_TRIES;
@@ -5509,7 +5511,7 @@ #endif
 	if (ap->flags & ATA_FLAG_SATA)
 		ap->cbl = ATA_CBL_SATA;
 
-	ata_link_init(ap, &ap->link);
+	ata_link_init(ap, &ap->link, 0);
 
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e4fd809..e09dfe6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -530,6 +530,7 @@ struct ata_eh_context {
 
 struct ata_link {
 	struct ata_port		*ap;
+	int			pmp;		/* port multiplier port # */
 
 	unsigned int		active_tag;	/* active tag on this link */
 	u32			sactive;	/* active NCQ commands */
@@ -577,6 +578,9 @@ struct ata_port {
 
 	struct ata_link		link;	/* host default link */
 
+	int			nr_pmp_links;	/* nr of available PMP links */
+	struct ata_link		*pmp_link;	/* array of PMP links */
+
 	struct ata_port_stats	stats;
 	struct ata_host		*host;
 	struct device 		*dev;
@@ -910,11 +914,16 @@ extern void ata_do_eh(struct ata_port *a
 #define ata_port_printk(ap, lv, fmt, args...) \
 	printk(lv"ata%u: "fmt, (ap)->id , ##args)
 
-#define ata_link_printk(link, lv, fmt, args...) \
-	printk(lv"ata%u: "fmt, (link)->ap->id , ##args)
+#define ata_link_printk(link, lv, fmt, args...) do { \
+	if ((link)->ap->nr_pmp_links) \
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
@@ -1039,15 +1048,46 @@ static inline unsigned int ata_dev_ready
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
+	if (ap->nr_pmp_links)
+		return ap->pmp_link;
+	return &ap->link;
+}
+
+static inline struct ata_link *ata_port_next_link(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+
+	if (link == &ap->link) {
+		if (!ap->nr_pmp_links)
+			return NULL;
+		return ap->pmp_link;
+	}
+
+	if (++link - ap->pmp_link < ap->nr_pmp_links)
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
1.4.2.3


