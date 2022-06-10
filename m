Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF637C43334
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 08:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347445AbiFJISv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 04:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbiFJISl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 04:18:41 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA9324803B;
        Fri, 10 Jun 2022 01:18:26 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C2ECB16A0;
        Fri, 10 Jun 2022 11:19:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C2ECB16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849146;
        bh=DbC4FemQLlfeBdKJ7tWncqFJzy1ocACCRibfynjYwek=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=HxXKo7N2ZU3QmyN4reV2jxdgYKJ3P0V9YiiFdaO55xUL1bg2P4UsH9JIbGNseEOKf
         R5C7vNeYrrsK4Q2KIb1V3RFd4SQgOWNJf5eFkkNowp2YjFQOo4XvXG8fAV6t4V1y5e
         89ZZX0qXj61dSX0nE2TsYKOyeU+C0Ki0MyxaoWpk=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:14 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 14/23] ata: libahci: Don't read AHCI version twice in the save-config method
Date:   Fri, 10 Jun 2022 11:17:52 +0300
Message-ID: <20220610081801.11854-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no point in reading the AHCI version all over in the tail of the
ahci_save_initial_config() method. That register is RO and doesn't change
its value even after reset. So just reuse the data, which has already been
read from there earlier in the head of the function.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 000a7072614f..1ffaa5f5f21a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -564,7 +564,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 	/* record values to use during operation */
 	hpriv->cap = cap;
 	hpriv->cap2 = cap2;
-	hpriv->version = readl(mmio + HOST_VERSION);
+	hpriv->version = vers;
 	hpriv->port_map = port_map;
 
 	if (!hpriv->start_engine)
-- 
2.35.1

