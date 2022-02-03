Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313FC433FE
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 13:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350931AbiBCN6N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Feb 2022 08:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350929AbiBCN6N (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2022 08:58:13 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79BAC06173D
        for <linux-ide@vger.kernel.org>; Thu,  3 Feb 2022 05:58:12 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:15aa:ab80:d2f:edb])
        by michel.telenet-ops.be with bizsmtp
        id qdy92600a4dXKBW06dy9BZ; Thu, 03 Feb 2022 14:58:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nFccj-00D0MJ-9o; Thu, 03 Feb 2022 14:58:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nFcci-002m4B-NP; Thu, 03 Feb 2022 14:58:08 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH resend] dt-bindings: ata: renesas,rcar-sata: Add r8a774e1 support
Date:   Thu,  3 Feb 2022 14:58:08 +0100
Message-Id: <507cc45f44603afa6a70c05a3956fb7b13b49ed9.1643896347.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document SATA support for the RZ/G2H SoC, no driver change required.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
index c060c7914cae6573..c4e4a9eab658056d 100644
--- a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
+++ b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - renesas,sata-r8a774b1     # RZ/G2N
+              - renesas,sata-r8a774e1     # RZ/G2H
               - renesas,sata-r8a7795      # R-Car H3
               - renesas,sata-r8a77965     # R-Car M3-N
           - const: renesas,rcar-gen3-sata # generic R-Car Gen3 or RZ/G2
-- 
2.25.1

