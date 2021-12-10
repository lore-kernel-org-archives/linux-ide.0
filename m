Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3AEC43217
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhLJHdD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47024 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbhLJHcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4D481F3A4;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85Zd34V/HLr2F6G2pbHAdRg6Pk3WDRAAEYy9lEQnYE8=;
        b=TZyxEFwqzGDkN9kPhjWCsxSkvByZ3lFADyVL+uPeuBd2kj6xMjqvIocAbu89qmCjlhdzt/
        ikk4DVmRWLxhp5MXQFx354PADAU0L42OUBhnkC9K0+TTdsoxJPLrjyEdixlUCTBb5SfuF1
        41fRvqCgcWkpyAZFtdT9qyoNwNP6CVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85Zd34V/HLr2F6G2pbHAdRg6Pk3WDRAAEYy9lEQnYE8=;
        b=xVRKu4rJrYHlnEUNez/1wWvEqniuZ7HAbmvNuD3lt4ax41smcVusr7sdD/YnY9a4y0kXwt
        nte5dfMKKrbIuoDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9B0ABA3BA3;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 8C9B1519203B; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/68] libata: revamp ata_get_cmd_descript()
Date:   Fri, 10 Dec 2021 08:28:10 +0100
Message-Id: <20211210072905.15666-14-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Rename ata_get_cmd_descrip() to ata_get_cmd_name() and simplify
it to return 'unknown' instead of NULL.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-acpi.c |  4 +---
 drivers/ata/libata-eh.c   | 20 ++++++++------------
 drivers/ata/libata.h      |  2 +-
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 7007377880ce..9e1e62b9cf63 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -664,9 +664,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 		pptf = &ptf;
 	}
 
-	descr = ata_get_cmd_descript(tf.command);
-	if (!descr)
-		descr = "unknown";
+	descr = ata_get_cmd_name(tf.command);
 
 	if (!ata_acpi_filter_tf(dev, &tf, pptf)) {
 		rtf = tf;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 69f51616d8bd..29a64059d3a1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2080,16 +2080,15 @@ void ata_eh_autopsy(struct ata_port *ap)
 }
 
 /**
- *	ata_get_cmd_descript - get description for ATA command
+ *	ata_get_cmd_name - get description for ATA command
  *	@command: ATA command code to get description for
  *
- *	Return a textual description of the given command, or NULL if the
- *	command is not known.
+ *	Return a textual description of the given command or "unknown"
  *
  *	LOCKING:
  *	None
  */
-const char *ata_get_cmd_descript(u8 command)
+const char *ata_get_cmd_name(u8 command)
 {
 #ifdef CONFIG_ATA_VERBOSE_ERROR
 	static const struct
@@ -2197,9 +2196,9 @@ const char *ata_get_cmd_descript(u8 command)
 			return cmd_descr[i].text;
 #endif
 
-	return NULL;
+	return "unknown";
 }
-EXPORT_SYMBOL_GPL(ata_get_cmd_descript);
+EXPORT_SYMBOL_GPL(ata_get_cmd_name);
 
 /**
  *	ata_eh_link_report - report error handling to user
@@ -2348,12 +2347,9 @@ static void ata_eh_link_report(struct ata_link *link)
 			}
 			__scsi_format_command(cdb_buf, sizeof(cdb_buf),
 					      cdb, cdb_len);
-		} else {
-			const char *descr = ata_get_cmd_descript(cmd->command);
-			if (descr)
-				ata_dev_err(qc->dev, "failed command: %s\n",
-					    descr);
-		}
+		} else
+			ata_dev_err(qc->dev, "failed command: %s\n",
+				    ata_get_cmd_name(cmd->command));
 
 		ata_dev_err(qc->dev,
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 4a8f4623cfe5..2144065e762c 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -166,7 +166,7 @@ extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 			unsigned int action);
 extern void ata_eh_autopsy(struct ata_port *ap);
-const char *ata_get_cmd_descript(u8 command);
+const char *ata_get_cmd_name(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
-- 
2.29.2

