Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D399C433F5
	for <linux-ide@archiver.kernel.org>; Mon,  3 Oct 2022 19:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJCTrI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 Oct 2022 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJCTrC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 Oct 2022 15:47:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24938491D3
        for <linux-ide@vger.kernel.org>; Mon,  3 Oct 2022 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664826421; x=1696362421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ohsrglfb/dr/nYlv3w0EIoEvMDLO6S3rUiv/YN+94c=;
  b=SMqGXVSQp3bDrI2OpwMApILtD6DsGeq3Uw5a7FMkXqfef34ZliTnb7fH
   MkjY89cPgFzBbMkPZKMhV9Ovk3xObfYBckKL4CtKC1BN+VoKX98o35gG3
   BbPaGs7rX2Jis0imVWTJQ698wl/Ein44KJ+GQdes2ERhSGBQ3002ivuWq
   KSgjLBXzkwzDGWRCP3qs9NY7QfU1jQQszzgcDX2YU0YQu9hBP+O7vhPRG
   BNd1vxKneq3SC7felkGzuZlsaptXT8q+Hn7TovJdZDQGSoe0CULGy/FKc
   jucvjGfBgB/AMEMNXYq1Ei8HbBm+8ycvGJIuzQTm2l8rlTVWaMTyLMHXc
   g==;
X-IronPort-AV: E=Sophos;i="5.93,366,1654531200"; 
   d="scan'208";a="213286596"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2022 03:46:59 +0800
IronPort-SDR: yVLrfFIy+T4LNHyHTkis7OGx8DwVsx1gWvREM1faImXYb0xDfkZa3rZMqO9msXiPzKhjq2aRxQ
 WOYPGX9SF6JXp6abal02ZryyyODPGnirEmOO46NH2VcuTertluDT+w3XYjGAqTVCHeg7xgG14D
 PH9RhBG2sAOm34+vtE5+svtwsdVcDp0nLyzf0pS7ODrAhRDvFHwwCaBTZ8W4jLum5Pe55driL6
 sOKNDALr3Jyf1BRK17etPMYairXsgEmDNduf//8oX0JLqy9L5aPPgOLj7c0p+ikLQ0+7Y9tQxN
 AYgpH1a4Y0siTjm/siDoufuc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2022 12:01:14 -0700
IronPort-SDR: Djx3EM/laEFovSljhkVJ6egyK1XzYAoxvq00+J/nFHjNPLsED0EdB6tQkaCywRq+BwaNlYD+HH
 cOz/xNbFNaITPNzAYL2BZxfdmIgzQSnU8GSC8ADylm0xn33K9j7XadqVnGJ8XlrueL5mHnpiSb
 pvwQgW1+EfJhRgQtPJzN0tcdaPbvR+iFbwWc2yi0BeJmHy6K2UUK8k6eGeIr8djuZDTuvyKqoB
 qgwwXx87RvQ1oVqkT8DmNd6Fj6nZRP4kHWkTJuP+T/v2jQ96rh0KMTNFZB4XnPRgkftARxTEft
 Md8=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.61])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Oct 2022 12:46:58 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: libahci: read correct status and error field for NCQ commands
Date:   Mon,  3 Oct 2022 21:46:52 +0200
Message-Id: <20221003194652.1166130-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Currently, for PIO commands, ahci_qc_fill_rtf() reads the status and
error fields from the PIO Setup FIS area of the Received FIS Structure.

For any non-PIO command, ahci_qc_fill_rtf() currently reads the status
and error fields from the D2H Register FIS area of the Received FIS
Structure. This is simply not correct.

According to the SATA 3.5a specification:
11.10 DMA DATA-IN command protocol and 11.11 DMA DATA-OUT command
protocol: READ DMA and WRITE DMA (non-NCQ commands) will end with
the Send_status state, which transmits a Register D2H FIS.

Likewise, in:
11.15 FPDMA QUEUED command protocol: READ FPDMA QUEUED and WRITE FPDMA
QUEUED (NCQ commands) will end with the SendStatus state, which
transmits a Set Device Bits FIS.

So, for NCQ commands, there is never a D2H Register FIS sent.
Reading the status and error fields from the D2H Register FIS area
for a NCQ command, will result in us returning the status and error
values for the last non-NCQ command, which is incorrect.

Update ahci_qc_fill_rtf() to read the status and error fields from
the correct area in the Received FIS Structure for NCQ commands.

Once reason why this has not been detected before, could be because,
in case of an NCQ error, ata_eh_analyze_ncq_error() will overwrite
the (incorrect) status and error values set by ahci_qc_fill_rtf().

However, even successful NCQ commands can have bits set in the status
field (e.g. the sense data available bit), so it is mandatory to read
the status from the correct area also for NCQ commands.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libahci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index cf8c7fd59ada..d30c1a4c11fe 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2034,6 +2034,20 @@ static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	    !(qc->flags & ATA_QCFLAG_FAILED)) {
 		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
 		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
+
+	/*
+	 * For NCQ commands, we never get a D2H FIS, so reading the D2H Register
+	 * FIS area of the Received FIS Structure (which contains a copy of the
+	 * last D2H FIS received) will contain an outdated status code.
+	 * For NCQ commands, we instead get a SDB FIS, so read the SDB FIS area
+	 * instead. However, the SDB FIS does not contain the LBA, so we can't
+	 * use the ata_tf_from_fis() helper.
+	 */
+	} else if (ata_is_ncq(qc->tf.protocol)) {
+		const u8 *fis = rx_fis + RX_FIS_SDB;
+
+		qc->result_tf.status = fis[2];
+		qc->result_tf.error = fis[3];
 	} else
 		ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
 
-- 
2.37.3

