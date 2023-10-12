Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7EBCDB483
	for <linux-ide@archiver.kernel.org>; Thu, 12 Oct 2023 07:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377564AbjJLHSG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Oct 2023 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJLHSG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Oct 2023 03:18:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C0BD3
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 00:18:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C174DC433CA;
        Thu, 12 Oct 2023 07:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697095084;
        bh=baRw3d7pBpXpDjkPBCduOXDfcK3qJjsGwkU52cvIXkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPLvJrkoSrqLVnLncxC5zSsMzgAKttmckSbf2I9+FXdYon6c3jirdw0H+0fbC/MYI
         7GWX8NIlq/KcqIzruwmMD/Tp8FcOO6VeBexYPUYP4ywpOVKSR+ucGWlI2Snsi0OV0/
         qb3x97sQZkzNVIbyCk820ypEnLyrejvtQqynvhCYIyUIhtwKdkvoWma7BJ8q5frZdr
         6ANbQ/o5AoKTJ6FEn+WmgtFb2JjctDec8GURetqOb6cDFQRAObwFrjPN3iAkVgHtKV
         09SbqXFWj2UqFYZ3i2VPBuDVIiw37Z+sjgpktPb8W/gusjYHhY1N18QtrZ/4jX3D0B
         tpjMqfwu5OAhg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Phillip Susi <phill@thesusis.net>
Subject: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Date:   Thu, 12 Oct 2023 16:18:00 +0900
Message-ID: <20231012071800.468868-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012071800.468868-1-dlemoal@kernel.org>
References: <20231012071800.468868-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Improve the function ata_dev_power_set_active() by having it do nothing
for a disk that is already in the active power state. To do that,
introduce the function ata_dev_power_is_active() to test the current
power state of the disk and return true if the disk is in the PM0:
active or PM1: idle state (0xff value for the count field of the CHECK
POWER MODE command output).

To preserve the existing behavior, if the CHECK POWER MODE command
issued in ata_dev_power_is_active() fails, the drive is assumed to be in
standby mode and false is returned.

With this change, issuing the VERIFY command to access the disk media to
spin it up becomes unnecessary most of the time during system resume as
the port reset done by libata-eh on resume often result in the drive to
spin-up (this behavior is not clearly defined by the ACS specifications
and may thus vary between disk models).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 83613280928b..6fb4e8dc8c3c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2042,6 +2042,33 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 			    err_mask);
 }
 
+static bool ata_dev_power_is_active(struct ata_device *dev)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	ata_tf_init(dev, &tf);
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.command = ATA_CMD_CHK_POWER;
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	if (err_mask) {
+		ata_dev_err(dev, "Check power mode failed (err_mask=0x%x)\n",
+			    err_mask);
+		/*
+		 * Assume we are in standby mode so that we always force a
+		 * spinup in ata_dev_power_set_active().
+		 */
+		return false;
+	}
+
+	ata_dev_dbg(dev, "Power mode: 0x%02x\n", tf.nsect);
+
+	/* Active or idle */
+	return tf.nsect == 0xff;
+}
+
 /**
  *	ata_dev_power_set_active -  Set a device power mode to active
  *	@dev: target device
@@ -2065,6 +2092,13 @@ void ata_dev_power_set_active(struct ata_device *dev)
 	if (!ata_dev_power_init_tf(dev, &tf, true))
 		return;
 
+	/*
+	 * Check the device power state & condition and force a spinup with
+	 * VERIFY command only if the drive is not already ACTIVE or IDLE.
+	 */
+	if (ata_dev_power_is_active(dev))
+		return;
+
 	ata_dev_notice(dev, "Entering active power mode\n");
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
-- 
2.41.0

