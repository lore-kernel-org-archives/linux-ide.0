Return-Path: <SRS0=c3L7=44=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD09C10F25
	for <linux-ide@archiver.kernel.org>; Wed, 11 Mar 2020 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC69A20727
	for <linux-ide@archiver.kernel.org>; Wed, 11 Mar 2020 07:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgCKHLI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:11:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHLI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 11 Mar 2020 03:11:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4C9DAF57;
        Wed, 11 Mar 2020 07:11:06 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH] libata: transport: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:11:00 +0100
Message-Id: <20200311071100.3969-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/ata/libata-transport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 12a505bb9c5b..6a40e3c6cf49 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -208,7 +208,7 @@ show_ata_port_##name(struct device *dev,				\
 {									\
 	struct ata_port *ap = transport_class_to_port(dev);		\
 									\
-	return snprintf(buf, 20, format_string, cast ap->field);	\
+	return scnprintf(buf, 20, format_string, cast ap->field);	\
 }
 
 #define ata_port_simple_attr(field, name, format_string, type)		\
@@ -479,7 +479,7 @@ show_ata_dev_##field(struct device *dev,				\
 {									\
 	struct ata_device *ata_dev = transport_class_to_dev(dev);	\
 									\
-	return snprintf(buf, 20, format_string, cast ata_dev->field);	\
+	return scnprintf(buf, 20, format_string, cast ata_dev->field);	\
 }
 
 #define ata_dev_simple_attr(field, format_string, type)	\
@@ -533,7 +533,7 @@ show_ata_dev_id(struct device *dev,
 	if (ata_dev->class == ATA_DEV_PMP)
 		return 0;
 	for(i=0;i<ATA_ID_WORDS;i++)  {
-		written += snprintf(buf+written, 20, "%04x%c",
+		written += scnprintf(buf+written, 20, "%04x%c",
 				    ata_dev->id[i],
 				    ((i+1) & 7) ? ' ' : '\n');
 	}
@@ -552,7 +552,7 @@ show_ata_dev_gscr(struct device *dev,
 	if (ata_dev->class != ATA_DEV_PMP)
 		return 0;
 	for(i=0;i<SATA_PMP_GSCR_DWORDS;i++)  {
-		written += snprintf(buf+written, 20, "%08x%c",
+		written += scnprintf(buf+written, 20, "%08x%c",
 				    ata_dev->gscr[i],
 				    ((i+1) & 3) ? ' ' : '\n');
 	}
@@ -581,7 +581,7 @@ show_ata_dev_trim(struct device *dev,
 	else
 		mode = "unqueued";
 
-	return snprintf(buf, 20, "%s\n", mode);
+	return scnprintf(buf, 20, "%s\n", mode);
 }
 
 static DEVICE_ATTR(trim, S_IRUGO, show_ata_dev_trim, NULL);
-- 
2.16.4

