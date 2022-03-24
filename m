Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9758FC433FE
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 12:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiCXMdo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiCXMdm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 08:33:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846AA9944
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 05:32:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A0115210FD;
        Thu, 24 Mar 2022 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648125128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNrmEkBd8gq3KlIYY5P5qtJ01dx98Tc+/7D2Qm9iOzk=;
        b=y9o+G6XfX5KjdVjR0YIP7xkkw8OchMUPMdKPR2b8mTM+n52ulFtAnLF6jH9Mdl1NjTmiBW
        X+XakMd5gJtGrK1axs1xvc109N714iOMT3BdzfOZ5YOMHh1XZsbni3SoyAnZhmgVlDHJ+d
        z6QpPkmEuuTobIPU0XHTsXoVKM45wvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648125128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNrmEkBd8gq3KlIYY5P5qtJ01dx98Tc+/7D2Qm9iOzk=;
        b=HTLCwMFVQ2CcbYgt2IY8ilAjOFeEY0HxlboQasxI7B+ghQOrp4D/XvvUM76Rc3l455n2/n
        z4THh6GDX9yZeXAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 79D6DA3B82;
        Thu, 24 Mar 2022 12:32:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6BBDC51938FB; Thu, 24 Mar 2022 13:32:08 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] libata: rework sysfs naming
Date:   Thu, 24 Mar 2022 13:32:03 +0100
Message-Id: <20220324123204.61534-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220324123204.61534-1-hare@suse.de>
References: <20220324123204.61534-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds a new dummy bus 'ata', which collects all ata device
objects like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix
to the message log.
To be consistent with the other libata objects the 'ata_port' object name
has been changed from 'ata' to 'port'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-transport.c | 21 +++++++++++--
 include/linux/libata.h         | 54 ++++++++++------------------------
 2 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index ca129854a88c..555fe6e2293d 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -81,10 +81,13 @@ struct ata_internal {
 	tdev_to_port((dev)->parent)
 
 
-/* Device objects are always created whit link objects */
+/* Device objects are always created with link objects */
 static int ata_tdev_add(struct ata_device *dev);
 static void ata_tdev_delete(struct ata_device *dev);
 
+struct bus_type ata_bus_type = {
+        .name		= "ata",
+};
 
 /*
  * Hack to allow attributes of the same name in different objects.
@@ -288,7 +291,9 @@ int ata_tport_add(struct device *parent,
 	dev->parent = parent;
 	ata_host_get(ap->host);
 	dev->release = ata_tport_release;
-	dev_set_name(dev, "ata%d", ap->print_id);
+	dev->bus = &ata_bus_type;
+	dev_set_name(dev, "port%d", ap->print_id);
+
 	transport_setup_device(dev);
 	ata_acpi_bind_port(ap);
 	error = device_add(dev);
@@ -444,6 +449,8 @@ int ata_tlink_add(struct ata_link *link)
 	device_initialize(dev);
 	dev->parent = &ap->tdev;
 	dev->release = ata_tlink_release;
+	dev->bus = &ata_bus_type;
+
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
 	else
@@ -695,8 +702,10 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	device_initialize(dev);
 	dev->parent = &link->tdev;
 	dev->release = ata_tdev_release;
+	dev->bus = &ata_bus_type;
+
 	if (ata_is_host_link(link))
-		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
+		dev_set_name(dev, "dev%d.%d", ap->print_id, ata_dev->devno);
 	else
 		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
 
@@ -822,8 +831,13 @@ __init int libata_transport_init(void)
 	error = transport_class_register(&ata_dev_class);
 	if (error)
 		goto out_unregister_port;
+	error = bus_register(&ata_bus_type);
+	if (error)
+		goto out_unregister_bus;
 	return 0;
 
+ out_unregister_bus:
+	bus_unregister(&ata_bus_type);
  out_unregister_port:
 	transport_class_unregister(&ata_port_class);
  out_unregister_link:
@@ -835,6 +849,7 @@ __init int libata_transport_init(void)
 
 void __exit libata_transport_exit(void)
 {
+	bus_unregister(&ata_bus_type);
 	transport_class_unregister(&ata_link_class);
 	transport_class_unregister(&ata_port_class);
 	transport_class_unregister(&ata_dev_class);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0619ae462ecd..b17683b00c90 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -835,6 +835,7 @@ struct ata_port {
 	struct ata_host		*host;
 	struct device 		*dev;
 	struct device		tdev;
+	struct device		cdev;
 
 	struct mutex		scsi_scan_mutex;
 	struct delayed_work	hotplug_task;
@@ -1458,61 +1459,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
 	return link->pmp;
 }
 
-#define ata_port_printk(level, ap, fmt, ...)			\
-	pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
-
 #define ata_port_err(ap, fmt, ...)				\
-	ata_port_printk(err, ap, fmt, ##__VA_ARGS__)
+	dev_err(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_warn(ap, fmt, ...)				\
-	ata_port_printk(warn, ap, fmt, ##__VA_ARGS__)
+	dev_warn(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_notice(ap, fmt, ...)				\
-	ata_port_printk(notice, ap, fmt, ##__VA_ARGS__)
+	dev_notice(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_info(ap, fmt, ...)				\
-	ata_port_printk(info, ap, fmt, ##__VA_ARGS__)
+	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_dbg(ap, fmt, ...)				\
-	ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
-
-#define ata_link_printk(level, link, fmt, ...)			\
-do {								\
-	if (sata_pmp_attached((link)->ap) ||			\
-	    (link)->ap->slave_link)				\
-		pr_ ## level ("ata%u.%02u: " fmt,		\
-			      (link)->ap->print_id,		\
-			      (link)->pmp,			\
-			      ##__VA_ARGS__);			\
-        else							\
-		pr_ ## level ("ata%u: " fmt,			\
-			      (link)->ap->print_id,		\
-			      ##__VA_ARGS__);			\
-} while (0)
+	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
 
 #define ata_link_err(link, fmt, ...)				\
-	ata_link_printk(err, link, fmt, ##__VA_ARGS__)
+	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_warn(link, fmt, ...)				\
-	ata_link_printk(warn, link, fmt, ##__VA_ARGS__)
+	dev_warn(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_notice(link, fmt, ...)				\
-	ata_link_printk(notice, link, fmt, ##__VA_ARGS__)
+	dev_notice(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_info(link, fmt, ...)				\
-	ata_link_printk(info, link, fmt, ##__VA_ARGS__)
+	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_dbg(link, fmt, ...)				\
-	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
-
-#define ata_dev_printk(level, dev, fmt, ...)			\
-        pr_ ## level("ata%u.%02u: " fmt,			\
-               (dev)->link->ap->print_id,			\
-	       (dev)->link->pmp + (dev)->devno,			\
-	       ##__VA_ARGS__)
+	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
 
 #define ata_dev_err(dev, fmt, ...)				\
-	ata_dev_printk(err, dev, fmt, ##__VA_ARGS__)
+	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_warn(dev, fmt, ...)				\
-	ata_dev_printk(warn, dev, fmt, ##__VA_ARGS__)
+	dev_warn(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_notice(dev, fmt, ...)				\
-	ata_dev_printk(notice, dev, fmt, ##__VA_ARGS__)
+	dev_notice(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_info(dev, fmt, ...)				\
-	ata_dev_printk(info, dev, fmt, ##__VA_ARGS__)
+	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_dbg(dev, fmt, ...)				\
-	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
+	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)
 
 void ata_print_version(const struct device *dev, const char *version);
 
-- 
2.29.2

