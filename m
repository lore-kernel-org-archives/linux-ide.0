Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8568C433F5
	for <linux-ide@archiver.kernel.org>; Mon,  3 Jan 2022 09:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiACJJv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 Jan 2022 04:09:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiACJJu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2022 04:09:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D78972113D;
        Mon,  3 Jan 2022 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641200989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oQb5UQRfAKf3EkeFm0+kKQzfJZUumrFFYf8iNBh3K+o=;
        b=r1XCt2tbPGlQArXS6awGqopySExxvp8WzNvqAQfq/EcVLSdZ+xQvaPj1EQ+l6962sS43Bn
        Xc8IbwEYO5/OaPOVVGTNmDxzWPXMSREqZttTIRAS0YxfRhJSDAubpEvXR6Tp/aCjQnq6U/
        MK2BwkbtfJi6UStojPiAmBswUWQJWn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641200989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oQb5UQRfAKf3EkeFm0+kKQzfJZUumrFFYf8iNBh3K+o=;
        b=jMONxCIv+t7VHi6eVmV7mlYzbf3wkG80RmKZrJRhZbP5NZIVpXcJ3rhmzfNDWq7kN8hf1c
        lyQNAh1oD8+vRWCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A76ABA3B88;
        Mon,  3 Jan 2022 09:09:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9B5F05192682; Mon,  3 Jan 2022 10:09:49 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH] libata: sysfs naming option
Date:   Mon,  3 Jan 2022 10:09:39 +0100
Message-Id: <20220103090939.36238-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds a config option ATA_SYSFS_NAMING to align the libata
device names in sysfs with those in the kernel message log.
It adds a new dummy bus 'ata', which collects all ata device objects
like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix to the
message log.
For consistency the 'ata_dev' name has been changed from 'ata' to 'dev';
as this induces a sysfs change the config option is disabled per default.

Patch is relative to the 'for-5.17-logging' branch from Damien.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig            | 17 ++++++++++++++++
 drivers/ata/libata-transport.c | 24 +++++++++++++++++++++--
 include/linux/libata.h         | 36 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index f6e943c74001..9ebaa3c288dd 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -51,6 +51,23 @@ config ATA_VERBOSE_ERROR
 
 	  If unsure, say Y.
 
+config ATA_SYSFS_NAMING
+	bool "Align sysfs device names with kernel messages"
+	default n
+	help
+	  This option modifies the device naming to use a common
+	  format for all ATA objects (port, link, and devices) and use
+	  these names for both the sysfs directories and the kernel message
+	  log to align with the linux driver model.
+	  The names have the format ata<port>-<link>.<device>, such that an
+	  ATA port will have the name 'ata<port>', an ATA link the name
+	  'ata<port>-<link>', and an ATA device the name
+	  'ata<port>-<link>.<devno>'.
+	  This option changes the sysfs names, so userland tools might be
+	  impacted.
+
+	  If unsure, say N.
+
 config ATA_FORCE
 	bool "\"libata.force=\" kernel parameter support" if EXPERT
 	default y
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index ca129854a88c..b537eadc6501 100644
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
@@ -288,7 +292,12 @@ int ata_tport_add(struct device *parent,
 	dev->parent = parent;
 	ata_host_get(ap->host);
 	dev->release = ata_tport_release;
+#ifdef CONFIG_ATA_SYSFS_NAMING
+	dev->bus = &ata_bus_type;
+	dev_set_name(dev, "port%d", ap->print_id);
+#else
 	dev_set_name(dev, "ata%d", ap->print_id);
+#endif
 	transport_setup_device(dev);
 	ata_acpi_bind_port(ap);
 	error = device_add(dev);
@@ -444,6 +453,9 @@ int ata_tlink_add(struct ata_link *link)
 	device_initialize(dev);
 	dev->parent = &ap->tdev;
 	dev->release = ata_tlink_release;
+#ifdef CONFIG_ATA_SYSFS_NAMING
+	dev->bus = &ata_bus_type;
+#endif
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
 	else
@@ -695,8 +707,11 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	device_initialize(dev);
 	dev->parent = &link->tdev;
 	dev->release = ata_tdev_release;
+#ifdef CONFIG_ATA_SYSFS_NAMING
+	dev->bus = &ata_bus_type;
+#endif
 	if (ata_is_host_link(link))
-		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
+		dev_set_name(dev, "dev%d.%d", ap->print_id, ata_dev->devno);
 	else
 		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
 
@@ -822,8 +837,13 @@ __init int libata_transport_init(void)
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
index c258f69106f4..ab2d404cde08 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1440,6 +1440,41 @@ static inline int sata_srst_pmp(struct ata_link *link)
 	return link->pmp;
 }
 
+#ifdef CONFIG_ATA_SYSFS_NAMING
+#define ata_port_err(ap, fmt, ...)				\
+	dev_err(&ap->tdev, fmt, ##__VA_ARGS__)
+#define ata_port_warn(ap, fmt, ...)				\
+	dev_warn(&ap->tdev, fmt, ##__VA_ARGS__)
+#define ata_port_notice(ap, fmt, ...)				\
+	dev_notice(&ap->tdev, fmt, ##__VA_ARGS__)
+#define ata_port_info(ap, fmt, ...)				\
+	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
+#define ata_port_dbg(ap, fmt, ...)				\
+	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
+
+#define ata_link_err(link, fmt, ...)				\
+	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
+#define ata_link_warn(link, fmt, ...)				\
+	dev_warn(&link->tdev, fmt, ##__VA_ARGS__)
+#define ata_link_notice(link, fmt, ...)				\
+	dev_notice(&link->tdev, fmt, ##__VA_ARGS__)
+#define ata_link_info(link, fmt, ...)				\
+	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
+#define ata_link_dbg(link, fmt, ...)				\
+	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
+
+#define ata_dev_err(dev, fmt, ...)				\
+	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
+#define ata_dev_warn(dev, fmt, ...)				\
+	dev_warn(&dev->tdev, fmt, ##__VA_ARGS__)
+#define ata_dev_notice(dev, fmt, ...)				\
+	dev_notice(&dev->tdev, fmt, ##__VA_ARGS__)
+#define ata_dev_info(dev, fmt, ...)				\
+	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
+#define ata_dev_dbg(dev, fmt, ...)				\
+	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)
+
+#else
 #define ata_port_printk(level, ap, fmt, ...)			\
 	pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
 
@@ -1495,6 +1530,7 @@ do {								\
 	ata_dev_printk(info, dev, fmt, ##__VA_ARGS__)
 #define ata_dev_dbg(dev, fmt, ...)				\
 	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
+#endif
 
 void ata_print_version(const struct device *dev, const char *version);
 
-- 
2.29.2

