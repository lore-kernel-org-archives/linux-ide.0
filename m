Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3B154AC;
	Thu, 11 Jan 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbixFO9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEED8C43394;
	Thu, 11 Jan 2024 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704973888;
	bh=eur3+uCQkJRvTvIYjNHVxvd9Ld4JIv8SwItCymE3X/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PbixFO9RV/zxZ/W2yzPs+G/WKIbFVnCtZnCDJRbbbUsBuiWR5WLMUM1IgwjUDQQsu
	 se3sSmCHa1YhBq2XFujRvstXdbVxbxzRK+MBXqpXvQ9h/kuVdlG9AJodky8XRg7Ber
	 aUDChDsu91yUwJL4SgH6WvvJ7rMy4nlwNYPLwS6u7YSHMPbY+x6FHMB6euaU4sxYjA
	 BoeOiEZA/LHgA58tiairsMMxpNzshEPBIzqmaucVu1XMz7UQ0gajZ/yhqb2dRDFD6e
	 pep2W0rY9dY3flP0R/Yb3thpZEVtvEv9H7bIRfmFJUwA3dCMbwGxoDsMxB77/GBIo7
	 e7x9SnTIC+uzQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>,
	Wang Zhihao <wangzhihao9@hotmail.com>,
	linux-regressions <regressions@lists.linux.dev>
Subject: [PATCH 2/2] ata: libata-core: Revert "ata: libata-core: Fix ata_pci_shutdown_one()"
Date: Thu, 11 Jan 2024 20:51:23 +0900
Message-ID: <20240111115123.1258422-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111115123.1258422-1-dlemoal@kernel.org>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit fd3a6837d8e18cb7be80dcca1283276290336a7a.

Several users have signaled issues with commit fd3a6837d8e1 ("ata:
libata-core: Fix ata_pci_shutdown_one()") which causes failure of the
system SoC to go to a low power state. The reason for this problem
is not well understood but given that this patch is harmless with the
improvements to ata_dev_power_set_standby(), restore it to allow system
lower power state transitions.

For regular system shutdown, ata_dev_power_set_standby() will be
executed twice: once the scsi device is removed and another when
ata_pci_shutdown_one() executes and EH completes unloading the devices.
Make the second call to ata_dev_power_set_standby() do nothing by using
ata_dev_power_is_active() and return if the device is already in
standby.

Fixes: fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 75 +++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d9f80f4f70f5..20a366942626 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2001,6 +2001,33 @@ bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
 	return true;
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
  *	ata_dev_power_set_standby - Set a device power mode to standby
  *	@dev: target device
@@ -2017,8 +2044,9 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
-	/* If the device is already sleeping, do nothing. */
-	if (dev->flags & ATA_DFLAG_SLEEPING)
+	/* If the device is already sleeping or in standby, do nothing. */
+	if ((dev->flags & ATA_DFLAG_SLEEPING) ||
+	    !ata_dev_power_is_active(dev))
 		return;
 
 	/*
@@ -2046,33 +2074,6 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 			    err_mask);
 }
 
-static bool ata_dev_power_is_active(struct ata_device *dev)
-{
-	struct ata_taskfile tf;
-	unsigned int err_mask;
-
-	ata_tf_init(dev, &tf);
-	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
-	tf.protocol = ATA_PROT_NODATA;
-	tf.command = ATA_CMD_CHK_POWER;
-
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
-	if (err_mask) {
-		ata_dev_err(dev, "Check power mode failed (err_mask=0x%x)\n",
-			    err_mask);
-		/*
-		 * Assume we are in standby mode so that we always force a
-		 * spinup in ata_dev_power_set_active().
-		 */
-		return false;
-	}
-
-	ata_dev_dbg(dev, "Power mode: 0x%02x\n", tf.nsect);
-
-	/* Active or idle */
-	return tf.nsect == 0xff;
-}
-
 /**
  *	ata_dev_power_set_active -  Set a device power mode to active
  *	@dev: target device
@@ -6184,10 +6185,24 @@ EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 void ata_pci_shutdown_one(struct pci_dev *pdev)
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_port *ap;
+	unsigned long flags;
 	int i;
 
+	/* Tell EH to disable all devices */
 	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
+		ap = host->ports[i];
+		spin_lock_irqsave(ap->lock, flags);
+		ap->pflags |= ATA_PFLAG_UNLOADING;
+		ata_port_schedule_eh(ap);
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	for (i = 0; i < host->n_ports; i++) {
+		ap = host->ports[i];
+
+		/* Wait for EH to complete before freezing the port */
+		ata_port_wait_eh(ap);
 
 		ap->pflags |= ATA_PFLAG_FROZEN;
 
-- 
2.43.0

