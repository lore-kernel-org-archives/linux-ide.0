Return-Path: <SRS0=GUab=23=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35486C00523
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 01:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F259821582
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 01:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwvq7bAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgAFBmg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:42:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36033 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgAFBmg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Jan 2020 20:42:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so49327385ljg.3
        for <linux-ide@vger.kernel.org>; Sun, 05 Jan 2020 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQ3JEO6lOKUjdmfiSjcQjm1t9+Ta5EqkWmsBbH0kXA4=;
        b=xwvq7bAFmotmoaAFK6MS5prohkqPMlwFqY+kNzuC4MOyJvRg7rVi4827QqnPGb5g+O
         ZTREDa0PxnUNQFOqkijJJOykBet+OCgur0zP1BAxJFpbK9CvnKzCkFRD/Dw5VIm4j5zn
         OYC/1882en7yIBwKpq8WFqqZc9NGxcLBu8V2ZRKe+r2GtniqrD1Il9rUWajTiR3X8fz1
         VsMJcJY9qqux025OtH3mjpwtqggDSttYcFVsnC9jxXjotDm2Jjv/asHjtfYmVdBnZz+f
         JLMTYVrYGqS3c1QTT1iPQYYkIzf2HJp/YYPcP3unPR/F2LBeK/d8CtBdvOON4DxDbJyS
         cbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQ3JEO6lOKUjdmfiSjcQjm1t9+Ta5EqkWmsBbH0kXA4=;
        b=OpPPfL7qOKOe+clG0b8Ugu+wIpKmtQGNUVRcxZ/8rjxX6FPbqyFof83xjiItAIcIkT
         jsH0XziC67hdQMpcUWj0STAPemvclK92YZ0zGm3ThhrVccx3X1jS2pDto7NmV6qP8gHX
         RrXDbYSDBPdR/Vkh0PVnWUfCne75ouUdvXlNw12nPWCdb5jWu1Elwioq295yPBxdWE1e
         UV+JiPfSG4pxAo5cPTu/qfGlNo4M3HI6XcB0nUoi45Gxi17RHdmWS94RhxcUEVyhlHhm
         EPkr7rCn7j/ULNslLBE+1ZlbCeBeJ1CK21/o64GWqckwkmhkicMRLcVLruGU1xbPMzSQ
         dFvw==
X-Gm-Message-State: APjAAAWhpLjjHn9UEPCH4pkdgeVFLhT7Lo7RXvESSgsfoqo6gofkHAI9
        GLZMBumtLo6ugx1zAOURi9Ou5A==
X-Google-Smtp-Source: APXvYqwVhtZz96ShQoacxUg5G8ePAL/0yBaV3204f3OzctQcduDswchapdvs6SIeLx52lcL4mHhK6w==
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr60144104lja.81.1578274954325;
        Sun, 05 Jan 2020 17:42:34 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id y8sm28377300lji.56.2020.01.05.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:42:33 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v2] dt-bindings: Create DT bindings for [PS]ATA controllers
Date:   Mon,  6 Jan 2020 02:42:23 +0100
Message-Id: <20200106014224.12791-1-linus.walleij@linaro.org>
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
"ide" or "sata" that will support subnodes with ports.

This has been designed as a subset of
ata/pata-sata-common.yaml with the bare essentials and
should be possible to extend or superset to cover the
common bindings.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use ide@ and sata@ as node names.
- Use ide-port@ and sata-port@ for the ports toward the
  drives, rather than letting the subnodes be the drives
  themselves.
---
 .../bindings/ata/pata-sata-common.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-sata-common.yaml

diff --git a/Documentation/devicetree/bindings/ata/pata-sata-common.yaml b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
new file mode 100644
index 000000000000..f46f04446607
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
@@ -0,0 +1,51 @@
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
+  (PATA, also known as IDE) and Serial (SATA) AT attachment storage devices.
+  It doesn't constitue a device tree binding specification by itself but is
+  meant to be referenced by device tree bindings.
+
+  The PATA/SATA controller device tree bindings are responsible for
+  defining whether each property is required or optional.
+
+properties:
+  $nodename:
+    pattern: "^(ide|sata)(@.*)?$"
+    description:
+      Specifies the host controller node. PATA host controller nodes are named
+      "ide" and SATA controller nodes are named "sata"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^(ide|sata)-port@[0-1]$":
+    description: |
+      DT nodes for ports connected on the PATA or SATA host. The master drive
+      will have ID number 0 and the slave drive will have ID number 1.
+      The PATA port nodes will be named "ide-port" and the SATA port nodes will
+      be named "sata-port".
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+        description:
+          The ID number of the drive port, 0 for the master port and 1 for the
+          slave port.
+
+...
-- 
2.21.0

