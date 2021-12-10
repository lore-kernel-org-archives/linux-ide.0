Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5116C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhLJHdY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhLJHdG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 20FDF212BC;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4AhgSZf/VsA90VPt4h7KPMKFmeAyN+6qG9Gu7ULn/s=;
        b=fSm6WyeL2lhGIuSyiJMt2ml/SPST4t8dgGXa8kmTAn4fm+ZFD3iVe11xnCo+VUjfWa6ReO
        kSrUfWSn0aQmn3/sWaQ6u1TAJDDGORUNrPB6pBJsetAJj5AYd76bWSg9wQBG1eh2JQ8CY/
        JUDLW+OoYBm+IZ+TiyOabUrVYZfgz3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4AhgSZf/VsA90VPt4h7KPMKFmeAyN+6qG9Gu7ULn/s=;
        b=Rt6G95aw3/lJW7XDb8emZUTvki/e62oYoIEUR+YGbJgj8ZeER/ApXZ981m+I8lcVUdr0Tg
        10bo39i8fOedZwAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1CC66A3B96;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 1B1265192081; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 48/68] pata_cmd640: convert printk() calls
Date:   Fri, 10 Dec 2021 08:28:45 +0100
Message-Id: <20211210072905.15666-49-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_cmd640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index d0bcabb58b44..1a3372a72213 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -61,7 +61,7 @@ static void cmd640_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	struct ata_device *pair = ata_dev_pair(adev);
 
 	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 0) < 0) {
-		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
+		ata_dev_err(adev, DRV_NAME ": mode computation failed.\n");
 		return;
 	}
 
-- 
2.29.2

