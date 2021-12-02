Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A69C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 08:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbhLBIlP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:41:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26399 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345414AbhLBIlJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2021 03:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638434267; x=1669970267;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Q4+jQB6IzMwtjyTYbUVpZ8/hVJ/jfapkUHY4m/vWn54=;
  b=b4YzP7eN/rSSk8csAs1MgFnrbPH+R1XreC2CL5c53khyulCqvft1bKpC
   IasMd5n9u+Bo9208p0QnG/yCDWg++NJtHdYEDL6Z3xnzfMnRCxc4bkRKb
   8nL5FJ99GHtEBObKqw/4UijfaSyBK+mUQ2O9uLNwrH7mSoU5mbJTjgJV9
   rDIVoMYQxXxAoMDQWKNdXap++5900sUIZKxZ8F/GgNp7f/zIzRFmoJRyj
   Wu5CTQ646M1cdLYzUrCHptQb+n5RQu1666HoOKaKc2wVgJAEmM+BuS5+9
   PKEZFJMjhcA2NNoQtJY7IrAwcgU4qq+EQ3iwaKbsOqDNuNceB3Et4fjVu
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299105713"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:37:46 +0800
IronPort-SDR: 73ec2ZSPSrOxEfCVPgcfyd6wA45bqBKjUdf/EtMSYYRsEQSyjCpshMRiRWddcvDISn0N5UIPw4
 e1ViSkKfojTSvYi1K1IatVcRwSRNfFwG30QUsslU5BJv+IqgS3+v8OyWj9eSbOgRfSFrADcC9k
 ZchjYuBMmNTZaCuxUmzLr/2SlrSAlzl3ZFBYxijNY/I7WBbyKpvYz5WTFQ1Vwqq64FYOtYxoEC
 Y0/JMY8fV7ZgJRTabm2Ot+aW5ahn+83hfBaJCmGLmBUKbcNCp8VYBf9HBoP5uPBSr4V1jfYHvK
 A+62v7VLM5cv/SSqGbWi0uSS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:12:29 -0800
IronPort-SDR: oC+EEyxDRNp8yXGeBUODWHYHXJe516iATScNhTyDOA+ACumomc/nZbvDfiIh1EFArMgsHKuLd6
 gltzlf+3s7K5MkGbZK1W9/G6cFAZoMJCUFcI3SMX9KkYVXq0wjjOEmycvztUASV1VdKwhYQH4l
 v9IzD6XrrSfmhCAMrLsB2vKXI/+ynAgI0NAtPqKBNfINCyYgvRIHOeSJhFOkmGFiJd8+fTuiTv
 gvZf5WhYikHRyNOujaHN6B12bBWW33prLTLhsRiVMtKxISvof/tRjZN/ilq8V3RLodFHqy6x7J
 qUY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:37:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4TqF5FJfz1RtVp
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638434265; x=1641026266; bh=Q4+jQB6IzMwtjyTYbU
        VpZ8/hVJ/jfapkUHY4m/vWn54=; b=lExo43XBbMECI0D+RVdJw0jDw7ubQWV1LR
        eYEMfJlJxZ8qlZvit9JyPSb10URh8VhHNnjd9FQgp8Dk+GjzNmTli+rllWsGZ21h
        sHr4l5ddeGYoEUZSjP+cAresLAyvaCOyX6eYjz3E13/i4sz9vTe23aVlYED6f+DP
        paOI2tgPIP3l4BcUrneBDk0rb7CGS1pEYl/oXSC/XOeWa0rIcvXl+fSoOHZhMucL
        f6fVJQVCeCsXGCGrWDcV3eJwxsZOLKLln6WMw0P//yfQHNb23J8hWY1nENlOH4rs
        UsqumKqhLjTfvdvSOzStVRF0BR6fBg2oRZPvhbHpnAQfex1q+wfw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id af9OiuEplQ69 for <linux-ide@vger.kernel.org>;
        Thu,  2 Dec 2021 00:37:45 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4TqF11yYz1RtVn
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:45 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci_ceva: Fix sparse warning in ceva_ahci_read_id()
Date:   Thu,  2 Dec 2021 17:37:39 +0900
Message-Id: <20211202083743.645391-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
References: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the following sparse warning:

drivers/ata/ahci_ceva.c:107:33: warning: invalid assignment: &=3D
drivers/ata/ahci_ceva.c:107:33:    left side has type unsigned short
drivers/ata/ahci_ceva.c:107:33:    right side has type restricted __le16

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_ceva.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 50b56cd0039d..e9c7c07fd84c 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -94,6 +94,7 @@ struct ceva_ahci_priv {
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
 					struct ata_taskfile *tf, u16 *id)
 {
+	__le16 *__id =3D (__le16 *)id;
 	u32 err_mask;
=20
 	err_mask =3D ata_do_dev_read_id(dev, tf, id);
@@ -103,7 +104,7 @@ static unsigned int ceva_ahci_read_id(struct ata_devi=
ce *dev,
 	 * Since CEVA controller does not support device sleep feature, we
 	 * need to clear DEVSLP (bit 8) in word78 of the IDENTIFY DEVICE data.
 	 */
-	id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
+	__id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
=20
 	return 0;
 }
--=20
2.31.1

