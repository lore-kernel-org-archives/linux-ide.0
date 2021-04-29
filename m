Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A28C433ED
	for <linux-ide@archiver.kernel.org>; Thu, 29 Apr 2021 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF69C61400
	for <linux-ide@archiver.kernel.org>; Thu, 29 Apr 2021 12:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhD2Mpx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhD2Mpw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Apr 2021 08:45:52 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38582C06138D
        for <linux-ide@vger.kernel.org>; Thu, 29 Apr 2021 05:45:06 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d4dd:70b4:3264:8d97])
        by michel.telenet-ops.be with bizsmtp
        id ycl52400Z4p6Y3806cl5la; Thu, 29 Apr 2021 14:45:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lc62T-001F8t-CX; Thu, 29 Apr 2021 14:45:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lc62S-009VoE-O1; Thu, 29 Apr 2021 14:45:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: ata: renesas,rcar-sata: Make power-domains and resets required
Date:   Thu, 29 Apr 2021 14:45:03 +0200
Message-Id: <ca35d7d837b155c69232a1c25060737b4c87720f.1619700260.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The "power-domains" property is present on all supported platforms.
The "resets" property is present on all but R-Car H1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/ata/renesas,rcar-sata.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
index 2ad2444f10423eae..c4e4a9eab658056d 100644
--- a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
+++ b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
@@ -54,6 +54,17 @@ required:
   - reg
   - interrupts
   - clocks
+  - power-domains
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          const: renesas,sata-r8a7779
+then:
+  required:
+    - resets
 
 additionalProperties: false
 
-- 
2.25.1

