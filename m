Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F8CCCA482
	for <linux-ide@archiver.kernel.org>; Wed, 13 Jul 2022 05:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiGMFah (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Jul 2022 01:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiGMFaI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2022 01:30:08 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D6E14E606;
        Tue, 12 Jul 2022 22:29:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A88FED5F;
        Wed, 13 Jul 2022 08:31:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A88FED5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690280;
        bh=mZo4KYtzSohy8PRm7hEssRzi7p5ZuYvFI8ByV0YrDcQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=cLh1uioBXiQscNmNi/GDapW+1DDTaCIdXLmiIB7AkFMAbpl7ghx/pThcmksDWLAYC
         gBNKa/nhQDfNJfmUplOqiNJt5xboGhgrS0TWjBDEalaKkGk3o1WHT1d6ziXvcy2S3T
         oR2yna1jNHDCXjOHAkBbNe800Czbk+DXHz7+/8HM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:24 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 05/23] dt-bindings: ata: sata-brcm: Apply common AHCI schema
Date:   Wed, 13 Jul 2022 08:28:58 +0300
Message-ID: <20220713052917.27036-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The Broadcom SATA controller is obviously based on the AHCI standard. The
device driver uses the kernel AHCI library to work with it. Therefore we
can be have a more thorough DT-bindings evaluation by referring to the
AHCI-common schema instead of using the more relaxed SATA-common one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v4:
- This is a new patch added on v4 lap of the review procedure.
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
index 4ee74df8e58a..fa8ebc8f243f 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -14,7 +14,7 @@ maintainers:
   - Florian Fainelli <f.fainelli@gmail.com>
 
 allOf:
-  - $ref: sata-common.yaml#
+  - $ref: ahci-common.yaml#
 
 properties:
   compatible:
-- 
2.35.1

