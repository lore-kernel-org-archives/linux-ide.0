Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C0C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 12:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359207AbiCYM6G (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Mar 2022 08:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359193AbiCYM6C (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2022 08:58:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49CD0AB7
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2022 05:56:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36A2C210DD;
        Fri, 25 Mar 2022 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648212987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dB/7/E+6FCLO+u1sKF9JIhE2GGEVw0tzwr3M8g7j/io=;
        b=VL5p4ZVKS6pIa60YhwFrzKC5g/9aBPbGqm3hUnHghZx8HV638zDjbP+i6Yn54l/g3KUX4l
        PVc0iUsO4R24hMhp3vGotKu2YLggp6w8OaM4jr+IvMzOt40zyC3S+NcAQBZYcFKxOs4lGx
        xVIsorlxgme7v2GvoLcB3Kd6G6dSAPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648212987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dB/7/E+6FCLO+u1sKF9JIhE2GGEVw0tzwr3M8g7j/io=;
        b=DGpGwtU+mo0H0FSMhByty204VKqhiTsPXxowt6ejIsCvJ/J9878/IUbrq5x0a4t+oCt9Xu
        8tU8h3FYWu+UcoCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1614FA3B96;
        Fri, 25 Mar 2022 12:56:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 05EAF519392B; Fri, 25 Mar 2022 13:56:27 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] libata: CONFIG_ATA_SYSFS_COMPAT
Date:   Fri, 25 Mar 2022 13:56:24 +0100
Message-Id: <20220325125624.99929-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220325125624.99929-1-hare@suse.de>
References: <20220325125624.99929-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add a config option 'ATA_SYSFS_COMPAT' to create a compatibility
'ata' symlink in the PCI device sysfs directory.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig            | 10 +++++++++
 drivers/ata/libata-transport.c | 41 ++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e5641e6c52ee..f27b12ba2ce7 100644
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
index e5ed5046b299..29dec89ccc2d 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -251,6 +251,39 @@ static int ata_tport_match(struct attribute_container *cont,
 	return &ata_scsi_transport_template->host_attrs.ac == cont;
 }
 
+#ifdef CONFIG_ATA_SYSFS_COMPAT
+static int ata_tport_compat_link_add(struct ata_port *ap)
+{
+        struct device *dev = &ap->tdev;
+	struct device *parent = dev->parent;
+        char compat_name[64];
+
+	sprintf(compat_name, "ata%d", ap->print_id);
+
+	return sysfs_create_link(&parent->kobj, &dev->kobj, compat_name);
+}
+
+static void ata_tport_compat_link_delete(struct ata_port *ap)
+{
+	struct device *dev = &ap->tdev;
+	struct device *parent = dev->parent;
+	char compat_name[64];
+
+	sprintf(compat_name, "ata%d", ap->print_id);
+	sysfs_remove_link(&parent->kobj, compat_name);
+}
+
+#else
+
+static inline int ata_tport_compat_link_add(struct ata_port *ap)
+{
+	return 0;
+}
+
+static inline void ata_tport_compat_link_delete(struct ata_port *ap) {}
+
+#endif
+
 /**
  * ata_tport_delete  --  remove ATA PORT
  * @ap:	ATA PORT to remove
@@ -261,6 +294,7 @@ void ata_tport_delete(struct ata_port *ap)
 {
 	struct device *dev = &ap->tdev;
 
+	ata_tport_compat_link_delete(ap);
 	ata_tlink_delete(&ap->link);
 
 	transport_remove_device(dev);
@@ -313,8 +347,15 @@ int ata_tport_add(struct device *parent,
 	if (error) {
 		goto tport_link_err;
 	}
+
+	error = ata_tport_compat_link_add(ap);
+	if (error)
+		goto compat_link_err;
+
 	return 0;
 
+ compat_link_err:
+	ata_tlink_delete(&ap->link);
  tport_link_err:
 	transport_remove_device(dev);
 	device_del(dev);
-- 
2.29.2

