From: Doug Berger <opendmb@gmail.com>
Subject: [PATCH 1/3] libata: Add the AHCI_HFLAG_YES_ALPM flag
Date: Wed, 21 Jun 2017 16:20:12 -0700
Message-ID: <20170621232014.27790-2-opendmb@gmail.com>
References: <20170621232014.27790-1-opendmb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34998 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdFUXUi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2017 19:20:38 -0400
In-Reply-To: <20170621232014.27790-1-opendmb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>

Some hardware is capable of supporting Aggresive Link Power Management
even though it is not indicated by the Host Capability register.

This commit adds the AHCI_HFLAG_YES_ALPM flag to the AHCI library to
allow indication of this quirk when the Host Capability register is
Read Only and therefore cannot be changed.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/ata/ahci.h    | 1 +
 drivers/ata/libahci.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 30f67a1a4f54..ee176e4af97a 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -248,6 +248,7 @@ enum {
 	AHCI_HFLAG_MULTI_MSI		= 0,
 #endif
 	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index b3a685ad9b87..4462f8a8cf2c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -504,6 +504,11 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		cap &= ~HOST_CAP_FBS;
 	}
 
+	if (!(cap & HOST_CAP_ALPM) && (hpriv->flags & AHCI_HFLAG_YES_ALPM)) {
+		dev_info(dev, "controller can do ALPM, turning on CAP_ALPM\n");
+		cap |= HOST_CAP_ALPM;
+	}
+
 	if (hpriv->force_port_map && port_map != hpriv->force_port_map) {
 		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
 			 port_map, hpriv->force_port_map);
-- 
2.13.0

