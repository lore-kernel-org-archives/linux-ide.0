Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D368C3524B
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F020674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBDQ4G (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:34594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgBDQ4G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 858B3AF4C;
        Tue,  4 Feb 2020 16:56:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/46] libata-transport: Whitespace cleanup
Date:   Tue,  4 Feb 2020 17:55:04 +0100
Message-Id: <20200204165547.115220-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-transport.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 12a505bb9c5b..4ccfeb85ec66 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -163,7 +163,7 @@ static struct {
 	{ AC_ERR_INVALID,		"InvalidArg" },
 	{ AC_ERR_OTHER,			"Unknown" },
 	{ AC_ERR_NODEV_HINT,		"NoDeviceHint" },
-	{ AC_ERR_NCQ,		 	"NCQError" }
+	{ AC_ERR_NCQ,			"NCQError" }
 };
 ata_bitfield_name_match(err, ata_err_names)
 
@@ -327,7 +327,7 @@ int ata_tport_add(struct device *parent,
  */
 static int noop(int x) { return x; }
 
-#define ata_link_show_linkspeed(field, format)			        \
+#define ata_link_show_linkspeed(field, format)				\
 static ssize_t								\
 show_ata_link_##field(struct device *dev,				\
 		      struct device_attribute *attr, char *buf)		\
@@ -416,7 +416,7 @@ int ata_tlink_add(struct ata_link *link)
 	dev->release = ata_tlink_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
-        else
+	else
 		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
 
 	transport_setup_device(dev);
@@ -484,7 +484,7 @@ show_ata_dev_##field(struct device *dev,				\
 
 #define ata_dev_simple_attr(field, format_string, type)	\
 	ata_dev_show_simple(field, format_string, (type))	\
-static DEVICE_ATTR(field, S_IRUGO, 			\
+	static DEVICE_ATTR(field, S_IRUGO,			\
 		   show_ata_dev_##field, NULL)
 
 ata_dev_simple_attr(spdn_cnt, "%d\n", int);
@@ -502,7 +502,7 @@ static int ata_show_ering(struct ata_ering_entry *ent, void *void_arg)
 
 	seconds = div_u64_rem(ent->timestamp, HZ, &rem);
 	arg->written += sprintf(arg->buf + arg->written,
-			        "[%5llu.%09lu]", seconds,
+				"[%5llu.%09lu]", seconds,
 				rem * NSEC_PER_SEC / HZ);
 	arg->written += get_ata_err_names(ent->err_mask,
 					  arg->buf + arg->written);
@@ -667,7 +667,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	dev->release = ata_tdev_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
-        else
+	else
 		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
 
 	transport_setup_device(dev);
@@ -689,7 +689,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
  */
 
 #define SETUP_TEMPLATE(attrb, field, perm, test)			\
-	i->private_##attrb[count] = dev_attr_##field;		       	\
+	i->private_##attrb[count] = dev_attr_##field;			\
 	i->private_##attrb[count].attr.mode = perm;			\
 	i->attrb[count] = &i->private_##attrb[count];			\
 	if (test)							\
-- 
2.16.4

