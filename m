Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8A7C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhLUHWo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55796 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhLUHWm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A6C6B1F3B3;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BttLdQdBuuoxskOxf8F/CrA+FhA3UgnyFay5MLA3Tww=;
        b=X7qidEjHe2PD9rvek4x3WBBJ39ayz91JhSliAFS/JM9lBXXIFzLFNHzjiTnwt7QDysnAVV
        XlkUu8WyDpkQwYfJQRcnnK6ooQEScWa7q3rGT/MRz6akQOheOYUARHDhj8JHaO3de+8bel
        p1vKwtBeBMRpvTgPHI1blYvQhrvDZfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BttLdQdBuuoxskOxf8F/CrA+FhA3UgnyFay5MLA3Tww=;
        b=vMjY9Jlnr7h8+LYRh7X7Q465RP/GTVmHhQooT7ODnMNO2jaZ9PhwgQU1nHIYO8F1dcj2u3
        3RhPLSghw43B+JAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A0B93A3B85;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9A6075192376; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/68] libata: whitespace cleanup
Date:   Tue, 21 Dec 2021 08:20:25 +0100
Message-Id: <20211221072131.46673-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-transport.c | 18 +++++++++---------
 drivers/ata/libata.h           |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 34bb4608bdc6..4162d625fc92 100644
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
@@ -472,7 +472,7 @@ ata_dev_attr(xfer, dma_mode);
 ata_dev_attr(xfer, xfer_mode);
 
 
-#define ata_dev_show_simple(field, format_string, cast)		\
+#define ata_dev_show_simple(field, format_string, cast)			\
 static ssize_t								\
 show_ata_dev_##field(struct device *dev,				\
 		     struct device_attribute *attr, char *buf)		\
@@ -482,9 +482,9 @@ show_ata_dev_##field(struct device *dev,				\
 	return scnprintf(buf, 20, format_string, cast ata_dev->field);	\
 }
 
-#define ata_dev_simple_attr(field, format_string, type)	\
+#define ata_dev_simple_attr(field, format_string, type)		\
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
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 68cdd81d747c..4a8f4623cfe5 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -179,7 +179,7 @@ extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 extern void ata_eh_finish(struct ata_port *ap);
 extern int ata_ering_map(struct ata_ering *ering,
 			 int (*map_fn)(struct ata_ering_entry *, void *),
-		  	 void *arg);
+			 void *arg);
 extern unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key);
 extern unsigned int atapi_eh_request_sense(struct ata_device *dev,
 					   u8 *sense_buf, u8 dfl_sense_key);
-- 
2.29.2

