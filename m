Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDED5C7EE32
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 17:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjEVReh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 May 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEVRef (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2023 13:34:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423F107;
        Mon, 22 May 2023 10:34:33 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35C3A6606E6C;
        Mon, 22 May 2023 18:34:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684776871;
        bh=BoZKga0PfOsPfbrInX0w9l4g5csiejtz4nprxL0MYaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6Yb8tmQvVAxBYgC8BmNK9J+p20HUxcvpJSEIQNHO8zknX6vcLYLdqzZfSh/v1khR
         QVFH4L1q0usZrBVoVswIL2opZJ8nXACy7CbVhdAOM6l1NQNDHou8u6Xcx/ygQOzDmg
         EpeoOsx4d8nlnhNqcogBhGVG91Yu/hhXwFcGx7Rk9QXv1GKFQKe+i+KfqRvdRJFsj+
         zSo8HlWYhYNiUtLqCc9NuE7cEWFqLCGCOTA5Anpy/G0FDSWzVu2NkJBTPsi0FG4vBo
         3ZKSIBgzdFqCMA1OemN20yn+PJaSf1LFI9hRQf5kBxkXFDaxi1g/I4/u4In7C/VDTB
         4Szw/jMpV0Zig==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8F6C34807E3; Mon, 22 May 2023 19:34:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 4/6] dt-bindings: phy: rockchip: rk3588 has two reset lines
Date:   Mon, 22 May 2023 19:34:21 +0200
Message-Id: <20230522173423.64691-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522173423.64691-1-sebastian.reichel@collabora.com>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The RK3588 has two reset lines for the combphy. One for the
APB interface and one for the actual PHY.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml         | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 9ae514fa7533..82550a5c2ed5 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -31,8 +31,14 @@ properties:
       - const: pipe
 
   resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
     items:
-      - description: exclusive PHY reset line
+      - const: phy
+      - const: apb
 
   rockchip,enable-ssc:
     type: boolean
-- 
2.39.2

