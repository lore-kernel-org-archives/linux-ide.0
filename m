Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0297C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhLHQgd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40552 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbhLHQgc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2DF4B2177B;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ7PBxhsGP5OWdI2F3cljkcJqan0PuGfrQiDtz/oo90=;
        b=udUkiUDeDzc+3rVDg05Y8+K/4XhbuYXXCsbVh5gi+CMmxSZ8lUasDraCJB435Aw9zGxjiD
        Y1qKA9FvnUc/oZL7S8Sa+iR9yeIhK2I1L0Nr3YPZE88RgWczJjyrSWVBU1g7/EfApWPwwC
        I8cvS3PpV4cjO1gWVOPKqc90HZzxwVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ7PBxhsGP5OWdI2F3cljkcJqan0PuGfrQiDtz/oo90=;
        b=NpmG3B67YF4P5IQNhks928b/AFGazo5t4LbDzJWzLaEwx78JTKZ4dd1opCgfehPCJBuXdr
        Osso8i5Z5NYFAlDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 27F5DA3B95;
        Wed,  8 Dec 2021 16:32:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E46955191F65; Wed,  8 Dec 2021 17:32:59 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 04/73] libata: sanitize ATA_HORKAGE_DUMP_ID
Date:   Wed,  8 Dec 2021 17:31:46 +0100
Message-Id: <20211208163255.114660-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

As ata_dev_dbg() is now using dynamic debugging ATA_HORKAGE_DUMP_ID
will now print out the raw IDENTIFY data without a header unless
explicitly enable via dyndebug.
So move the logging level up to INFO and have the header printed
always.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6b8c6be65458..3977da2d098e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1894,10 +1894,10 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
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

