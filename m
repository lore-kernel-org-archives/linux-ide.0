From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] libata: Fix display of sata speed
Date: Fri, 25 Oct 2013 16:28:57 -0700
Message-ID: <1382743737-3516-2-git-send-email-gwendal@google.com>
References: <1382743737-3516-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:36079 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3JYX3D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Oct 2013 19:29:03 -0400
Received: by mail-qc0-f202.google.com with SMTP id m20so415202qcx.3
        for <linux-ide@vger.kernel.org>; Fri, 25 Oct 2013 16:29:02 -0700 (PDT)
In-Reply-To: <1382743737-3516-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

6.0 Gbps link speed was not decoded properly:
speed was reported at 3.0 Gbps only.

Tested: On a machine where libata reports 6.0 Gbps in
        /var/log/messages:
    ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

    Before:
    	cat /sys/class/ata_link/link1/sata_spd
    	3.0 Gbps
    After:
    	cat /sys/class/ata_link/link1/sata_spd
    	6.0 Gbps

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-transport.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 150a917..e37413228 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -321,25 +321,25 @@ int ata_tport_add(struct device *parent,
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
+	return sprintf(buf, "%s\n", sata_spd_string(format(link->field))); \
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
1.8.4.1

