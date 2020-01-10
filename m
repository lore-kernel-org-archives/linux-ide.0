Return-Path: <SRS0=xOnl=27=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B9C33CA4
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jan 2020 08:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5E2072A
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jan 2020 08:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMcisQ9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgAJIOy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:14:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37045 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgAJIOy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jan 2020 03:14:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so783915lfc.4
        for <linux-ide@vger.kernel.org>; Fri, 10 Jan 2020 00:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vu5pZrGVWV+F+Z9ZVUAzowNazkPEg3KOIUjTjFIkErE=;
        b=GMcisQ9amaS34fIthUecflepm50B1uWjJDtbxOPvqoZ/36/4IU2GPRgjwWAq7EJxj2
         lhXZhRG4v6pZUm00cL77GDbqV4QHMOihNRv1r7fKyUHW9r1llBy2PpSNR+x5W9k3Mxbk
         z0vS+/dYWyl9do8g3CRKc4Ma7tV0BLMyPgHdyieBRu34os1r7G+GRypk96I1XRDceBZG
         3XzCaCbpf+OlrrJNwwtHqbmUHQqCqNBbTjnbVlUZKpAkuskaUtQs3m/p51azuoJYeyPa
         Eo9cJmHVssRCV1BjKz400ZLAamxgGxffwZ1PO7kQ6Yq5s07tUBgy9dgophpOZGICRKGl
         glzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vu5pZrGVWV+F+Z9ZVUAzowNazkPEg3KOIUjTjFIkErE=;
        b=T/HGUutCmRz0ElD+lfIJF7sU9iBbU+AHUKlKajSQw/VIeVUfeypLfimddnArnsgMpQ
         DccqSVMtGPYR+CQUzJhwCfQKGTDvyIU/P5M4h799Oybp+EUkuyInavwv5tD6Jl0jZCqP
         gQ+BVuUFh4DIvnptWgjZBeOZUzGU5DptLaRHMU8nbLe/WOzq6ctEPHoMEzHRjoS3sh41
         0KeKAkGeYxOGmuz0AA92wM2V4f0o6H/DDabMvicixYKfn4SxmjxYJjcxTw1FhR/OuN1Z
         vYVbixfAcisWI/wlr9QzjNyC3nE6ecflwNE/Y4oYBVjNphj1LokfLD5IKliRCm6kqBRJ
         dMhA==
X-Gm-Message-State: APjAAAXIepj5nTMQ6/pR3yfZKgtwKKtDNTaQv8v0S0d0xp5m0g675VDs
        r/afpHjx8Rj+E8pwRzrxrnol/Q==
X-Google-Smtp-Source: APXvYqzDinwDz72/xXRbkcBAs4ET4X1I2qV5Pwg0o+UfqzZswBcw8YQThvrupnrF3gM+YJRvDt+3IQ==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr1446391lfa.100.1578644092720;
        Fri, 10 Jan 2020 00:14:52 -0800 (PST)
Received: from linux.local (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id r15sm592496ljh.11.2020.01.10.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 00:14:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v3] dt-bindings: Create DT bindings for PATA controllers
Date:   Fri, 10 Jan 2020 09:14:10 +0100
Message-Id: <20200110081411.9806-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I need to create subnodes for drives connected to PATA
host controllers, and this needs to be supported generally,
so create a common YAML binding for "ide" that will support
subnodes with ports.

This has been designed as a subset of
ata/ahci-platform.txt with the bare essentials and
should be possible to extend or superset to cover the
common bindings.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Only support PATA controllers for now since it is all I
  need right now. SATA controller have complex topology and
  might need more elaborate subnodes, possibly a subnode for
  the multiplier itself, so I will split that off into its
  own RFC patch.
ChangeLog v1->v2:
- Use ide@ and sata@ as node names.
- Use ide-port@ and sata-port@ for the ports toward the
  drives, rather than letting the subnodes be the drives
  themselves.
---
 .../devicetree/bindings/ata/pata-common.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-common.yaml

diff --git a/Documentation/devicetree/bindings/ata/pata-common.yaml b/Documentation/devicetree/bindings/ata/pata-common.yaml
new file mode 100644
index 000000000000..fc5ebbe7108d
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/pata-common.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/pata-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Parallel AT attachment (PATA) controllers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  This document defines device tree properties common to most Parallel
+  ATA (PATA, also known as IDE) AT attachment storage devices.
+  It doesn't constitue a device tree binding specification by itself but is
+  meant to be referenced by device tree bindings.
+
+  The PATA (IDE) controller-specific device tree bindings are responsible for
+  defining whether each property is required or optional.
+
+properties:
+  $nodename:
+    pattern: "^ide(@.*)?$"
+    description:
+      Specifies the host controller node. PATA host controller nodes are named
+      "ide".
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^ide-port@[0-1]$":
+    description: |
+      DT nodes for ports connected on the PATA host. The master drive will have
+      ID number 0 and the slave drive will have ID number 1. The PATA port
+      nodes will be named "ide-port".
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

