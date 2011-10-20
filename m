From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] [libata-transport]Fix display of sata speed
Date: Wed, 19 Oct 2011 23:33:53 -0700
Message-ID: <1319092433-12726-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:32645 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1JTGd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2011 02:33:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

On a system with controller and disk supporting 6.0Gbps,
sata_spd was incorrectly set to 3.0Gbps.


Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-transport.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index ce9dc62..1172a67 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -312,25 +312,25 @@ int ata_tport_add(struct device *parent,
 /*
  * ATA link attributes
  */
+static int noop(int x) { return x; }
 
-
-#define ata_link_show_linkspeed(field)					\
+#define ata_link_show_linkspeed(field, format)			        \
 static ssize_t								\
 show_ata_link_##field(struct device *dev,				\
 		      struct device_attribute *attr, char *buf)		\
 {									\
 	struct ata_link *link = transport_class_to_link(dev);		\
 									\
-	return sprintf(buf,"%s\n", sata_spd_string(fls(link->field)));	\
+	return sprintf(buf,"%s\n", sata_spd_string(format(link->field))); \
 }
 
-#define ata_link_linkspeed_attr(field)					\
-	ata_link_show_linkspeed(field)					\
+#define ata_link_linkspeed_attr(field, format)				\
+	ata_link_show_linkspeed(field, format)				\
 static DEVICE_ATTR(field, S_IRUGO, show_ata_link_##field, NULL)
 
-ata_link_linkspeed_attr(hw_sata_spd_limit);
-ata_link_linkspeed_attr(sata_spd_limit);
-ata_link_linkspeed_attr(sata_spd);
+ata_link_linkspeed_attr(hw_sata_spd_limit, fls);
+ata_link_linkspeed_attr(sata_spd_limit, fls);
+ata_link_linkspeed_attr(sata_spd, noop);
 
 
 static DECLARE_TRANSPORT_CLASS(ata_link_class,
-- 
1.7.3.1

