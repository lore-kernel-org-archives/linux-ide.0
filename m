Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A565C4332F
	for <linux-ide@archiver.kernel.org>; Thu, 29 Dec 2022 17:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiL2RAl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiL2RAY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Dec 2022 12:00:24 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46647F5A7
        for <linux-ide@vger.kernel.org>; Thu, 29 Dec 2022 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672333224; x=1703869224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hsaTsMQEc4Quqtfoa6xufM51DCwHC3KueqxYtP9uaN8=;
  b=hudrl03S2aND3DH1p/HjBm75sNxakOVkRT5D01BOOhvD6s0qxEXO3Y60
   5BkFZQk8524S/FUaTZX+okzXyzSjyY6PiqURK/aZWovIBf1jF84Ev5Xb+
   UTyS8bkVtYKa/0dKvP+E4bB/tauhKnlN9+GKn1OL7SIqPsoTejdZnM0Zc
   +JeDdYh6RxcD/Mdb94IZudTc9pVdA9mPnLlVeWkbxWU/C0jUA9DYOkv6l
   /Hou9n3ZrjUXVwRRBm1C6fq40shmYYUuNKhFv1/zHsATLANE4b462nSGd
   nizT8KfnnQyvRUT3ueSfIdoTU7g5RGcbpbbslhaLFSxgpcS68TNXSGLXX
   A==;
X-IronPort-AV: E=Sophos;i="5.96,284,1665417600"; 
   d="scan'208";a="323990992"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 01:00:24 +0800
IronPort-SDR: YDdtCWup8kmkzKBhSxJauCDwR0EcvvEo9KPsi2+7felrRCTuH8LURo3mggyIRqc5Vbm6cMAtqZ
 s404/5Z8SGexg2M2RCccPuQ/Z0euPW/wpFKY6/EpaEA7oP86HIty6wZIk/5DX3N5o3ZtLhYSyZ
 ql7cEwln8JRcLn7YxdBTOqUIue8VLUrcTJP1nJnQZImhognh4EQ6q+Z8hK0qIi+HPesTTs2o+v
 iBtNw0fkQZPIUfTqKkuO3Av04+Eo79Xejj5pero5JgvjH+7C5KutBAQ8amU6s6bARJnO8tNptM
 EMg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Dec 2022 08:18:28 -0800
IronPort-SDR: 8Xd/ntRq7eqS1mSQ3nppTFU2ZIUyrPs+7w0h8wArqjFS0IIjw2Yw0OH6da4ZUgSchHwkJ7FOeH
 /C/ZaNZP0wXlp/LGgKelD7zfUBzUwUBz3z/Tlxlxa0r7fCWO0U3dux321BeL5t/pRCJNQQYSCB
 +UXME3wkE4zMdk/CmOFIRbcsz3Z8nhtem0LW4FuLLc3HDnHkOUdxhUoXFAwgP6DylRns4LlA0N
 47kULq7zUKDlAMJZWyKOoTMIdrkL54uTtxfrS7ZRuHB3YExRTfGE/15xWUJxDv7YlodkDx9VUg
 Ryk=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Dec 2022 09:00:24 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH v2 5/7] ata: libata: move NCQ related ATA_DFLAGs
Date:   Thu, 29 Dec 2022 18:00:01 +0100
Message-Id: <20221229170005.49118-6-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229170005.49118-1-niklas.cassel@wdc.com>
References: <20221229170005.49118-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_dev_configure() starts off by clearing all flags in ATA_DFLAG_CFG_MASK:
dev->flags &= ~ATA_DFLAG_CFG_MASK;

ata_dev_configure() then calls ata_dev_config_lba() which calls
ata_dev_config_ncq().

ata_dev_config_ncq() will set the correct ATA_DFLAGs depending on what is
actually supported.

Since these flags are set by ata_dev_configure(), they should be in
ATA_DFLAG_CFG_MASK and not in ATA_DFLAG_INIT_MASK.

ATA_DFLAG_NCQ_PRIO_ENABLED is set via sysfs, is should therefore not be in
ATA_DFLAG_CFG_MASK. It also cannot be in ATA_DFLAG_INIT_MASK, because
ata_eh_schedule_probe() calls ata_dev_init(), which will clear all flags in
ATA_DFLAG_INIT_MASK.

This means that ATA_DFLAG_NCQ_PRIO_ENABLED (the value the user sets via
sysfs) would get silently cleared if ata_eh_schedule_probe() is called.
While that should only happen in certain circumstances, it still doesn't
seem right that it can get silently cleared.

(ata_dev_config_ncq_prio() will still clear the ATA_DFLAG_NCQ_PRIO_ENABLED
flag if ATA_DFLAG_NCQ_PRIO is suddenly no longer supported after a
revalidation.)

Because of this, move ATA_DFLAG_NCQ_PRIO_ENABLED to be outside of both
ATA_DFLAG_CFG_MASK and ATA_DFLAG_INIT_MASK.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/libata.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index f54e02dadc6f..3b7f5d9e2f87 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -91,22 +91,21 @@ enum {
 	ATA_DFLAG_AN		= (1 << 7), /* AN configured */
 	ATA_DFLAG_TRUSTED	= (1 << 8), /* device supports trusted send/recv */
 	ATA_DFLAG_DMADIR	= (1 << 10), /* device requires DMADIR */
-	ATA_DFLAG_CFG_MASK	= (1 << 12) - 1,
+	ATA_DFLAG_NCQ_SEND_RECV = (1 << 11), /* device supports NCQ SEND and RECV */
+	ATA_DFLAG_NCQ_PRIO	= (1 << 12), /* device supports NCQ priority */
+	ATA_DFLAG_CFG_MASK	= (1 << 13) - 1,
 
-	ATA_DFLAG_PIO		= (1 << 12), /* device limited to PIO mode */
-	ATA_DFLAG_NCQ_OFF	= (1 << 13), /* device limited to non-NCQ mode */
+	ATA_DFLAG_PIO		= (1 << 13), /* device limited to PIO mode */
+	ATA_DFLAG_NCQ_OFF	= (1 << 14), /* device limited to non-NCQ mode */
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_NO_UNLOAD	= (1 << 17), /* device doesn't support unload */
 	ATA_DFLAG_UNLOCK_HPA	= (1 << 18), /* unlock HPA */
-	ATA_DFLAG_NCQ_SEND_RECV = (1 << 19), /* device supports NCQ SEND and RECV */
-	ATA_DFLAG_NCQ_PRIO	= (1 << 20), /* device supports NCQ priority */
-	ATA_DFLAG_NCQ_PRIO_ENABLED = (1 << 21), /* Priority cmds sent to dev */
-	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
+	ATA_DFLAG_INIT_MASK	= (1 << 19) - 1,
 
+	ATA_DFLAG_NCQ_PRIO_ENABLED = (1 << 19), /* Priority cmds sent to dev */
 	ATA_DFLAG_DETACH	= (1 << 24),
 	ATA_DFLAG_DETACHED	= (1 << 25),
-
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
 	ATA_DFLAG_DEVSLP	= (1 << 27), /* device supports Device Sleep */
 	ATA_DFLAG_ACPI_DISABLED = (1 << 28), /* ACPI for the device is disabled */
-- 
2.38.1

