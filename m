Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E50DC19F2A
	for <linux-ide@archiver.kernel.org>; Thu,  4 Aug 2022 14:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiHDOf1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Aug 2022 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiHDOf0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Aug 2022 10:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DC0C22B2D
        for <linux-ide@vger.kernel.org>; Thu,  4 Aug 2022 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659623724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QOJHL/pGQzT3tIq90CJQn6jYhq+AXxVvPpN0wHZqCaM=;
        b=FV8tuB8Pndf0hTSZGryc/65v+fV0EcoxRji6Alt0ZoqWt/SeWVpSkRtNaTNXFp2EYRV7kv
        6PDp2cjqI+F3oDqWWgchC8TdVDKaq3zGgJv2B3o8mT+H01fjhtFPnbyDQdJ9XWzjuizvXF
        /ee8BfbSDXEWAUNob+b56nCCAgNiMZ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-9I0ebCPoOpWv_kv3LWqzHA-1; Thu, 04 Aug 2022 10:35:21 -0400
X-MC-Unique: 9I0ebCPoOpWv_kv3LWqzHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03FDE18A0163;
        Thu,  4 Aug 2022 14:35:21 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AE18C28125;
        Thu,  4 Aug 2022 14:35:20 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-ide@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, damien.lemoal@opensource.wdc.com
Subject: [PATCH V3] libata: Print timeout value when internal command times out
Date:   Thu,  4 Aug 2022 16:35:19 +0200
Message-Id: <20220804143519.12245-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Print the timeout value may help in troubleshooting failures.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
V3: rewording subject and description, no functional change
V2: timeout changed to unsigned int as in for-next

 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d41f341e4..0fc4782ef4f8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1578,8 +1578,8 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 			else
 				ata_qc_complete(qc);
 
-			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
-				     command);
+			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
+				timeout, command);
 		}
 
 		spin_unlock_irqrestore(ap->lock, flags);

