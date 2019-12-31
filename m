Return-Path: <SRS0=b2kW=2V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DDAC2D0DE
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C99206E6
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8Agfw/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfLaRZJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:25:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42219 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfLaRZI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Dec 2019 12:25:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so22511409ljj.9
        for <linux-ide@vger.kernel.org>; Tue, 31 Dec 2019 09:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fhHaMdsl7JAy+548H7ISCjeA4TVpvL94fbTYt3aY5T4=;
        b=a8Agfw/bmt/RK9nlv1f2EZRwM6/cbfI0eDNPwWykfBNLLESFyHXKTrWBAcL30mMkSe
         WupmEqAdhg/mA+REdV+Ea1X+2T0RDxQoOyqOlc0y+JM1tjtU1qFJqce7Lds2VN+4cnhW
         SZlDqMRDKCYh75dt45cap31A8/8sVqxU5VXIoxjZDMqSDaSi9oIDo42AdUKwmempYU32
         DZdd0hcyURjPL1To+aOnkFe8Zm+DWEghy7Rs15jJ+0NOCblFdvRGQjnwnjDfFFGbJuTs
         WAIfHGIW7+WX/16iTsY+p0u/Lb+5PmzZ844XgS7gyqNVU92TDdL8UEPGAsfL208we5tq
         N4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fhHaMdsl7JAy+548H7ISCjeA4TVpvL94fbTYt3aY5T4=;
        b=P/UqSvJtARiJD3xOmmM4U8l6XWBuneNsVzk5Ny9pK6yTfj0KAfnY+RG4suxDUt0QDA
         g2fVo4xfOVoTMSiRXBo7YFqJY+XDPEbGI+U8sMfyvudCIRlAjDDK+zqKfwMhYp3rmbUb
         ZCt+K57+L5nufpJMgFD8ip37sbZ7b8NgAPk0F1mcQh9gxo3nJYlsEAHDX8HLTFR/h47m
         i/tNn9/IUIQRV2WouDIdSpafAcZf+X3GbEnS6jVOkrkN0II2hgMNx/vKPUuoh1qbdq6E
         Jjh7FeQ3essSwGhm/YZMscEpbh0jt6DvdaVxNNR5iHMNyna7hRYX8Fs0mtM6nYPPjkpc
         2h9g==
X-Gm-Message-State: APjAAAUFEtQ6v1H51XXclr+O2X9d0DmPwl9VVmpjci/bHGCnhOHHHVEC
        sas47u8RpR6uR/nzfMTT3ydwrA==
X-Google-Smtp-Source: APXvYqyNpB7yMhQIz8oykFMFhw+p+ksiyFW/WfgEwgZ1ze8tq0wowFVAUFMg1vflalcrsHVdK7thUQ==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr41616001ljg.149.1577813107026;
        Tue, 31 Dec 2019 09:25:07 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id z11sm16991572ljc.97.2019.12.31.09.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 09:25:06 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] dt-bindings: Create DT bindings for [PS]ATA controllers
Date:   Tue, 31 Dec 2019 18:24:57 +0100
Message-Id: <20191231172458.25984-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I need to create subnodes for drives connected to PATA
or SATA host controllers, and this needs to be supported
generally, so create a common YAML binding for
"pata-controller" or "sata-controller" that will support
subnodes with drives.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/ata/pata-sata-common.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-sata-common.yaml

diff --git a/Documentation/devicetree/bindings/ata/pata-sata-common.yaml b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
new file mode 100644
index 000000000000..d94aa20a29e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/pata-sata-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Parallel and Serial AT attachment controllers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  This document defines device tree properties common to most Parallel
+  (PATA) and Serial (SATA) AT attachment storage devices. It doesn't
+  constitue a device tree binding specification by itself but is meant to
+  be referenced by device tree bindings.
+
+  The PATA/SATA controller device tree bindings are responsible for
+  defining whether each property is required or optional.
+
+properties:
+  $nodename:
+    pattern: "^[ps]ata-controller(@.*)?$"
+    description:
+      Specifies the host controller node.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^drive@[0-1]$":
+    description: |
+      DT nodes for drives connected on the PATA or SATA host. The master drive
+      will have ID number 0 and the slave drive will have ID number 1.
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+        description:
+          The ID number of the drive, 0 for the master and 1 for the slave.
+
+...
-- 
2.21.0

