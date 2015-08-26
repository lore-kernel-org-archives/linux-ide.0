From: "Guillermo A. Amaral" <g@maral.me>
Subject: [PATCH] Add factory recertified Crucial M500s to blacklist
Date: Tue, 25 Aug 2015 23:29:13 -0700
Message-ID: <1440570553-1600-2-git-send-email-g@maral.me>
References: <1440570553-1600-1-git-send-email-g@maral.me>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36858 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbHZGaP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2015 02:30:15 -0400
Received: by iodv127 with SMTP id v127so7455193iod.3
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2015 23:30:15 -0700 (PDT)
In-Reply-To: <1440570553-1600-1-git-send-email-g@maral.me>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, "Guillermo A. Amaral" <g@maral.me>

The Crucial M500 is known to have issues with queued TRIM commands, the
factory recertified SSDs use a different model number naming convention
which causes them to get ignored by the blacklist.

The new naming convention boils down to: s/Crucial_/FC/

Signed-off-by: Guillermo A. Amaral <g@maral.me>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 19bcb80..790e0de 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4230,6 +4230,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
-- 
2.4.6

