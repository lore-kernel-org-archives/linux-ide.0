Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B1AC04A68
	for <linux-ide@archiver.kernel.org>; Sat, 30 Jul 2022 18:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiG3SOw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 30 Jul 2022 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3SOv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2022 14:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 726CC13E99
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2022 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659204889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m9JGjngzQbL7mluEP0lW4A2kio8yv8hEU0K9ckJcYT8=;
        b=brX+TNNpUMQon3/lJw8Qn3FflE0aeP3Fw9PO7ok8o5jW9LaXG9Q/lDFKUA4y8SjbnAw28J
        4GO9WLuVOWD+97U4BqcdHoAKrDJlBSfD7U8sCfj+mZ/1KkbG0XwmGP5eWZ7eBMpunCYODN
        8qiTHM5lXLtkuEy9vQ68yd/dsyFpMXI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-owr6Kx0UMmCDAB6DZn0NVg-1; Sat, 30 Jul 2022 14:14:46 -0400
X-MC-Unique: owr6Kx0UMmCDAB6DZn0NVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF1821C0514F;
        Sat, 30 Jul 2022 18:14:45 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4727418EBB;
        Sat, 30 Jul 2022 18:14:45 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-ide@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com
Subject: [PATCH V2] libata: specify timeout value when internal command times out.
Date:   Sat, 30 Jul 2022 20:14:44 +0200
Message-Id: <20220730181444.6420-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Specifying timeout value may help in troubleshooting failures.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---

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

