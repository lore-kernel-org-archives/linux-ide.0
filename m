Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4C22315
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587935; cv=none; b=UEC8YtDfDqKuPa2Ix4XEcBSbG8L3Ww0eKmtNTvKCg/2R+OHKvnOSWXNw+bjsh9b143d3g+tHZQUD5/poF+xIcEa5kIWhMvtDHoHzVJ6b8f0AOEip1Y54sXQINIe6LjVIvJy+v4/wLSamoapwsXd00bKPCVTSKtpZ/soiZCD61cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587935; c=relaxed/simple;
	bh=5VMtOXYvqs0xMBrQib+FoTg+bQBjpv7hI4VtNuaShAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqiG40bUvecoKMhozglPDaBC3trjGyJ2IOpZsAW6Dg9WoQNVsiDHA20cM0AdGZQzG/Joj+UpXNktHGeuFXdk58HcXvsc54Gf+GY7av0Kl6zfUKvMWwluE5NpE93MCd7+2KnXfgtZLkaceV967mWi6vCh0JsE6jEVEXZAa2Tycvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrYbmnnW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrYbmnnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C79C4CEC3;
	Fri,  6 Sep 2024 01:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725587934;
	bh=5VMtOXYvqs0xMBrQib+FoTg+bQBjpv7hI4VtNuaShAk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FrYbmnnW9ISKO3jYgWxfo57hfuq7keE2cmUzRTP+sUPmNgrEZ4Jz34nxKK3tm6QSE
	 PkdOlZFcWfK9OzjNMs3BtFgDEWNRN0pIeLEDE/hK8bbf2dyyM3YD1g8kuXGruabQWL
	 9Sz7T2CKmjYV9ITjBPsYWGqjNloysYfeq4oEtkex1B/csROUvnoFfSjCpYds0P/xk5
	 SIBJOGlP7eZlpxf19QPo1IrbobXxp8Fd2vifzCKfOlvIWPcJBz09M/i6VA4GSaA4dK
	 rhV9tIRC89JFTe09ZDpgbe71ndjv72Z9PrUuXRPEo+szifnyleArBoK1yDdWVcXhS7
	 /ezjLaeK3DRlw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 8/9] ata: libata: Introduce ata_dev_free_resources
Date: Fri,  6 Sep 2024 10:58:46 +0900
Message-ID: <20240906015847.229539-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906015847.229539-1-dlemoal@kernel.org>
References: <20240906015847.229539-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function ata_dev_free_resources() to free the resources
allocated to support a device features. For now, this function is
reduced to calling zpodd_exit() for devices that have this feature
enabled.

ata_dev_free_resources() is called from ata_eh_dev_disable() as this
function is always called for all devices attached to a port that is
being detached and for devices that are being disabled due to being
removed (detached) from the system or due to errors.

With this change, the call to zpodd_exit() done in ata_port_detach() is
removed as that function starts by removing all devices attached to the
port using libata EH, thus resulting in ata_eh_dev_disable() being
called and the zpodd_exit() function being executed.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 27 +++++++++++++++++++--------
 drivers/ata/libata-eh.c   |  5 ++++-
 drivers/ata/libata-scsi.c |  3 ---
 drivers/ata/libata.h      |  1 +
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 32325a1c07af..bfd452b0d46d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5976,6 +5976,21 @@ int ata_host_activate(struct ata_host *host, int irq,
 }
 EXPORT_SYMBOL_GPL(ata_host_activate);
 
+/**
+ *	ata_dev_free_resources - Free a device resources
+ *	@dev: Target ATA device
+ *
+ *	Free resources allocated to support a device features.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_dev_free_resources(struct ata_device *dev)
+{
+	if (zpodd_dev_enabled(dev))
+		zpodd_exit(dev);
+}
+
 /**
  *	ata_port_detach - Detach ATA port in preparation of device removal
  *	@ap: ATA port to be detached
@@ -6030,19 +6045,15 @@ static void ata_port_detach(struct ata_port *ap)
 	cancel_delayed_work_sync(&ap->hotplug_task);
 	cancel_delayed_work_sync(&ap->scsi_rescan_task);
 
-	/* clean up zpodd on port removal */
-	ata_for_each_link(link, ap, HOST_FIRST) {
-		ata_for_each_dev(dev, link, ALL) {
-			if (zpodd_dev_enabled(dev))
-				zpodd_exit(dev);
-		}
-	}
+	/* Delete port multiplier link transport devices */
 	if (ap->pmp_link) {
 		int i;
+
 		for (i = 0; i < SATA_PMP_MAX_PORTS; i++)
 			ata_tlink_delete(&ap->pmp_link[i]);
 	}
-	/* remove the associated SCSI host */
+
+	/* Remove the associated SCSI host */
 	scsi_remove_host(ap->scsi_host);
 	ata_tport_delete(ap);
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ed535e1b4225..364828b8a22d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -500,10 +500,13 @@ static void ata_eh_dev_disable(struct ata_device *dev)
 	ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 | ATA_DNXFER_QUIET);
 	dev->class++;
 
-	/* From now till the next successful probe, ering is used to
+	/*
+	 * From now till the next successful probe, ering is used to
 	 * track probe failures.  Clear accumulated device error info.
 	 */
 	ata_ering_clear(&dev->ering);
+
+	ata_dev_free_resources(dev);
 }
 
 static void ata_eh_unload(struct ata_port *ap)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1a135d44286c..a42726910fb8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4625,9 +4625,6 @@ static void ata_scsi_handle_link_detach(struct ata_link *link)
 		dev->flags &= ~ATA_DFLAG_DETACHED;
 		spin_unlock_irqrestore(ap->lock, flags);
 
-		if (zpodd_dev_enabled(dev))
-			zpodd_exit(dev);
-
 		ata_scsi_remove_dev(dev);
 	}
 }
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 2a9d1bbf2482..927d77bde7ef 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -71,6 +71,7 @@ extern bool ata_dev_power_init_tf(struct ata_device *dev,
 				  struct ata_taskfile *tf, bool set_active);
 extern void ata_dev_power_set_standby(struct ata_device *dev);
 extern void ata_dev_power_set_active(struct ata_device *dev);
+void ata_dev_free_resources(struct ata_device *dev);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 subcmd, u8 action);
-- 
2.46.0

