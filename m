Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBDCC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 12:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348665AbiCXMdn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347509AbiCXMdm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 08:33:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185AEA9946
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 05:32:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A033021601;
        Thu, 24 Mar 2022 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648125128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG7gSSIkIOTl5gU7+sNOqs8b1fbJMjTDoTy6nWXtud8=;
        b=0pUlWmBAog+BgocZgQdCyrPt4CKxh696tMWDOCUkad0GN6PxDku+PKAoPpBOeNZKCPmrKj
        0fcllesv6DzuYve14p9e0GN12jPuipX4SYRUVv0q8KBawTZpKvPw7gPtZbGpimAaKoVjDE
        ammhzozetUP7+J09+e2vRQ8K0+AZE/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648125128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG7gSSIkIOTl5gU7+sNOqs8b1fbJMjTDoTy6nWXtud8=;
        b=vo+on5Ad6SuJ6E9nE6HhFF5gDt9An/IeVd5lBmBzyyDrpevI8xZ61Aa/PFvZ7FmDH3cQ4s
        Yd0FbU1HzbCbbpAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7FA43A3B92;
        Thu, 24 Mar 2022 12:32:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6FD6E51938FD; Thu, 24 Mar 2022 13:32:08 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] libata: CONFIG_ATA_SYSFS_COMPAT
Date:   Thu, 24 Mar 2022 13:32:04 +0100
Message-Id: <20220324123204.61534-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220324123204.61534-1-hare@suse.de>
References: <20220324123204.61534-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add a config option 'ATA_SYSFS_COMPAT' to create a compability
'ata' symlink in the PCI device sysfs directory.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig            | 10 ++++++++++
 drivers/ata/libata-transport.c | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

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
index 555fe6e2293d..a66c3480bdcf 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -260,7 +260,13 @@ static int ata_tport_match(struct attribute_container *cont,
 void ata_tport_delete(struct ata_port *ap)
 {
 	struct device *dev = &ap->tdev;
+#ifdef CONFIG_ATA_SYSFS_COMPAT
+	struct device *parent = dev->parent;
+	char compat_name[64];
 
+	sprintf(compat_name, "ata%d", ap->print_id);
+	sysfs_remove_link(&parent->kobj, compat_name);
+#endif
 	ata_tlink_delete(&ap->link);
 
 	transport_remove_device(dev);
@@ -284,6 +290,9 @@ int ata_tport_add(struct device *parent,
 {
 	int error;
 	struct device *dev = &ap->tdev;
+#ifdef CONFIG_ATA_SYSFS_COMPAT
+	char compat_name[64];
+#endif
 
 	device_initialize(dev);
 	dev->type = &ata_port_type;
@@ -313,8 +322,19 @@ int ata_tport_add(struct device *parent,
 	if (error) {
 		goto tport_link_err;
 	}
+
+#ifdef CONFIG_ATA_SYSFS_COMPAT
+	sprintf(compat_name, "ata%d", ap->print_id);
+	error = sysfs_create_link(&parent->kobj, &dev->kobj, compat_name);
+	if (error)
+		goto compat_link_err;
+#endif
 	return 0;
 
+#ifdef CONFIG_ATA_SYSFS_COMPAT
+ compat_link_err:
+	ata_tlink_delete(&ap->link);
+#endif
  tport_link_err:
 	transport_remove_device(dev);
 	device_del(dev);
-- 
2.29.2

