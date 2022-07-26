Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B720C00140
	for <linux-ide@archiver.kernel.org>; Tue, 26 Jul 2022 17:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGZRBP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 26 Jul 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGZRBN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2022 13:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA7F725C78
        for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2022 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658854872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a5b1vbJT5Pn025Ms8UrMApAEGmtd+RBL4r4q121a9qQ=;
        b=iPEjeUlkgW7O4eIxa1yDA//UTiaqg3zhd4Eex9IMH+5c7S1pERpmoA+xlwqOUla0amUOUS
        CZBv37z21YYkedNaxdDYHmrZ85VSIiGQuVcOZKr4Vfn0gNEJyeOgaGGcKMc0MpBuJQ1+Tr
        Y/p448JYo76aFNyARlTnCykzO5zvZwY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-E2zOe9O6PBCVf8Y53MbZIA-1; Tue, 26 Jul 2022 13:01:10 -0400
X-MC-Unique: E2zOe9O6PBCVf8Y53MbZIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5A42382C968
        for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2022 17:01:09 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B1311121314
        for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2022 17:01:09 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH] libata: specify timeout value when internal command times out.
Date:   Tue, 26 Jul 2022 19:01:08 +0200
Message-Id: <20220726170108.25087-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Specifying timeout value may help in troubleshooting failures.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 40e816419f48..e1f8a01a3b92 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1578,8 +1578,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 			else
 				ata_qc_complete(qc);
 
-			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
-				     command);
+			ata_dev_warn(dev, "qc timeout after %lu msecs (cmd 0x%x)\n",
+				timeout, command);
 		}
 
 		spin_unlock_irqrestore(ap->lock, flags);
-- 
2.35.3

