Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E46C28B2B
	for <linux-ide@archiver.kernel.org>; Tue, 16 Aug 2022 12:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiHPMFb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiHPMFN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 Aug 2022 08:05:13 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2F14088
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2022 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660650825; x=1692186825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xPbMnfXhMPj7c3C5zI4tahRJr/Wy1fcdc8R6fXqq8O8=;
  b=QLCbf+ZVprme5W808vLCSzqEb9wmbOTdxsogeqKHcipMqDcwK6F22fsu
   h15Jov8ECmaCY3SBK6lPz3tdCv3CFr0RpgQpaCdo70mE7BfiHfpgI0K42
   61FYZiyyE56wACEF56gDtdOXbNsfVLxfuFtqm/1IapHYslAQGzW22kOaq
   Fn4jlTToKxW713hA81u7QuoXG6Hy1bo6Dir3icun7DwsGcUwn/6MJ0mKK
   CBvgzB+ycbJsv3SSbs1oAfq1mvQw61nqNreqQdkUHtRTqX0riM9uzGL8H
   +Lv7XIss3y1hD3XtKYJ5HkjvHO0FUVSwaQDtlLPaY3VplDSqO7Mz1sDyX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654531200"; 
   d="scan'208";a="207306598"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 19:53:42 +0800
IronPort-SDR: Mly0r1drh/jphGrlhMYguvXh7D1BLcD9ApbsBxT45JceeGfVGZxAmN1WWY1fzX37NIm+CWwcNf
 2Xzhss5kA+u/MOzojPX1hSVWUprtaTEeLpAejWPUUkKp4Jx2kCZzhkSR6ENbRN3PI2S5QcVaR8
 I/2GkwK94OHWhTzW9ZPAAA/ap1oOD54hk14kXdVzOqw2PvSqv+uRmc8vI45tblXRXiQBzK/5sZ
 aLToL2ZwuSPsTCvxb0euB9O5QPSrqZVQBXZI0GCP0fPi5YxXdnQ5WNjNWbxnPrsXTqasGMK2LF
 hqfw4UaWKhYkKYz6OQ3Lw3+N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2022 04:14:31 -0700
IronPort-SDR: gyUw3KZ6kUMpajv+FCjDKfhSzcRORUwgE5UIdZ2HuoMtm1iV34j3isb8ulKMv/ZDMVEhp4Dv04
 X7FviU4eaHEmdvFw2VJkfJzZd+GzLog0dfDEqnrlTBMAKcDPGzohKr8dcWsrAiuSWUZR33UL+F
 pziGgptnMFqjtIOykkaA/sx+2VKTt9+43x0qLUhaB6cKucspjom+2x56q7r4Fft1zKwZmR/Njn
 qsOwsdE3fccx3F3FRv0C37ikkNN/xTOF2wyGZ8EZXOqiPR0voY9dljp5Oly+0dOwjPemnDVTJy
 niI=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.94])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Aug 2022 04:53:42 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata-core: improve parameter names for ata_dev_set_feature()
Date:   Tue, 16 Aug 2022 13:53:28 +0200
Message-Id: <20220816115329.1252278-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_dev_set_feature() is currently used for enabling/disabling any ATA
feature, e.g. SETFEATURES_SPINUP and SETFEATURE_SENSE_DATA, i.e. it is
not only used to enable/disable SATA specific features.

For most features, the enable/disable bit is specified in the subcommand
specific field "count".
It is only for the specific subcommands "Enable SATA feature" (0x10) and
"Disable SATA feature" (0x90) where the field "count" is used to specify
a feature instead of enable/disable. The parameter names for this
function are thus quite misleading.

Rename the parameter names to be more generic and in line with ACS-5,
and remove the references to "SATA FEATURES" in the kernel-doc.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v1:
-Renamed parameter "count" to "action".

 drivers/ata/libata-core.c | 19 +++++++++----------
 drivers/ata/libata.h      |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d41f341e4..55a403244723 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4324,13 +4324,12 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 }
 
 /**
- *	ata_dev_set_feature - Issue SET FEATURES - SATA FEATURES
+ *	ata_dev_set_feature - Issue SET FEATURES
  *	@dev: Device to which command will be sent
- *	@enable: Whether to enable or disable the feature
- *	@feature: The sector count represents the feature to set
+ *	@subcmd: The SET FEATURES subcommand to be sent
+ *	@action: The sector count represents a subcommand specific action
  *
- *	Issue SET FEATURES - SATA FEATURES command to device @dev
- *	on port @ap with sector count
+ *	Issue SET FEATURES command to device @dev on port @ap with sector count
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
@@ -4338,23 +4337,23 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
  *	RETURNS:
  *	0 on success, AC_ERR_* mask otherwise.
  */
-unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
+unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 action)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 	unsigned int timeout = 0;
 
 	/* set up set-features taskfile */
-	ata_dev_dbg(dev, "set features - SATA features\n");
+	ata_dev_dbg(dev, "set features\n");
 
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_SET_FEATURES;
-	tf.feature = enable;
+	tf.feature = subcmd;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
-	tf.nsect = feature;
+	tf.nsect = action;
 
-	if (enable == SETFEATURES_SPINUP)
+	if (subcmd == SETFEATURES_SPINUP)
 		timeout = ata_probe_timeout ?
 			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 98bc8649c63f..bc84fbb48c0a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -64,7 +64,7 @@ extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
-					u8 enable, u8 feature);
+					u8 subcmd, u8 action);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
2.37.2

