Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1BC00140
	for <linux-ide@archiver.kernel.org>; Wed, 10 Aug 2022 17:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiHJR7T (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiHJR7R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2022 13:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBCAE6E8BE
        for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2022 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660154354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q3xayostq7nB2sBfDAv2QB+BK2A32TVrakXwxVmEgmw=;
        b=dgJSnwiN2T3jMA8EpxGB9rbJ3tycdKGEETtQNK359+EN3RDsogZ6/elTIiiYDlA+9jyD7U
        gNrFbVPcaj9Cj+1jFYmxF6YRFmjFTK4as73haT9lDUz1/vQVGz81i/O6a6WrORnSBe62B/
        G2zkgqQzvjSXYX1CE+7u6gaED9UwWjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-yvFRYbuAOcKDPqHZUeGGtg-1; Wed, 10 Aug 2022 13:59:11 -0400
X-MC-Unique: yvFRYbuAOcKDPqHZUeGGtg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 491E6801585;
        Wed, 10 Aug 2022 17:59:11 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95047492C3B;
        Wed, 10 Aug 2022 17:59:10 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-ide@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, damien.lemoal@opensource.wdc.com
Subject: [PATCH V4] ata: libata-core: Print timeout value when internal command times
Date:   Wed, 10 Aug 2022 19:59:09 +0200
Message-Id: <20220810175909.14485-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Printing the timeout value may help in troubleshooting failures.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
V4: a whitespace change
    a switch from an an infinitive to an -ing form in the body
    a fix to the title prefix
V3: rewording subject and description, no functional change
V2: timeout changed to unsigned int as in for-next
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d41f341e4..9478194740e0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1578,8 +1578,8 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 			else
 				ata_qc_complete(qc);
 
-			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
-				     command);
+			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
+				     timeout, command);
 		}
 
 		spin_unlock_irqrestore(ap->lock, flags);
-- 
2.37.1

