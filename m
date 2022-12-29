Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA8AC4332F
	for <linux-ide@archiver.kernel.org>; Thu, 29 Dec 2022 17:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiL2RAz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiL2RA1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Dec 2022 12:00:27 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095DF1276F
        for <linux-ide@vger.kernel.org>; Thu, 29 Dec 2022 09:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672333226; x=1703869226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ou/zB7g3j8YdYvKA39NcxRMlMw4tzov3bP1icuP5yDI=;
  b=cWPaLb6HCsGiyT+QPSFPLHodBXDdpvxoEICQit7SVcJtPL5AyWd7dCG0
   nlMgntGoofdPtsEkdCOCdnne5fuv6bFRtXhNBpn+cfL72Azmrbyw7H2qF
   hgEeZPpStEUobZN4Jxni9/tthOhJgUokh/55RXpkNnbt0LHHwYOKAKQky
   olVgfJ9N+uHj8/4RGFHaSGI8/zdA05jR/40ntJ0IzkQ1ypL+7iThENsY8
   3PfIv1VY4LwmPjB1d0/w82Rx8SJQxFEMwVyxOMZuPBLq0aIbXIw+Vo1EZ
   nkMWbHg8sn3TKKSL4z4gAMG3ObjDkD0cMBKm6ABbBjvS5GVKJw+iNKrrT
   A==;
X-IronPort-AV: E=Sophos;i="5.96,284,1665417600"; 
   d="scan'208";a="323991000"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 01:00:25 +0800
IronPort-SDR: PGCMZpL4Ju1SsXNLOamDnxwYGlG8qoktXr9yflKcJpM+nJSyi+TenqJRQIEp+ysRbMlI05/H2D
 su/A22oHKUmoWw2apXITFGoGTTxFusQ0rqICuUzk07FV/7fW2iK/4d++eGz0cxHKF/kT/XECqV
 bcCgegWcg4uObNXyBPhEvySAcsIcFIo0wW+l82e19/cd2uy+6p0bgb+IC1ZZmcFrnoxYwqVtdf
 2nWmCHKwcy8jgmqkz44b0ys1gQNqNBzB+eha01JOf293BMc4LOp6kyqoQ+g+9vmecN+efrVrOF
 D3A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Dec 2022 08:18:30 -0800
IronPort-SDR: +dzoH6MkizE0UD6xumW1BZzOdMo3cJBHVyuWZzLMWWs1V14Z7ITlhEX9OY8ktuU+H0kEIArOTX
 sgPfwBvx55nstY6MqpNfCzPSIT0uqN8+yDbjmZ9JgIgz8U3VkIzMrQVpYrg5knOXBHLfaKpuPt
 61eKPESsJf13bnxZjJoNlI/clHSzVX/kQTOUizVcRiV1k9LvSo11yu1JqaEdYrLjS9KyFnVRib
 6YnsxAR2YtcVgv/egUCgTXZk/tfkmJlAIbSg/BY543hi9yvVUHU3Nnx9Ko7e35F0oMMKgQlaU7
 QZg=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Dec 2022 09:00:25 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH v2 6/7] ata: libata-scsi: do not overwrite SCSI ML and status bytes
Date:   Thu, 29 Dec 2022 18:00:02 +0100
Message-Id: <20221229170005.49118-7-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229170005.49118-1-niklas.cassel@wdc.com>
References: <20221229170005.49118-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

For SCSI ML byte:
In the case where a command is completed via libata EH:
irq -> ata_qc_complete() -> ata_qc_schedule_eh()
irq done
... -> ata_do_eh() -> ata_eh_link_autopsy() -> ata_eh_finish() ->
ata_eh_qc_complete() -> __ata_eh_qc_complete() -> __ata_qc_complete() ->
qc->complete_fn() (ata_scsi_qc_complete()) -> ata_qc_done() ->
qc->scsidone() (empty stub)
... -> scsi_eh_finish_cmd() -> scsi_eh_flush_done_q() ->
scsi_finish_command()

ata_eh_link_autopsy() will call ata_eh_analyze_tf(), which calls
scsi_check_sense(), which sets the SCSI ML byte.

Since ata_scsi_qc_complete() is called after scsi_check_sense() when
a command is completed via libata EH, we cannot simply overwrite the
SCSI ML byte that was set earlier in the call chain.

For SCSI status byte:
When a SCSI command is prepared using scsi_prepare_cmd(), it sets
cmd->result to 0. (SAM_STAT_GOOD is defined as 0x0).
Likewise, when a command is requeued from SCSI EH, scsi_queue_insert()
is called, which sets cmd->result to 0.

A SCSI command thus always has a GOOD status by default when being
sent to libata.

If libata fetches sense data from the device, it will call
ata_scsi_set_sense(), which will set the status byte to
SAM_STAT_CHECK_CONDITION, if the caller deems that the status should be
a check condition.

ata_scsi_qc_complete() should therefore never overwrite the existing
status byte, because if it is != GOOD, it was set by libata itself,
for a reason.

For the host byte:
When libata abort commands, because of a NCQ error, it will schedule
SCSI EH for all QCs using blk_abort_request(), which will all end up in
scsi_timeout(), which will call scsi_abort_command(). scsi_timeout()
sets DID_TIME_OUT regardless if a command was aborted or timed out.
If we don't clear the DID_TIME_OUT byte for the QC that caused the
NCQ error, that QC will be reported as a timed out command, instead
of being reported as a NCQ error.

For a command that actually timed out, DID_TIME_OUT would be fine to
keep, but libata has its own way of detecting that a command timed out
(see ata_scsi_cmd_error_handler()), and sets AC_ERR_TIMEOUT if that is
the case. libata will retry timed out commands.

We could clear DID_TIME_OUT only for the QC that caused the NCQ error,
but since libata has its own way of detecting timeouts, simply clear it
always.

Note that the existing ata_scsi_qc_complete() code does:
cmd->result = SAM_STAT_CHECK_CONDITION or cmd->result = SAM_STAT_GOOD.
This WILL clear the host byte. So us clearing the host byte
unconditionally is in line with the existing libata behavior.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cbb3a7a50816..e1c43f9f6bb2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1654,7 +1654,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
-	int need_sense = (qc->err_mask != 0);
+	int need_sense = (qc->err_mask != 0) &&
+		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -1668,12 +1669,11 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
 	    ((cdb[2] & 0x20) || need_sense))
 		ata_gen_passthru_sense(qc);
-	else if (qc->flags & ATA_QCFLAG_SENSE_VALID)
-		cmd->result = SAM_STAT_CHECK_CONDITION;
 	else if (need_sense)
 		ata_gen_ata_sense(qc);
 	else
-		cmd->result = SAM_STAT_GOOD;
+		/* Keep the SCSI ML and status byte, clear host byte. */
+		cmd->result &= 0x0000ffff;
 
 	if (need_sense && !ap->ops->error_handler)
 		ata_dump_status(ap, &qc->result_tf);
-- 
2.38.1

