Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1DC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 13 Jul 2022 05:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiGMFag (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Jul 2022 01:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiGMFaG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2022 01:30:06 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77B5F4F1A1;
        Tue, 12 Jul 2022 22:29:31 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 92991BD0;
        Wed, 13 Jul 2022 08:31:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 92991BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690279;
        bh=rfP9tv07m8KPasmOo6D0Sv4vVtteEhbDo7iguTqD2lc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=llyiUpTjCj/iufvwvi3aZREeeO7g8G9CutCjk+FWlNy2nT2WbmYCRH9Ob0zxakPgc
         Nj2GiFCGFBvX897bpty6qtP2wyQF6zIV3cKzflW12GLp6zP7SnWWP7zqFMBzw5rk/z
         +sjjgTg7IpEpsywUya1EOChfM+Q3Wo/EvqE2pY1Q=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:23 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 04/23] dt-bindings: ata: sata: Extend number of SATA ports
Date:   Wed, 13 Jul 2022 08:28:57 +0300
Message-ID: <20220713052917.27036-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- Add comma and replace "channel" with "SATA port" in the reg property
  description (@Damien).
---
 Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
index 5a31a902618d..58c9342b9925 100644
--- a/Documentation/devicetree/bindings/ata/sata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -49,10 +49,9 @@ $defs:
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
 
 ...
-- 
2.35.1

