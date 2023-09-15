Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F56FCD37A9
	for <linux-ide@archiver.kernel.org>; Fri, 15 Sep 2023 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjIOUTZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbjIOUTB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2023 16:19:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A73C29;
        Fri, 15 Sep 2023 13:16:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC22C433C7;
        Fri, 15 Sep 2023 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694808992;
        bh=nGXQTgrcs3KREIWY3zBQSQp1+XIT8pojI0mg2noKVnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lU1+XHUXZMAUFUqsXQSsCWZn+Uos3RB5wXCnDq9MbGB1AQW8Yjz153kXHq9JDHDux
         oyJ36pykFKv4/NmdromUyG1gfDJgVMkp21Rr+qTjY7C68fpabAt54ULJVlDpq7X8Ti
         U8mXKhd6tfQyIcE1ZDlr1KmYQkrANrN4qcIYLCvXD9oWadQdIu7srChOLtjs17efBx
         Fz2T4AroD88ycXuZ2ZELyInvT9zp5SV6oefZWwiATWrDnzCH2AT5OT/y+KvNlU9aJ4
         btd2tkIB1hl6o+YLESH/MQ0zCndF1ulhWXnYwWjGjbSnRM2gPuZDmGw44wlqIqBzWO
         5V/83jeoyrXdg==
Received: (nullmailer pid 4180862 invoked by uid 1000);
        Fri, 15 Sep 2023 20:16:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: pata-common: Add missing additionalProperties on child nodes
Date:   Fri, 15 Sep 2023 15:16:20 -0500
Message-Id: <20230915201626.4180606-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The PATA child node schema is missing constraints to prevent unknown
properties. As none of the users of this common binding extend the child
nodes with additional properties, adding "additionalProperties: false"
here is sufficient.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/pata-common.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/pata-common.yaml b/Documentation/devicetree/bindings/ata/pata-common.yaml
index 337ddf1113c4..4e867dd4d402 100644
--- a/Documentation/devicetree/bindings/ata/pata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/pata-common.yaml
@@ -38,6 +38,7 @@ patternProperties:
       ID number 0 and the slave drive will have ID number 1. The PATA port
       nodes will be named "ide-port".
     type: object
+    additionalProperties: false
 
     properties:
       reg:
-- 
2.40.1

