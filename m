Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A72C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 06:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhLHHCc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 02:02:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35676 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhLHHCb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 02:02:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A8C8C1FDFC;
        Wed,  8 Dec 2021 06:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638946739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=biox831RciFqw8K1uTdlqBZsv3Rtk/1G68JAHHUFa1s=;
        b=jOsowoa+4bnrqkNYoeb+0V71uX3W5H+FW8IaOYSMq90DtM6NArnyB8S6P50X+wSPz4+Bfz
        sZkVb7nPPXDNkPhsi96w0sJRf6nLxMoZAWhyVOQb33ogUOk4CsvjLaHpNozKLlwRHTTx5p
        vkaWAbBJMmXRKV+u8mei0fwbC6Y262I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638946739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=biox831RciFqw8K1uTdlqBZsv3Rtk/1G68JAHHUFa1s=;
        b=nOMzHsPHdsJ2zqSKo+C0JqL2ycj21KHekaD/UOIyllVsHvOB2M6TSMOQR3jkmS/wDHdp+G
        icYlmcNk/4GEDgDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 71E3BA3B81;
        Wed,  8 Dec 2021 06:58:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 65FAE5191EE5; Wed,  8 Dec 2021 07:58:59 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] libata: add horkage for ASMedia 1092
Date:   Wed,  8 Dec 2021 07:58:53 +0100
Message-Id: <20211208065853.5270-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The ASMedia 1092 has a configuration mode which will present a
dummy device; sadly the implementation falsely claims to provide
a device with 100M which doesn't actually exist.
So disable this device to avoid errors during boot.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9c05177e09c2..f1a2f0a4ce05 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4416,6 +4416,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_HORKAGE_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
 	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
+	/* Similar story with ASMedia 1092 */
+	{ "ASMT109x- Config",	NULL,		ATA_HORKAGE_DISABLE },
 
 	/* Weird ATAPI devices */
 	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
-- 
2.29.2

