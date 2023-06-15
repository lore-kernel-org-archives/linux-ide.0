Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBFEB64D9
	for <linux-ide@archiver.kernel.org>; Thu, 15 Jun 2023 01:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjFOBBM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOBBM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jun 2023 21:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9746226A4;
        Wed, 14 Jun 2023 18:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3488661D9A;
        Thu, 15 Jun 2023 01:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1512C433C8;
        Thu, 15 Jun 2023 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686790870;
        bh=CHWOfhN3gHK0RrGxwQdkL//1UwkERDYlcxlOmTnOIu8=;
        h=From:To:Cc:Subject:Date:From;
        b=LBXJcce/p9h01t2F1M22U19+VdYK+lJM0Ki7ykpycMILzuWt1lvRD5eZg4LB+Z7Yy
         en0pJxusWQNCc6/U+VKxZfOLLrQAwWliqHJ3uiDpIcd/57ji4AhPnmlHdHJ0eRFcZ+
         j1Z0+Ixn+kNMN/bO/O4Y7X1Q+L2LX/OjRaWrMj1W18WTBX4Jd+jkk91/ltZVnRfmoG
         YhOQsvkN+FsqjPg/X5NZRm3M4iY5PJ3xnmJfW53rFQ3Dv2xhxyTVvHCzmdd2TleKTV
         pGndDstyo/qWH1IoFc5h+0EFXIuNL9yuGemmktZiiPbZQ04nwhOIC33R/EXJxvaeFY
         lpRoQz9yCIH8A==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rob Herring <robh@kernel.org>,
        linux-mips@vger.kernel.org
Subject: [PATCH] ata: ahci_octeon: Remove unnecessary include
Date:   Thu, 15 Jun 2023 10:01:08 +0900
Message-Id: <20230615010108.77319-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

asm/octeon/octeon.h already includes asm/bitfield.h, so there is no need
to include this latter file in ahci_octeon.c as the code does not
directly use the __BITFIELD_FIELD macro defined in it.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci_octeon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index 5021ab3ede49..e89807fa928e 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -16,7 +16,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/bitfield.h>
 
 #define CVMX_SATA_UCTL_SHIM_CFG		0xE8
 
-- 
2.40.1

