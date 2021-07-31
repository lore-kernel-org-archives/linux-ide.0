Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46778C4338F
	for <linux-ide@archiver.kernel.org>; Sat, 31 Jul 2021 21:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4C260F39
	for <linux-ide@archiver.kernel.org>; Sat, 31 Jul 2021 21:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhGaVik (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 31 Jul 2021 17:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGaVij (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jul 2021 17:38:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8514C06175F
        for <linux-ide@vger.kernel.org>; Sat, 31 Jul 2021 14:38:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p38so10850401lfa.0
        for <linux-ide@vger.kernel.org>; Sat, 31 Jul 2021 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVpV8/vvaY59r2A1osNnhfzz9lEm81RglXyawlMfFVs=;
        b=uwP00Qp0fTpTjjVrQ+JdVjl/XLYQC60YKVVorf0eEHF4HQbh4U08lHxJp/5EthwAn7
         +2A3xL4PrhZHmczDE8NsbuZc9IZMA4+dT2qgYEndo9b3hoyv1vo7SVlhD5SiqxzXTVqt
         ur59AEo7oCCHcnJhW6wVsmYC7RIyFEiBNYYtQhU9975oJ+q1dz4A+5T9NWX9WFZxc7hb
         HOKH+cmb6BkxKwYiJYWYO7Dv82iMRTn1VRkH8hOc9WBpjXYz2wJP9WLD5+jp0MBI2t85
         b77ohLQ9CBpiUuEFuuFuBuZY62cxU7JTA3CFBLiJp8fnwsnXE5pXLDUF3MDztHS31sqS
         AdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVpV8/vvaY59r2A1osNnhfzz9lEm81RglXyawlMfFVs=;
        b=rCE3Y3U9PaRCpjYzUTxD/oMPrUKMDPCPcFRpgMRU3O2rBCITltLzRBNJ3pMxAIZ3VU
         ZUAuUJc62A2zBEj/f/M/hfLfGtoZZKchiE3uzPIzI8V9hk65V65MTUO0KQe/PKjAKzWl
         fR5mre/RCmSOiTXOgoEhzwn9JwZf5IJ3156lVF1VGexkudVICCZWk7OSWFlzvYzkckfz
         P22IjVrkMZCeh1unZzo2a/inZNfwn6LAS+eRJw76InIDchq2QpRfgydMToR1VGeLcrBL
         0K0iSuynQzbwZpHNFzp1j++4ehvCnDSUZSIcWrm6K8V2zDzNshveHmHQLGsl96fkkEmc
         eoLQ==
X-Gm-Message-State: AOAM533ceE3WXS03ajhbMb6cqIGg3UORJseEOr2o9GZlmlNg+tR/NMev
        rcjAn8zVoqShez1sbYSOWBLCwQ==
X-Google-Smtp-Source: ABdhPJzLixD4oy8KuFmTMFF3ePfGpisk3L0YN6JPpCHxYJFkrunG0zDFmX8iZ2Nm3FRrmpW4V1PKZA==
X-Received: by 2002:a05:6512:3691:: with SMTP id d17mr2718377lfs.222.1627767511146;
        Sat, 31 Jul 2021 14:38:31 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t17sm440430ljk.102.2021.07.31.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:38:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 4/5 v2] pata: ixp4xx: Add DT bindings
Date:   Sat, 31 Jul 2021 23:35:54 +0200
Message-Id: <20210731213555.2965356-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731213555.2965356-1-linus.walleij@linaro.org>
References: <20210731213555.2965356-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Itemize the registers
- Drop the epansion bus set-up to alleviate warnings
---
 .../ata/intel,ixp4xx-compact-flash.yaml       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml

diff --git a/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
new file mode 100644
index 000000000000..52e18600ecff
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
@@ -0,0 +1,61 @@
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
+  a CompactFlash card to the system as a true IDE (parallel ATA) device. The
+  device is always connected to the expansion bus of the IXP4xx SoCs using one
+  or two chip select areas and address translating logic on the board. The
+  node must be placed inside a chip select node on the IXP4xx expansion bus.
+
+properties:
+  compatible:
+    const: intel,ixp4xx-compact-flash
+
+  reg:
+    items:
+      - description: Command interface registers
+      - description: Control interface registers
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
+        reg = <1 0x00000000 0x1000>, <1 0x00040000 0x1000>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <12 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
+
+...
-- 
2.31.1

