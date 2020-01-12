Return-Path: <SRS0=hzpW=3B=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA4C33CA9
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jan 2020 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E858324655
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jan 2020 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyPsmZuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbgALLR6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jan 2020 06:17:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40507 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbgALLR6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jan 2020 06:17:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id u1so6857002ljk.7
        for <linux-ide@vger.kernel.org>; Sun, 12 Jan 2020 03:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zo6fx5Wpa4UMlaqNMt4nQ/pXNoj/+8/OnmUYzSrIJJE=;
        b=DyPsmZukkzw850ogUhzgDd3fFknJ/kGmrY3kVMyx0lkBEXBJrfPzYFv3YRfTvmp8kl
         Bd669W98WgYBXQUZ9lpDKpzpBBtn8jUJySSE+SWf2P5xJTgKjV6ZyDsGzae0sLlZoRMl
         MU2EhHSIzspbscM9QYgYgeIkhPM8I+eFl3N81hz1uyzDPEiAMngVEEHSzr1Yci+xg+XD
         nm0h+GMlgU19HBieQ76BJ3D51r+faDsQYH7fNEOMrzznPrYi+F70AN3nFybpw6yS0CGE
         H7jouGtjkyKkfB98gFMMwrPthJ9K6B264dxg3w0oGjORZ8L6OtUM7mYiBaBL/VYKBiLK
         PRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zo6fx5Wpa4UMlaqNMt4nQ/pXNoj/+8/OnmUYzSrIJJE=;
        b=b6D4qIRBXhtKQEzmP4GpPF4BaHfEvAbL48f2U8IgSSpyI/jk6oZiiENeZ/obUmUCAN
         EKmXg7IgTVkTHKdAl3phNtT0ipL4VkN4RukwuL4kxc82bKOZXTGQuejUmVHBMoLmEGJF
         Z8XAyeKQ2BKLrg0AxiuArP8/onZvwV3bgdgUKID4mJOMX6yU24ZR9L1uNlhsNS+3YQqo
         wi96glfIzjIu7WP7sE1GenkCg4GxYAq+0udUrP3HtCNh6VrDYvZdYKASHOdMuwIHQKz7
         Os5c93iMlksEXHAIWFeJmdSN/MfoouiDev90gAcr1AGaQZGquKpi/LLjdjY3PsQYKUiw
         kShQ==
X-Gm-Message-State: APjAAAU+W2cgnzGRcPM79CnJgBb1Z2i6kp5vDAPp3ia0v4bNcadMvIrT
        wmYyMHKqmxqm4VEWmF4bFUKuFg==
X-Google-Smtp-Source: APXvYqzhz5rajwXrtmQnWaXrB6kf+ymA5yEzq0l3+mPMYaB/HfAmav4FzTq3fEayQq83TQ/qOJeDgQ==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr7796249ljg.250.1578827876139;
        Sun, 12 Jan 2020 03:17:56 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id z13sm4040385lfi.69.2020.01.12.03.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 03:17:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v4] dt-bindings: Create DT bindings for SATA controllers
Date:   Sun, 12 Jan 2020 12:17:51 +0100
Message-Id: <20200112111751.21984-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I need to create subnodes for drives connected to SATA
host controllers, and this needs to be supported
generally, so create a common YAML binding for
"sata" that will support subnodes with ports.

This has been designed as a subset of
ata/ahci-platform.txt with the bare essentials and
should be possible to extend or superset to cover the
common bindings.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Drop any master/slave terminology: SATA has one drive
  per port or up to 15 drives behind a multiplexer.
- Drop RFC notation, this feels pretty finished.
ChangeLog v2->v3:
- Split off into its own RFC patch
- Only support sata-port@ in this binding
- Opt to support devices 0..14 on the sata-port in
  line with ahci-platforn.txt not modeling the port
  multiplier in the device tree at all.
ChangeLog v1->v2:
- Use ide@ and sata@ as node names.
- Use ide-port@ and sata-port@ for the ports toward the
  drives, rather than letting the subnodes be the drives
  themselves.
---
 .../devicetree/bindings/ata/sata-common.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/sata-common.yaml

diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
new file mode 100644
index 000000000000..41f590629fbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/sata-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Serial AT attachment (SATA) controllers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  This document defines device tree properties common to most Serial
+  AT attachment (SATA) storage devices. It doesn't constitute a device tree
+  binding specification by itself but is meant to be referenced by device
+  tree bindings.
+
+  The SATA controller-specific device tree bindings are responsible for
+  defining whether each property is required or optional.
+
+properties:
+  $nodename:
+    pattern: "^sata(@.*)?$"
+    description:
+      Specifies the host controller node. SATA host controller nodes are named
+      "sata"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^sata-port@[0-1]$":
+    description: |
+      DT nodes for ports connected on the SATA host. The SATA port
+      nodes will be named "sata-port".
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 14
+        description:
+          The ID number of the drive port SATA can potentially use a port
+          multiplier making it possible to connect up to 15 disks to a single
+          SATA port.
+
+...
-- 
2.21.0

