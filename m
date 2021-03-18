Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE6C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A5E64F45
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 12:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhCRMgI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:36:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14090 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCRMgG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 08:36:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1RKW4Z1cz19GFr;
        Thu, 18 Mar 2021 20:34:07 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 20:35:55 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <yanaijie@huawei.com>, <wubo40@huawei.com>
Subject: [RFC PATCH] ata: add lun validity check on ata_sas_queuecmd
Date:   Thu, 18 Mar 2021 20:53:53 +0800
Message-ID: <1616072033-287811-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

After executing rescan-scsi-bus.sh -r -m, the system adds 255 more disks.

The reason is as follows:
1. Execute the rescan-scsi-bus.sh script to scan all targets.
2. The REPORT_LUNS failed due to some errors on the device of sdb(LUN0).
3. Do a sequential scan on the target which sdb belongs to.
4. Have already scanned LUN 0, so start at LUN 1. and keep scanning until
   reach the max.
5. For SATA device, the driver of ata does not check the validity of 
   LUN ID before dispatch commands to ATA device. 
   Result in LUN 1~MAX successfully added to the system.

trace:
__scsi_scan_target()
   -> scsi_report_lun_scan()
   -> scsi_sequential_lun_scan()
	
Steps to reproduce as follow:

step1: lsscsi
[1:0:0:0]    disk    ATA      /dev/sda 
[1:0:1:0]    disk    ATA      /dev/sdb 
[1:0:2:0]    disk    ATA      /dev/sdc 
[1:0:3:0]    disk    ATA      /dev/sdd 
[1:0:4:0]    disk    ATA      /dev/sde

step2: echo "offline" > /sys/block/sdb/device/state
step3: rescan-scsi-bus.sh -r -m
step4: lsscsi
[1:0:0:0]    disk    ATA      /dev/sda 
[1:0:1:1]    disk    ATA      /dev/sdr 
[1:0:1:2]    disk    ATA      /dev/sds 
[1:0:1:3]    disk    ATA      /dev/sdt 
[1:0:1:4]    disk    ATA      /dev/sdu 
......
[1:0:1:251]  disk    ATA      /dev/sdjh
[1:0:1:252]  disk    ATA      /dev/sdji
[1:0:1:253]  disk    ATA      /dev/sdjj
[1:0:1:254]  disk    ATA      /dev/sdjk
[1:0:1:255]  disk    ATA      /dev/sdjl
[1:0:2:0]    disk    ATA      /dev/sdc 
[1:0:3:0]    disk    ATA      /dev/sdd 
[1:0:4:0]    disk    ATA      /dev/sde 

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/ata/libata-sata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index c16423e..e30a412 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1242,7 +1242,8 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 
 	ata_scsi_dump_cdb(ap, cmd);
 
-	if (likely(ata_dev_enabled(ap->link.device)))
+	if (likely(ata_dev_enabled(ap->link.device)) &&
+	    (cmd->device->lun == 0))
 		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
-- 
1.8.3.1

