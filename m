Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA3C432BE
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C1460FDA
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhG1JE5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhG1JE5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2021 05:04:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38126C061764
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:55 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r23so2237862lji.3
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CV70NmWuaFf/90QHNhrtM//ts+9JPH+aY+q63Jc+k1o=;
        b=uVn6BLJqAJcv0QI+qQW4OYZ6ugNWU589N5kwsXbH38wQvzJxXLO6/nxe0tcvyFwDpJ
         Q6hS7VIG4WcKDmMY3sU0gkF4clvgUWHKvnEJsbjjomTB1SxL1yk51J1Gv3owPbCxgNap
         CBtPxaUrcu5LKHfMb7H/v0zRH+DYWoInI4+PLyERzVcMJIOCFkrFaXLGUmT0qFlWgdXJ
         gY4Kl8FS8IhzeO1LAzE8YQF9xwKaF1zyQdAmTkTlNXLCQB0OFN7RgDpHHk8+DF2CkOPZ
         tVRMUJcNIjWD6Iiyojhc2Pn9LzxPKUIAfc7WHaMbkkXg1gmwSVr6UGsRshAmAV1QRh1q
         38Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CV70NmWuaFf/90QHNhrtM//ts+9JPH+aY+q63Jc+k1o=;
        b=K8vwGy0qXdu2PH8ItqZrQUYBR5zf6qLS8Jqu5VLVkN97LGP4mshhf3igt4XLimZ+Ey
         n/Ym0r5kRQYn0KToSVFV/Br5dc6ENdsnfIvsw8UeliestRFg3vOQ2XkCbtyVSARbULb2
         Irm9JIOkYR9aG2qV4Q46UwD7cF9GxabGkSz2JPRDO9t71b6NipU036Cz1j7VL66sqbCE
         UDTapiOE5WdcWaur0J9kfJpC5AY1Wxu+Q5MVZOcRlOmV6A4HmBljA/8myaXb0BZA5bws
         mpYzAAsiQ+rVolu2cHPtGjjz5GPcQSZhIVblobXARpn1RiFFGKo63sQeHcwCox/rYgAq
         fgbA==
X-Gm-Message-State: AOAM5315PbjAr5IuUndLSjMAO5RZOKoyFdVTa+xhoF4o/OFHVgvwhXmB
        19hR6wff5/m8dks8YdkL2Q2JFQ==
X-Google-Smtp-Source: ABdhPJw/LE+jcxwKvn8Liar5mn5PeIjcGs8MvNbzizziYZMK6H6CtrgKCofqXBxmavvszDjAu/FYbA==
X-Received: by 2002:a05:651c:d5:: with SMTP id 21mr10757064ljr.135.1627463093563;
        Wed, 28 Jul 2021 02:04:53 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d9sm505495ljq.54.2021.07.28.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:04:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 4/5] pata: ixp4xx: Add DT bindings
Date:   Wed, 28 Jul 2021 11:02:41 +0200
Message-Id: <20210728090242.2758812-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728090242.2758812-1-linus.walleij@linaro.org>
References: <20210728090242.2758812-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This adds device tree bindings for the Intel IXP4xx compact flash card
interface.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../ata/intel,ixp4xx-compact-flash.yaml       | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml

diff --git a/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
new file mode 100644
index 000000000000..b254be858de6
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/intel,ixp4xx-compact-flash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel IXP4xx CompactFlash Card Controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  The IXP4xx network processors have a CompactFlash interface that presents
+  a CompactFlash card to the system as a true IDE (parallell ATA) device. The
+  device is always connected to the expansion bus of the IXP4xx SoCs using one
+  or two chip select areas and address translating logic on the board. The
+  node must be placed inside a chip select node on the IXP4xx expansion bus.
+
+properties:
+  compatible:
+    const: intel,ixp4xx-compact-flash
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: pata-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus@c4000000 {
+      compatible = "intel,ixp43x-expansion-bus-controller", "syscon";
+      reg = <0xc4000000 0x1000>;
+      native-endian;
+      #address-cells = <2>;
+      #size-cells = <1>;
+      ranges = <0 0x0 0x50000000 0x01000000>, <1 0x0 0x51000000 0x01000000>;
+      dma-ranges = <0 0x0 0x50000000 0x01000000>, <1 0x0 0x51000000 0x01000000>;
+      ide@1,0 {
+        compatible = "intel,ixp4xx-compact-flash";
+        intel,ixp4xx-eb-t1 = <3>;
+        intel,ixp4xx-eb-t2 = <3>;
+        reg = <1 0x00000000 0x1000>, <1 0x00040000 0x1000>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <12 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
+
+...
-- 
2.31.1

