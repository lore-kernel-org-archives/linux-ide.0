From: Doug Berger <opendmb@gmail.com>
Subject: [PATCH 2/3] libata: Add the AHCI_HFLAG_NO_WRITE_TO_RO flag
Date: Wed, 21 Jun 2017 16:20:13 -0700
Message-ID: <20170621232014.27790-3-opendmb@gmail.com>
References: <20170621232014.27790-1-opendmb@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170621232014.27790-1-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
List-Id: linux-ide@vger.kernel.org

While most hardware will simply ignore a write to a read-only register,
some hardware will signal an abort if this occurs.

This commit introduces the flag AHCI_HFLAG_NO_WRITE_TO_RO to prevent the
AHCI library from attempting to write to the HOST_CAP, HOST_CAP2, and
HOST_PORTS_IMPL registers which may be read-only.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/ata/ahci.h    | 2 ++
 drivers/ata/libahci.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index ee176e4af97a..8b61123d2c3c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -249,6 +249,8 @@ enum {
 #endif
 	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
 	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
+	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
+							only registers */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4462f8a8cf2c..3e286d86ab42 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -945,7 +945,8 @@ int ahci_reset_controller(struct ata_host *host)
 		/* Some registers might be cleared on reset.  Restore
 		 * initial values.
 		 */
-		ahci_restore_initial_config(host);
+		if (!(hpriv->flags & AHCI_HFLAG_NO_WRITE_TO_RO))
+			ahci_restore_initial_config(host);
 	} else
 		dev_info(host->dev, "skipping global host reset\n");
 
-- 
2.13.0
