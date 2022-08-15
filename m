Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D54C00140
	for <linux-ide@archiver.kernel.org>; Mon, 15 Aug 2022 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiHOORN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiHOORN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Aug 2022 10:17:13 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9801838F
        for <linux-ide@vger.kernel.org>; Mon, 15 Aug 2022 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660573031; x=1692109031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zVwQuOr2RZNJYN/FvhfFga9H8Id63dfgmU3xCqQScZA=;
  b=X3l3BVpJiD/EC4EQf+1x3A0Sz9grsDGqHcMhdsGR3IrtzP+rEqOKdT9g
   ovTFyG4TbgTX7cLpMu4z1UMHJrzBkrBFxK9y1fnmHwfF1BqJk85ySpbYB
   ApG6QBD+7uAAVl+sExue3jPLMZuJiI5I8XSM1xUQKXgqhE+vEQcCIwfEr
   A6HggwICJc2gn5rSp6i9PvVGc9mbNmkRV/BHKAlsuKVlWxpilPSCg/Rb7
   1Ybmc/0h+4m4I8d3DQXhenZgeI8tE13bOQFTGUN1uSh0hK/Xytp7T6Zmj
   enEPJvXE2KBMJW6PsmaJLbBML1Biij56dAJWFhE87YYg3VcD6nekLtpqS
   g==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654531200"; 
   d="scan'208";a="207219403"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2022 22:17:09 +0800
IronPort-SDR: xmbBS48HWs/6YzjwFJTubpfqrk+LernnWZERIJM/v89Eqdr5hFP7QfP7IWEWYkKVKCF7RoV003
 1WsUxPQMcF6ZXQEMQg6aoeiyCJLhMKhttwgWiSReJ4c4BZBeI5CFH/+Vy8zlZCcL+RWcKmGFBf
 xBZpb3ZzttD11aT3R+6B8E35f5963c+8Xw4FBrzMnVXdLLxxdGTDjWvqR2aLXpmfy5nMBxfI//
 trvaccb9Ihjyj9Re+Gr/9kRIpaq/VTOv7j+1AMi/HR51MDWj9zYQ4NUu2Yxwrt4RPbJEOH6RRl
 yHNaVCuU4Gh+vQdb/tF8/tO2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 06:37:58 -0700
IronPort-SDR: ZUl3VRdVDtrh+yphNsEBUD9y2rhnPMlGPPFSgBeL2RM3WqyMpmRADP9vG8zvwF8TCyyPtKeHlL
 /GjIp4Fz4orOXH5PLjNPsa2IxZert04I9L0X/APDlSl/7BIZZVXNRSCJeGxf2ircISYmQ3IU8I
 eDw3DsN7PSrP/MnYxqeBuyBSd982SGJvzSvG4oht9u2hwJbWfdvq/FPPX4J8787vw45jbGolXb
 OgMmv68Wqp67B1azM8mB4ULCn6uT+6KIkzQTBIT0X9KYRfpoImHDjpI+OQ+ASDcLaV2KEazdI8
 eN4=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.94])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2022 07:17:09 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: improve parameter names for ata_dev_set_feature()
Date:   Mon, 15 Aug 2022 16:17:04 +0200
Message-Id: <20220815141704.1178489-1-niklas.cassel@wdc.com>
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
 drivers/ata/libata-core.c | 19 +++++++++----------
 drivers/ata/libata.h      |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d41f341e4..f737d32ceb82 100644
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
+ *	@count: The sector count represents a subcommand specific action
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
+unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 count)
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
+	tf.nsect = count;
 
-	if (enable == SETFEATURES_SPINUP)
+	if (subcmd == SETFEATURES_SPINUP)
 		timeout = ata_probe_timeout ?
 			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 98bc8649c63f..ccc8ba037cb1 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -64,7 +64,7 @@ extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
-					u8 enable, u8 feature);
+					u8 subcmd, u8 count);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
2.37.2

