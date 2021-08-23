Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB42C4338F
	for <linux-ide@archiver.kernel.org>; Mon, 23 Aug 2021 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEEC61374
	for <linux-ide@archiver.kernel.org>; Mon, 23 Aug 2021 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhHWJxL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235802AbhHWJxI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2021 05:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629712346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rcf7ZbhkmpU4jxeIC6SCvGLuTy9wJXPCflo+vJTD3XI=;
        b=CfIlP2udcDrh5kizgvOwTjVYHI28d4OckTeoLBSFYYKg8pz3hprovFgldHKmbxa3TAGMmp
        qFfmkWDu7YikfHTQKrWdsKxOea6XNAdp0dlZqsq1pT1v0dUFMUsTHbVMixamfGvVz/YZPr
        hhgm6cRtH04/BNjrN7ZM5YJIDvSY6KY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-w-8wv1IyNq-p8_mPHt2Q7g-1; Mon, 23 Aug 2021 05:52:24 -0400
X-MC-Unique: w-8wv1IyNq-p8_mPHt2Q7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B11FD100E427;
        Mon, 23 Aug 2021 09:52:23 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10DDC60CC9;
        Mon, 23 Aug 2021 09:52:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH] libata: add ATA_HORKAGE_NO_NCQ_TRIM for Samsung 860 and 870 SSDs
Date:   Mon, 23 Aug 2021 11:52:20 +0200
Message-Id: <20210823095220.30157-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Commit ca6bfcb2f6d9 ("libata: Enable queued TRIM for Samsung SSD 860")
limited the existing ATA_HORKAGE_NO_NCQ_TRIM quirk from "Samsung SSD 8*",
covering all Samsung 800 series SSDs, to only apply to "Samsung SSD 840*"
and "Samsung SSD 850*" series based on information from Samsung.

But there is a large number of users which is still reporting issues
with the Samsung 860 and 870 SSDs combined with Intel, ASmedia or
Marvell SATA controllers and all reporters also report these problems
going away when disabling queued trims.

Note that with AMD SATA controllers users are reporting even worse
issues and only completely disabling NCQ helps there, this will be
addressed in a separate patch.

Fixes: ca6bfcb2f6d9 ("libata: Enable queued TRIM for Samsung SSD 860")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=203475
Cc: stable@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 61c762961ca8..3eda3291952b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3950,6 +3950,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 860*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
-- 
2.31.1

