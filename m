Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290EDC4332F
	for <linux-ide@archiver.kernel.org>; Thu, 29 Dec 2022 17:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiL2RBG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiL2RAc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Dec 2022 12:00:32 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA97312D20
        for <linux-ide@vger.kernel.org>; Thu, 29 Dec 2022 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672333227; x=1703869227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MsxKiByk5SZDT9+IrLorvSzVhsvu0x7m7WvNgvgs0SI=;
  b=VmM9CNcRKO8IOIqomWh6CNk7LhqFt20ohCX5ojzYwbY8Rpgw0p/nxaLR
   iSS3G/QMXfnAZxDC5OmVabj7clHSb2ebBRjAAI2G/2xmy2BFXxkzc9r7W
   F9wDOS8ADK3t7QgXFTst5dxf0kp5ZuLv8ia857jXJ5qtYoiWJdJA/g/mA
   yz5fIpRbtD/Srs9MFQnjkIfNe9bkYZNM8C19H/cHOBSH2r4LtvIwdANqD
   ouH1DIHn/DJVVailXbMe9N6PGVaXCsDcuoEoBSQV8HAmgdxQRpaHbE6KO
   bPfpBk7zEpsjwLnhjhIHstkdr9tzvIIxLwpe0IZR3YFzN1hPmO0Us/Qo0
   A==;
X-IronPort-AV: E=Sophos;i="5.96,284,1665417600"; 
   d="scan'208";a="323991008"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 01:00:27 +0800
IronPort-SDR: t0MO9gcntJHGjNEoz9PhjnqaT6OlQ1tQt/m2JFnHUwDNdMWs23TtRALaloK4T4T7azN5YvotEy
 zVszvTFeRr/mgNvG1ERRyOQo8y5XRcCsjPri17xz61Pbi5YUcqsE+dyYzlYE3OrTZfy2NTxVWH
 lKlJAhy/hjxumWNhU9wCaQMF34pkXIpyWrn+VfAPjFT8PmngBNBAuhnaDuOGXfOdrWD7VU0xI0
 B+4QrCmDDnpUJZM1JJvQDOotzdJJkQqWlowRcOn8jI+N+BxVVYwiUbKgj4TRYF7cEtLylDqA13
 pWo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Dec 2022 08:18:31 -0800
IronPort-SDR: Apx8iwhU9gEMJdVBJinKe0OcEf3P8RZSTg3ScoDVYFbi7jr2v9+DIchqznMKnd5Sr6fQoMrWMj
 dTLv1HIhbIh06dKOLIn7LceHz3iHG22VQFTCiBbBj/8ZrduEyat8UpfPrvw1wlTo74W5ZniSE0
 mpfQD9CPu8Tmk5/lRS/2Tp5ze6gzWyNTV8xjw0pIpBoimvudPXdbmcT9YLOx/PFbq/NnnuyDYk
 NsE59Ewaq54pgxvGB7h3uKiKsOIcEjDbgjTAAkjpVJBCzkVGGisDs2r7cUy4iT+ofSnwWRvJzv
 N1U=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Dec 2022 09:00:27 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH v2 7/7] ata: libata-scsi: improve ata_scsiop_maint_in()
Date:   Thu, 29 Dec 2022 18:00:03 +0100
Message-Id: <20221229170005.49118-8-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229170005.49118-1-niklas.cassel@wdc.com>
References: <20221229170005.49118-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Allow translation of REPORT_SUPPORTED_OPERATION_CODES commands using
the command format 0x3, that is, checking support for commands that are
identified using an opcode and a service action.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e1c43f9f6bb2..46109bde8a04 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3266,11 +3266,12 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
 	u8 supported = 0;
 	unsigned int err = 0;
 
-	if (cdb[2] != 1) {
+	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
 		err = 2;
 		goto out;
 	}
+
 	switch (cdb[3]) {
 	case INQUIRY:
 	case MODE_SENSE:
-- 
2.38.1

