Return-Path: <SRS0=3OFZ=YQ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF33CA9EB9
	for <linux-ide@archiver.kernel.org>; Wed, 23 Oct 2019 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F2A21A4C
	for <linux-ide@archiver.kernel.org>; Wed, 23 Oct 2019 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390797AbfJWJPP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:15:15 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:38508 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390666AbfJWJPP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Oct 2019 05:15:15 -0400
X-IronPort-AV: E=Sophos;i="5.68,220,1569250800"; 
   d="scan'208";a="29796384"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Oct 2019 18:15:14 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0DE1A41D0CAF;
        Wed, 23 Oct 2019 18:15:10 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v2] dt-bindings: ata: sata_rcar: Add r8a774b1 support
Date:   Wed, 23 Oct 2019 10:15:06 +0100
Message-Id: <1571822106-16258-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Document SATA support for the RZ/G2N, no driver change required.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2:
* Prepended "dt-bindings: " to commit title as per Geert's comment

 Documentation/devicetree/bindings/ata/sata_rcar.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 4268e17..a2fbdc9 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible		: should contain one or more of the following:
+			  - "renesas,sata-r8a774b1" for RZ/G2N
 			  - "renesas,sata-r8a7779" for R-Car H1
 			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
 			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
@@ -9,8 +10,10 @@ Required properties:
 			  - "renesas,sata-r8a7793" for R-Car M2-N
 			  - "renesas,sata-r8a7795" for R-Car H3
 			  - "renesas,sata-r8a77965" for R-Car M3-N
-			  - "renesas,rcar-gen2-sata" for a generic R-Car Gen2 compatible device
-			  - "renesas,rcar-gen3-sata" for a generic R-Car Gen3 compatible device
+			  - "renesas,rcar-gen2-sata" for a generic R-Car Gen2
+			     compatible device
+			  - "renesas,rcar-gen3-sata" for a generic R-Car Gen3 or
+			     RZ/G2 compatible device
 			  - "renesas,rcar-sata" is deprecated
 
 			  When compatible with the generic version nodes
-- 
2.7.4

