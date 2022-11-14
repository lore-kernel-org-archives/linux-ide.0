Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3979BC433FE
	for <linux-ide@archiver.kernel.org>; Mon, 14 Nov 2022 17:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiKNRWa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiKNRWG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Nov 2022 12:22:06 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14CB21E27
        for <linux-ide@vger.kernel.org>; Mon, 14 Nov 2022 09:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668446524; x=1699982524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kHDgpH4MZZ0JfYfGrJK35x7ur2PsrCfNRiyz/h7gtXE=;
  b=JYL999SEV02WSrWwIbIk94ldl9f5gxy+xI0h8NZrvV6gPYxpdi/wJ7+3
   X5/ihMmfOGyf1LQoW4DK9qT/HrUsBiB2/6fn++x9NoimXSXJZJySwq9+M
   Cb1uWwConFWaCLv2S9Yu9wWCWTGHg+ZYyhStwQ+DNHWK7LIbgk6/NpLF3
   21Z7I5hrH56AC78gPCPoILpAToZZJAnolfvNoIeV7FdcCsTXeOSgbIvxn
   BkkhIBpZXtAbNxaYCDpIKgbNxd6P2vEI2ZdeB5q3HCS4ToLRLg4IgYIaL
   SvvPZWeTUC11XTP9eXtN3Ma619w+QrRU3cN0HrXVpPEmsqFIU5WfSAXpI
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665417600"; 
   d="scan'208";a="221398183"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 01:22:04 +0800
IronPort-SDR: Nhp7eycWCBcf5Zd+8kOooLw4duCSHKoitFizTJHXxyE3EhmiWlhVsKTqeLmlWr1nP1lvqTxXK3
 01J/3r7eV/VS0uf/YMu23kFGkYIQn/AwSijUiY6pZhvvyghsgLw8QzyIGTzuhuH4lIZ9eYwFVn
 tpuHsA01HqzllKe0QIulirThCwYg+yyioV/qEOHkgcda13Eqjm3oF/a6mEyomUMgdKbGJJB5M6
 lhmxWv/jCpW+UZ1Pn8RrEq+q6DqAg68df8N6su0GMYRN1nrCs8FeSy9dw73ad1jw8CxXY9U7HM
 Kl4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 08:41:02 -0800
IronPort-SDR: ey30vvgIP/JEjDZ+FJcBS22jK4/90oapZ5tDiP31K8CWcPJC0z3AgTCBV161DzalNJlbwjBfXV
 FdKaB9qxE+/EbuZvAFbH/PtR3FJf/Gf5/qz8sWt24Q62ewSOPndRvKwoPKtbJOhKrJMH72b1Kl
 GN4YGQrIpiZFTvM7/ir5p2hVw3Ma9llpo5VNyYrGFigA54yBUKjBfHFPAu/KJ7eiSGNkQ5VSSs
 sVMr7qAcSqLWQBbaoCfrac86mx7ixkN6oE8aPHHIJ6h+txGji9L311PAty/FWQCLJOlwISKiLr
 F0k=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.31])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2022 09:22:02 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata: fix commands incorrectly not getting retried during NCQ error
Date:   Mon, 14 Nov 2022 18:21:59 +0100
Message-Id: <20221114172200.1475962-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A NCQ error means that the device has aborted processing of all active
commands.
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

This means that we will generate sense data for commands that should not
have any sense data set. Having sense data set for the non-failed commands
will cause SCSI to finish these commands instead of retrying them.

While this incorrect behavior has existed for a long time, this first
became a problem once we started reading the correct taskfile register in
commit 4ba09d202657 ("ata: libahci: read correct status and error field
for NCQ commands").

Before this commit, NCQ commands would read the taskfile values received
from the last non-NCQ command completion, which most likely did not have
ATA_ERR set, since the last non-NCQ command was most likely not an error.

Fix this by changing ata_eh_analyze_ncq_error() to mark all non-failed
commands as ATA_QCFLAG_RETRY, and change the loop in ata_eh_link_autopsy()
to skip commands marked as ATA_QCFLAG_RETRY.

While at it, make sure that we clear ATA_ERR and any error bits for all
commands except the actual command that caused the NCQ error, so that no
other libata code will be able to misinterpret these commands as errors.

Fixes: 4ba09d202657 ("ata: libahci: read correct status and error field for NCQ commands")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v1:
-Squashed patch 1/2 with 2/2.

 drivers/ata/libata-eh.c   |  1 +
 drivers/ata/libata-sata.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

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
index 283ce1ab29cf..18ef14e749a0 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1476,6 +1476,33 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
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
+
+		/*
+		 * If we get a NCQ error, that means that a single command was
+		 * aborted. All other failed commands for our link should be
+		 * retried and has no business of going though further scrutiny
+		 * by ata_eh_link_autopsy().
+		 */
+		qc->flags |= ATA_QCFLAG_RETRY;
+	}
+
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
-- 
2.38.1

