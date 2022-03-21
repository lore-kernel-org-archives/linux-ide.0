Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE720C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 14:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiCUO6f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbiCUO6b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 10:58:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9FA76284
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 07:57:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A0F31F385;
        Mon, 21 Mar 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647874624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpnJVgPMM+0HHOjsqvI0E2xJTV/cfX9ooJIEUDxXuuc=;
        b=Jlg3hNXa5bzxFHn9Zpq3+WASMKA1oV5XNFzCiD5O6Oj4NHJdfM/9/PUgsRVbnzesX0ZVI8
        6mogF5FaKn/2rJg+I0hL4JkSa24UW5aEAvmsqsQkItaieynNOdZ11BYTZBSHPv+5pkAUxy
        jp0qAB5cMAthSY2FPrMXWX/AJlAziXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647874624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpnJVgPMM+0HHOjsqvI0E2xJTV/cfX9ooJIEUDxXuuc=;
        b=PZtVNAmGWjoNdyDd0uhXFz+hImQexaGMhpwjJ4iMRXXlHc7S74unT6Y4YbfJBVgQdsU7wT
        v2RknsdUoHXGmTCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CE2D2A3B81;
        Mon, 21 Mar 2022 14:57:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id BD8A2519382F; Mon, 21 Mar 2022 15:57:03 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] libata: sysfs naming option
Date:   Mon, 21 Mar 2022 15:56:57 +0100
Message-Id: <20220321145659.97150-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220321145659.97150-1-hare@suse.de>
References: <20220321145659.97150-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds a new dummy bus 'ata', which collects all ata device
objects like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix
to the message log.
For consistency the 'ata_port' name has been changed from 'ata' to 'port';
to cover for sysfs incompabilities I've added a link from the original
'ata' device to the new 'port' device.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-transport.c | 38 ++++++++++++++++++++++--
 include/linux/libata.h         | 54 ++++++++++------------------------
 2 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index ca129854a88c..5169a5db141d 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -81,10 +81,14 @@ struct ata_internal {
 	tdev_to_port((dev)->parent)
 
 
-/* Device objects are always created whit link objects */
+/* Device objects are always created with link objects */
 static int ata_tdev_add(struct ata_device *dev);
 static void ata_tdev_delete(struct ata_device *dev);
 
+struct bus_type ata_bus_type = {
+        .name		= "ata",
+};
+
 
 /*
  * Hack to allow attributes of the same name in different objects.
@@ -257,12 +261,15 @@ static int ata_tport_match(struct attribute_container *cont,
 void ata_tport_delete(struct ata_port *ap)
 {
 	struct device *dev = &ap->tdev;
+	struct device *cdev = &ap->cdev;
 
 	ata_tlink_delete(&ap->link);
 
+	device_del(cdev);
 	transport_remove_device(dev);
 	device_del(dev);
 	transport_destroy_device(dev);
+	put_device(cdev);
 	put_device(dev);
 }
 
@@ -281,6 +288,7 @@ int ata_tport_add(struct device *parent,
 {
 	int error;
 	struct device *dev = &ap->tdev;
+	struct device *cdev = &ap->cdev;
 
 	device_initialize(dev);
 	dev->type = &ata_port_type;
@@ -288,7 +296,14 @@ int ata_tport_add(struct device *parent,
 	dev->parent = parent;
 	ata_host_get(ap->host);
 	dev->release = ata_tport_release;
-	dev_set_name(dev, "ata%d", ap->print_id);
+	dev->bus = &ata_bus_type;
+	dev_set_name(dev, "port%d", ap->print_id);
+
+	device_initialize(cdev);
+	cdev->parent = get_device(dev);
+	cdev->class = &ata_port_class.class;
+	dev_set_name(cdev, "ata%d", ap->print_id);
+
 	transport_setup_device(dev);
 	ata_acpi_bind_port(ap);
 	error = device_add(dev);
@@ -296,6 +311,11 @@ int ata_tport_add(struct device *parent,
 		goto tport_err;
 	}
 
+	error = device_add(cdev);
+	if (error) {
+		goto cdev_err;
+	}
+
 	device_enable_async_suspend(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -311,11 +331,14 @@ int ata_tport_add(struct device *parent,
 	return 0;
 
  tport_link_err:
+	device_del(cdev);
+ cdev_err:
 	transport_remove_device(dev);
 	device_del(dev);
 
  tport_err:
 	transport_destroy_device(dev);
+	put_device(cdev);
 	put_device(dev);
 	ata_host_put(ap->host);
 	return error;
@@ -444,6 +467,8 @@ int ata_tlink_add(struct ata_link *link)
 	device_initialize(dev);
 	dev->parent = &ap->tdev;
 	dev->release = ata_tlink_release;
+	dev->bus = &ata_bus_type;
+
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
 	else
@@ -695,8 +720,10 @@ static int ata_tdev_add(struct ata_device *ata_dev)
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
 
@@ -822,8 +849,13 @@ __init int libata_transport_init(void)
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 605756f645be..3460d7684464 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -829,6 +829,7 @@ struct ata_port {
 	struct ata_host		*host;
 	struct device 		*dev;
 	struct device		tdev;
+	struct device		cdev;
 
 	struct mutex		scsi_scan_mutex;
 	struct delayed_work	hotplug_task;
@@ -1452,61 +1453,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
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

