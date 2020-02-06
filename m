Return-Path: <SRS0=+eSp=32=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC5CC2D0B1
	for <linux-ide@archiver.kernel.org>; Thu,  6 Feb 2020 11:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493A0214AF
	for <linux-ide@archiver.kernel.org>; Thu,  6 Feb 2020 11:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iZMhQee8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgBFLRh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:17:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59556 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgBFLRg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 6 Feb 2020 06:17:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 016BHXgE012961;
        Thu, 6 Feb 2020 05:17:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580987853;
        bh=+m7cJqiaPTAt35RzkCxMV+/3fy67doLnxsI8W1Jm5vU=;
        h=From:To:CC:Subject:Date;
        b=iZMhQee8mNEN3M4lopYrHxVD9NnYxE3BVnATE6xXxgdN6LSs5vAsvup0HGd6KSYHa
         SAfGz3773xd2WsY5VLV5eiQlq6gEFD2QD+hF3odi6xtqsL34Cb/nAtKuTOE6zvJUXd
         PFYbHkentN1cwhq0MGG/oMUBmgo/nfyyRSWCUyvM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 016BHWfC005620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Feb 2020 05:17:33 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 6 Feb
 2020 05:17:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 6 Feb 2020 05:17:32 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 016BHUWH011314;
        Thu, 6 Feb 2020 05:17:30 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <hdegoede@redhat.com>, <axboe@kernel.dk>
CC:     <vigneshr@ti.com>, <nsekhar@ti.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] ata: ahci_platform: add 32-bit quirk for dwc-ahci
Date:   Thu, 6 Feb 2020 13:17:28 +0200
Message-ID: <20200206111728.6703-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On TI Platforms using LPAE, SATA breaks with 64-bit DMA.
Restrict it to 32-bit.

Cc: stable@vger.kernel.org
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/ata/ahci_platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 3aab2e3d57f3..b925dc54cfa5 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -62,6 +62,9 @@ static int ahci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
 
+	if (of_device_is_compatible(dev->of_node, "snps,dwc-ahci"))
+		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+
 	port = acpi_device_get_match_data(dev);
 	if (!port)
 		port = &ahci_port_info;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

