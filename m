Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2252C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 14:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349688AbiCUO6g (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349713AbiCUO6b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 10:58:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7C76287
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 07:57:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0FBF5210E1;
        Mon, 21 Mar 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647874624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdMugPoKoBDrp2Zb0dj50A+5zBbsfDO77t/YzvIKCSw=;
        b=Hk+WIRKbs9/Ov9ZXftnIYElj6z0XNPE7eNMQdfvd1N37dTLhBjhhGsOGhRY1ru7UViTf2M
        Vj4p2B9sGZKad3KavzOAtLsRObqRCo1dy3r3E8UrNTHrnfVHDQYVHE9+eENaY+W+52rWap
        3ct2Er6bFi+3j/HXWl+YWFEJ5UtQJMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647874624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdMugPoKoBDrp2Zb0dj50A+5zBbsfDO77t/YzvIKCSw=;
        b=wbsfzsNDEyteaJGYImyjt0q0BlScbFhsjZohwzCwvRSP5R04bU1LAEdrkpD39dwt6M8vHz
        OHPNzE9SyYoWXeBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D19DBA3B88;
        Mon, 21 Mar 2022 14:57:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C03345193831; Mon, 21 Mar 2022 15:57:03 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] libata: CONFIG_ATA_SYSFS_COMPAT
Date:   Mon, 21 Mar 2022 15:56:58 +0100
Message-Id: <20220321145659.97150-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220321145659.97150-1-hare@suse.de>
References: <20220321145659.97150-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add a config option 'ATA_SYSFS_COMPAT' to allow the user to select
whether the compability 'ata_port' object with the name of 'ata'
should be registered with sysfs.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig            | 10 ++++++++++
 drivers/ata/libata-transport.c | 19 ++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cb54631fd950..fe42a246d21d 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -51,6 +51,16 @@ config ATA_VERBOSE_ERROR
 
 	  If unsure, say Y.
 
+config ATA_SYSFS_COMPAT
+	bool "Keep original sysfs layout"
+	default y
+	help
+	  This option retains the original sysfs layout by adding an
+	  additional ata_port object with the name of 'ataX' in
+	  to the ATA objects like 'ata_port', 'ata_link', and 'ata_device'.
+
+	  If unsure, say Y.
+
 config ATA_FORCE
 	bool "\"libata.force=\" kernel parameter support" if EXPERT
 	default y
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 5169a5db141d..efca41039d1e 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -261,15 +261,21 @@ static int ata_tport_match(struct attribute_container *cont,
 void ata_tport_delete(struct ata_port *ap)
 {
 	struct device *dev = &ap->tdev;
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	struct device *cdev = &ap->cdev;
+#endif
 
 	ata_tlink_delete(&ap->link);
 
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	device_del(cdev);
+#endif
 	transport_remove_device(dev);
 	device_del(dev);
 	transport_destroy_device(dev);
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	put_device(cdev);
+#endif
 	put_device(dev);
 }
 
@@ -288,7 +294,9 @@ int ata_tport_add(struct device *parent,
 {
 	int error;
 	struct device *dev = &ap->tdev;
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	struct device *cdev = &ap->cdev;
+#endif
 
 	device_initialize(dev);
 	dev->type = &ata_port_type;
@@ -299,23 +307,24 @@ int ata_tport_add(struct device *parent,
 	dev->bus = &ata_bus_type;
 	dev_set_name(dev, "port%d", ap->print_id);
 
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	device_initialize(cdev);
 	cdev->parent = get_device(dev);
 	cdev->class = &ata_port_class.class;
 	dev_set_name(cdev, "ata%d", ap->print_id);
-
+#endif
 	transport_setup_device(dev);
 	ata_acpi_bind_port(ap);
 	error = device_add(dev);
 	if (error) {
 		goto tport_err;
 	}
-
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	error = device_add(cdev);
 	if (error) {
 		goto cdev_err;
 	}
-
+#endif
 	device_enable_async_suspend(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -331,14 +340,18 @@ int ata_tport_add(struct device *parent,
 	return 0;
 
  tport_link_err:
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	device_del(cdev);
  cdev_err:
+#endif
 	transport_remove_device(dev);
 	device_del(dev);
 
  tport_err:
 	transport_destroy_device(dev);
+#ifdef CONFIG_ATA_SYSFS_COMPAT
 	put_device(cdev);
+#endif
 	put_device(dev);
 	ata_host_put(ap->host);
 	return error;
-- 
2.29.2

