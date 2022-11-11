Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986DC4332F
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 11:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiKKLJk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 06:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiKKLJ3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 06:09:29 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27667101
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 03:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668164968; x=1699700968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4RiHsU1jwHUkIP4zazEvf7ayxXr/ETX8lP9UDsthGus=;
  b=Jo11Qnu+B3jzVorI21MuexGhKeOGtCT/+VaPSVhs4buLO+BwVDJbY7kh
   hG77R7ulUPFxEM9ZKYD7GbTEn91sbMQxvCGf58PLLVoOa1an0jVtEDrog
   lDEuARmAatmbpvSq1ADhE728kXj0/+xFBEm7e/JzHbvBAxLz4tUTEat/p
   my76NRchZDCOkk3+O+1sHtIA7N5/8HwGQzzNWc4wD2VU3R5mnBkKh7TXG
   34gvfdGwQrHfb/12Zw3GomHtrCW7GHhOuxWGJLdTvqmHJVeEIC5W27xMJ
   evKRLs9mSsySzYHBa8phyLwkR4O/0G0K9LOnv7Ct8svD4b6GpMF1d13Sc
   A==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665417600"; 
   d="scan'208";a="320384065"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2022 19:09:28 +0800
IronPort-SDR: TGlYV6e7wZ4NiqVIkY8OTbc3wCFHUlWfKeuxkzsT/2nz/kqniQPCX1i9BXXa9wIAt1hUQESQKd
 C8m6NnjRHqhiPA0V+u93czCJuCBF9NP76fxRbPD4JAOZVDwJS/zWpzb622+AyWF5Lhkv1LWBeb
 9wu5Z4J1pRO5aPvZAA97yFlmpSRK7HarDKmghNvoZni6BJJ+aCbhNrjDGYLZHlmTMbB618FYAK
 zxwsr4bUsd2tOyEE2jm5cr4B3fkKegDXbnAyKPNgpywEkC7mK7jYiMuTr7A2aicdl1yeolGGlX
 pTY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 02:22:45 -0800
IronPort-SDR: CoFGYHGgWEBh69CCPLxkwA0EhiWvcHMNOg5yi+erXDRCErN6W/IS0UZR6LeHh1j+3DzVJJu8E6
 pVH0UDMXZD5jsbMykHN8KfIou1VtMMotihYZFNddSgmLhiDVMHzcptR/vXhVcPZ71qRm1YB/hI
 TMoKhbBhRX0Aas0yEDe8KCR4itT8FwVr/lYOf2OhfIoRhhw4hRPXLiTEZRpMkVEHm0mAw3+x0s
 D3u8BURNQklUTQl0EZzZTe7/iFNszGIBz2cQM2sIy4hSCfurcyjbwMLIZ63ZH11sQT+J0vb4iW
 zOQ=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.31])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2022 03:09:27 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: libata: skip error analysis for commands that are not errors
Date:   Fri, 11 Nov 2022 12:09:20 +0100
Message-Id: <20221111110921.1273193-3-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111110921.1273193-1-niklas.cassel@wdc.com>
References: <20221111110921.1273193-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A NCQ error means that the device has aborted a single NCQ command and
halted further processing of queued commands.
To get the single NCQ command that caused the NCQ error, host software has
to read the NCQ error log, which also takes the device out of error state.

ata_eh_link_autopsy() starts off by calling ata_eh_analyze_ncq_error() to
read the NCQ error log, to find the offending command that caused the NCQ
error. ata_eh_analyze_ncq_error() marks the offending command by setting
qc->err_mask to AC_ERR_NCQ.

ata_eh_link_autopsy() then continues with further analysis for all
commands owned by libata EH.

However, once we have found the offending command, we know that all other
commands cannot be an error. (Theoretically a command could have timed out
just before the NCQ error happened (so EH was scheduled but did not yet
run), such command will have AC_ERR_TIMEOUT set in qc->err_mask.)

Therefore, after finding the offending command, we know that we can simply
skip the per command analysis for all commands that have not been marked
as error at this point, since we know that they have to be retried anyway.

Do this by changing ata_eh_analyze_ncq_error() to mark all non-failed
commands as ATA_QCFLAG_RETRY, and change the loop in ata_eh_link_autopsy()
to skip commands marked as ATA_QCFLAG_RETRY.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Flag ATA_QCFLAG_FAILED is kept since it means that the command is owned
by libata EH. A failed command will always have qc->err_mask set.
Perhaps flag ATA_QCFLAG_FAILED should be renamed to something like
ATA_QCFLAG_OWNED_BY_EH to further clarify this meaning, and that the flag
does not necessarily mean that it is an error.

 drivers/ata/libata-eh.c   | 1 +
 drivers/ata/libata-sata.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index bde15f855f70..34303ce67c14 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1955,6 +1955,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 
 	ata_qc_for_each_raw(ap, qc, tag) {
 		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		    qc->flags & ATA_QCFLAG_RETRY ||
 		    ata_dev_phys_link(qc->dev) != link)
 			continue;
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 6b2dcf3eb2fb..18ef14e749a0 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1493,6 +1493,14 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 		 */
 		qc->result_tf.status &= ~ATA_ERR;
 		qc->result_tf.error = 0;
+
+		/*
+		 * If we get a NCQ error, that means that a single command was
+		 * aborted. All other failed commands for our link should be
+		 * retried and has no business of going though further scrutiny
+		 * by ata_eh_link_autopsy().
+		 */
+		qc->flags |= ATA_QCFLAG_RETRY;
 	}
 
 	ehc->i.err_mask &= ~AC_ERR_DEV;
-- 
2.38.1

