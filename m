Return-Path: <SRS0=Q01X=U6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8964C0650E
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CC22146F
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfGAQ6V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:58:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfGAQ6V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 1 Jul 2019 12:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A35EE30C31B8;
        Mon,  1 Jul 2019 16:58:16 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A98682CFB8;
        Mon,  1 Jul 2019 16:58:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Drop firmware version check from the ST1000LM024 quirk
Date:   Mon,  1 Jul 2019 18:58:13 +0200
Message-Id: <20190701165813.15607-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 01 Jul 2019 16:58:21 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There are several firmware versions between version 2AR10001 and
2BA30001, presumably these also have broken FPDMA_AA activation, so
lets play it safe and apply the quirk to all firmware versions.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a2dff303865..28c492be0a57 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4462,9 +4462,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* drives which fail FPDMA_AA activation (some may freeze afterwards)
 	   the ST disks also have LPM issues */
-	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
-						ATA_HORKAGE_NOLPM, },
-	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
+	{ "ST1000LM024 HN-M101MBB", NULL,	ATA_HORKAGE_BROKEN_FPDMA_AA |
 						ATA_HORKAGE_NOLPM, },
 	{ "VB0250EAVER",	"HPG7",		ATA_HORKAGE_BROKEN_FPDMA_AA },
 
-- 
2.21.0

