Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748EEC4332F
	for <linux-ide@archiver.kernel.org>; Wed, 11 May 2022 23:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349240AbiEKXTF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 May 2022 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiEKXSe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2022 19:18:34 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85E6F18FF2E;
        Wed, 11 May 2022 16:18:31 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id DD854BAD;
        Thu, 12 May 2022 02:19:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru DD854BAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311158;
        bh=YRKTrhfAFP9qeziqg57dBteSdl4msOdLpHBdPwd2Gp0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KafZuxIp0pMB7cJ7a5nV97u5gG3rN1l+oxCIl530r3XnUswdKKDyXqBFYH0FyHt0P
         5FFOS+7mvNsBxkR72Rl2Cg+FZZOXroXLGMJC2XAKZUQ/W/BGmTf0CnVI2SDUnQ/qQ/
         MnCtzp2TjRgDsfeT1tW5bRKGt/JgNaCIu+hoWla0=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 15/23] ata: libahci: Don't read AHCI version twice in the save-config method
Date:   Thu, 12 May 2022 02:18:02 +0300
Message-ID: <20220511231810.4928-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
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

