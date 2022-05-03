Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E58C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  3 May 2022 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiECUTd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 May 2022 16:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242148AbiECUTG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2022 16:19:06 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7537D28983
        for <linux-ide@vger.kernel.org>; Tue,  3 May 2022 13:15:32 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9C11916D8;
        Tue,  3 May 2022 23:10:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 9C11916D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651608636;
        bh=ckfaK5irrS7Tron+bv7kr4WMcSYdpEv5KvtAmATvlro=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JeIJ3wPl0LTc+Mpjheb7xrYFDpIYHu/+PAz/x0B2Qtz9ondIoalrtgDU68ZA+sfsT
         ORTbk4iRoPzzrAha2sZC+/DrL2VPijmlMJ4oO2S1gAl95VBeBiqsqAkhR2hbyomr1X
         vUt8T38eEOJ/1TLG7XITDGWypD+Jvci4e/7dhcVA=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 May 2022 23:10:02 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 04/23] dt-bindings: ata: sata: Extend number of SATA ports
Date:   Tue, 3 May 2022 23:09:19 +0300
Message-ID: <20220503200938.18027-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The denoted in the description upper limit only concerns the Port
Multipliers, but not the actual SATA ports. It's an external device
attached to a SATA port in order to access more than one SATA-drive. So
when it's attached to a SATA port it just extends the port capability
while the number of actual SATA ports stays the same. For instance on AHCI
controllers the number of actual ports is determined by the CAP.NP field
and the PI (Ports Implemented) register. AFAICS in general the maximum
number of SATA ports depends on the particular controller implementation.
Generic AHCI controller can't have more than 32 ports (since CAP.NP is of
5 bits wide and PI register is 32-bits size), while DWC AHCI SATA
controller can't be configured with more than 8 ports activated. So let's
discard the SATA ports reg-property restrictions and just make sure that
it consists of a single reg-item.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Add comma and replace "channel" with "SATA port" in the reg property
  description (@Damien).
---
 Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
index 7ac77b1c5850..9c9c621761ca 100644
--- a/Documentation/devicetree/bindings/ata/sata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -41,11 +41,10 @@ patternProperties:
     properties:
       reg:
         minimum: 0
-        maximum: 14
         description:
-          The ID number of the drive port SATA can potentially use a port
-          multiplier making it possible to connect up to 15 disks to a single
-          SATA port.
+          The ID number of the SATA port. Aside with being directly used,
+          each port can have a Port Multiplier attached thus allowing to
+          access more than one drive by means of a single SATA port.
 
 additionalProperties: true
 
-- 
2.35.1

