Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BDC4332F
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 11:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiKKLJ2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 06:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiKKLJ1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 06:09:27 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305D9FEE
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668164966; x=1699700966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcaFbL/rY8VVqtolwvC1gAY+zQp99aD7a6DiwevWMLw=;
  b=pkJaouaMSunTGiBMC8WuHvrOQ1k0F9Jz932iHD1q+9JDJfRSxL1HEmLI
   blizZ7KScBykHdHPlG1g76+Jdqgrzdq9w/bHZum/klqr3B6FvCWri1HsY
   ozUsYilPJg5WPoyQPYkxzzeL6y5HdhfPVUoYwneABybXeK0NIqSzS5XIg
   AuziGQPuLwbOxBjC/CRpfriqnN96oMCxqQlb955SZGqwKvRFFeK/ZTYQm
   rBrl8uahkqQSvBreG41rpRymKZuouAA6P4RaNm6/oPOeaZPlmYytiDnby
   cdX4yuNkKXHBPlUH8FkkmMwYcMxNO/jBW2yeatLnfy7Lh/yruwgA/id81
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665417600"; 
   d="scan'208";a="320384064"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2022 19:09:26 +0800
IronPort-SDR: 8jbNYTS8OzyX1H6HdYlzx1oM4XXkYxdOkl2BZY4jR5S7/KdyF2IGj1Bwr1gFz+NN0Fx9t9AK1j
 zJn+AioQYTzHQJXLtWA6yQ14s1YQVnABeT5abTbISBOXNhXyLhwd6QtrTFzsm1lEX+J4s32win
 BHEZITaYJ8/rk6mMmHFbLSudtJTTylaR/yRHEQj8WXYZW4o79YlM+CkK5KZzYVZZHxqINY7PGk
 ANU0zWNsoqhTG5SlFDCvjrfSyiWQ6X+s/AI4mgmlPU2JNFqz6JLKWC/i2+cfQM4mZH7hOCoQ2l
 1e4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 02:22:44 -0800
IronPort-SDR: a03OvBKAaDWapj45eqAjnKmbjPkc1rC8ma1qhtQmIdcBkg0lxXpnpf2gyMs/4EzqcaLvvG9ZD5
 dXQUx34u+cf6h1tM0D5P8QDcWTRLlmUCe1oLdLUKerC7khUZraeCesAfYHs9DltgSJW4uqrx4V
 02WK2Hc9Ljz2FljVAsop8a7K5s9mH1zlnquMsH88hn8cMl8OrpvMtA5s5znI4uUwkTXuJr0BIe
 N0a23Lf5UFKhdo7jjp68DbKqzNqjPYPjf8XOl0bnGVlrJkjJh87e/8nDMAvikxgnEBnDaNxQLj
 hcA=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.31])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2022 03:09:26 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 1/2] ata: libata: only mark a single command as error during a NCQ error
Date:   Fri, 11 Nov 2022 12:09:19 +0100
Message-Id: <20221111110921.1273193-2-niklas.cassel@wdc.com>
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

When the device encounters a NCQ error, we receive an error interrupt from
the HBA, and call ata_do_link_abort() to mark all outstanding commands on
the link as ATA_QCFLAG_FAILED (which means that these commands are owned
by libata EH), and then call ata_qc_complete() on them.

ata_qc_complete() will call fill_result_tf() for all commands marked as
ATA_QCFLAG_FAILED.

The taskfile is simply the latest status/error as seen from the device's
perspective. The taskfile will have ATA_ERR set in the status field and
ATA_ABORTED set in the error field.

When we fill the current taskfile values for all outstanding commands,
that means that qc->result_tf will have ATA_ERR set for all commands
owned by libata EH.

When ata_eh_link_autopsy() later analyzes all commands owned by libata EH,
it will call ata_eh_analyze_tf(), which will check if qc->result_tf has
ATA_ERR set, if it does, it will set qc->err_mask (which marks the command
as an error).

When ata_eh_finish() later calls __ata_qc_complete() on all commands owned
by libata EH, it will call qc->complete_fn() (ata_scsi_qc_complete()),
ata_scsi_qc_complete() will call ata_gen_ata_sense() to generate sense
data if qc->err_mask is set.

This means that we will generate sense data for commands that really
should not have any sense data set. Having sense data set might cause SCSI
to finish these commands instead of retrying them.

While this incorrect behavior has existed for a long time, this first
became a problem once we started reading the correct taskfile register in
commit 4ba09d202657 ("ata: libahci: read correct status and error field
for NCQ commands").

Before this commit, NCQ commands would read the taskfile values received
from the last non-NCQ command completion, which most likely did not have
ATA_ERR set, since the last non-NCQ command was most likely not an error.

Fix this by clearing ATA_ERR and any error bits for all commands except
the actual command that caused the NCQ error, since the error bits in the
taskfile are not applicable to them.

Fixes: 4ba09d202657 ("ata: libahci: read correct status and error field for NCQ commands")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-sata.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 283ce1ab29cf..6b2dcf3eb2fb 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1476,6 +1476,25 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 		}
 	}
 
+	ata_qc_for_each_raw(ap, qc, tag) {
+		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		    ata_dev_phys_link(qc->dev) != link)
+			continue;
+
+		/* Skip the single QC which caused the NCQ error. */
+		if (qc->err_mask)
+			continue;
+
+		/*
+		 * For SATA, the STATUS and ERROR fields are shared for all NCQ
+		 * commands that were completed with the same SDB FIS.
+		 * Therefore, we have to clear the ATA_ERR bit for all QCs
+		 * except the one that caused the NCQ error.
+		 */
+		qc->result_tf.status &= ~ATA_ERR;
+		qc->result_tf.error = 0;
+	}
+
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
-- 
2.38.1

