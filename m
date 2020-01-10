Return-Path: <SRS0=xOnl=27=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7CBC33CA2
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jan 2020 08:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3CE2072E
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jan 2020 08:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7bksC9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgAJISZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:18:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43474 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgAJISZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jan 2020 03:18:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so775315lfq.10
        for <linux-ide@vger.kernel.org>; Fri, 10 Jan 2020 00:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CV2HYfwcjdvq9OchALW99WXIpSU7h5uftpPM+rOvokc=;
        b=d7bksC9DIxve1KRyf1cNcEBne0RM0Suj1cS2FIxPPkH0q4rcV3AW2anr+0TIXbB3VX
         ol9up7JIpc4iTLSZAJvTmZvKAFTMj2FQHjPeb3K5PrcaBds7F5X7XRfeUmOP+OSnPqF4
         A3bqVWfBVqRv5PvqQ5umNuBTZlZS3re2eUtgYv8P+pc0wp8W+Li3FnONTbpzbZ6NsYhM
         oaWOKq+/Jm7C7Q2AdWH2UKs7nWOBmxEAlrKyxhr/Do5QUy3T+3CrSe7PhgdOudqOwzt1
         WiPaSlgnnuxhW8ETMPaR4KhcJKbgns9oByGi40AgaKwA78WAvtVStYa0pgl05D4thiHi
         C9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CV2HYfwcjdvq9OchALW99WXIpSU7h5uftpPM+rOvokc=;
        b=rz42Wk7OWhrqf7pC6PqU+KMnKaZV/PrvvVx/+MREYit0EXsfsM9Uv0C7NFhSGT/LBb
         sM7dbGnukPR1RAS3h38mY9GXr8ef7hEU3YDJkydFf++OKS/c/yn5TF0rv8PNCeJ6lHZz
         j1Qf8mI6JVmRJJNFWthvWZEH7/lPaUArYfq9TWISVtM4Qf6uqup/4mR0jjzVs13Ea/s3
         TpynjtdnrhscyYMpg13bbJjmC1i9RaLbgZgx2HvuhuPs/+qbAoo+fxPdNnZ2A/KDFVyz
         U9FBK22xPVmUjzcg8gRVQFlsLDyXBpvWCf0NsbXOItGXPYguQf8vV2B8BbNMBFZvWD83
         uVPA==
X-Gm-Message-State: APjAAAVXRlp5LL6fMqViDLgxJJMQ6xu5h8l4WW5WMsSMGBKwtwpximu+
        uzh78xJYlMmwATxh4SxhDiWqiw==
X-Google-Smtp-Source: APXvYqxVfW4F73xDHXDApf1ti2CA/XxjeNivvnUUp4pXInLJgvwzouhqx81SoZBKMba2NdqAX6KlGw==
X-Received: by 2002:a19:4208:: with SMTP id p8mr1408253lfa.160.1578644303346;
        Fri, 10 Jan 2020 00:18:23 -0800 (PST)
Received: from linux.local (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id s4sm591308ljd.94.2020.01.10.00.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 00:18:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] RFC: dt-bindings: Create DT bindings for SATA controllers
Date:   Fri, 10 Jan 2020 09:17:43 +0100
Message-Id: <20200110081743.10086-1-linus.walleij@linaro.org>
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
 .../devicetree/bindings/ata/sata-common.yaml  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/sata-common.yaml

diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
new file mode 100644
index 000000000000..9f6718a69dfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -0,0 +1,51 @@
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
+  AT attachment (SATA) storage devices. It doesn't constitue a device tree
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
+      DT nodes for ports connected on the SATA host. The master drive will have
+      ID number 0 and the slave drive will have ID number 1. The SATA port
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

