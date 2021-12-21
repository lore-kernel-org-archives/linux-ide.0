Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB04C4321E
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhLUHWo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhLUHWm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B0255212CA;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SmDRaAbpO161Kk8uoRN+a56dCF1V84mIwY2DGV4wVeI=;
        b=hP/vqMkh3ve4hU1BWAYgIjvGWbafJepyRqg0dEA6+5x1NsKU/Zg+VIfaz+pJKWyOrdQT2b
        rBtg0i69DxpD4zMHYlSD/q7lj1luOozLLs8mqzIXHdfUMrBp1DdYvTA+4CwLXjmdK2FP1G
        UKQQr9U1THL2Pp1AkhWOHA+ej2puKa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SmDRaAbpO161Kk8uoRN+a56dCF1V84mIwY2DGV4wVeI=;
        b=8YdIkyvsCqKk6utTZxGGFGYxRMXlsHSrKo6oBGmKxvFwZs5CBe8s2xRCQQGy6eS6eciTsm
        YBp7NZfh0gUyfECg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A9C71A3B89;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id A735E519237C; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/68] libata: sanitize ATA_HORKAGE_DUMP_ID
Date:   Tue, 21 Dec 2021 08:20:28 +0100
Message-Id: <20211221072131.46673-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

With moving ata_dev_dbg() over to dynamic debugging ATA_HORKAGE_DUMP_ID
will now print out the raw IDENTIFY data without a header unless
explicitly enable via dyndebug.
So move the logging level up to INFO and have the header printed
always.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c9e8fab05a9a..0517a3a17507 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1848,10 +1848,10 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	}
 
 	if (dev->horkage & ATA_HORKAGE_DUMP_ID) {
-		ata_dev_dbg(dev, "dumping IDENTIFY data, "
+		ata_dev_info(dev, "dumping IDENTIFY data, "
 			    "class=%d may_fallback=%d tried_spinup=%d\n",
 			    class, may_fallback, tried_spinup);
-		print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET,
+		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
 			       16, 2, id, ATA_ID_WORDS * sizeof(*id), true);
 	}
 
-- 
2.29.2

