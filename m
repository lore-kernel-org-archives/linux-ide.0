From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] ata: libahci: Allow reconfigure of DEVSLP register
Date: Mon,  2 Jul 2018 12:01:54 -0700
Message-ID: <20180702190154.6864-3-srinivas.pandruvada@linux.intel.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

There are two modes in which DEVSLP can be entered. The OS initiated or
hardware autonomous.

In hardware autonomous mode, BIOS configures the AHCI controller and the
device to enable DEVSLP. But they may not be ideal for all cases. So in
this case, OS should be able to reconfigure DEVSLP register.

Currently if the DEVSLP is already enabled, we can't set again as it will
simply return. There are some systems where the firmware is setting high
DITO by default, in this case we can't modify here to correct settings.
With the default in several seconds, we are not able to transition to
DEVSLP.

This change will allow reconfiguration of devslp register if DITO is
different.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/libahci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index f6795d261869..432ac2f5de34 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2104,7 +2104,7 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ata_device *dev = ap->link.device;
-	u32 devslp, dm, dito, mdat, deto;
+	u32 devslp, dm, dito, mdat, deto, dito_conf;
 	int rc;
 	unsigned int err_mask;
 
@@ -2128,8 +2128,15 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 		return;
 	}
 
-	/* device sleep was already enabled */
-	if (devslp & PORT_DEVSLP_ADSE)
+	dm = (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
+	dito = devslp_idle_timeout / (dm + 1);
+	if (dito > 0x3ff)
+		dito = 0x3ff;
+
+	dito_conf = (devslp >> PORT_DEVSLP_DITO_OFFSET) & 0x3FF;
+
+	/* device sleep was already enabled and same dito */
+	if ((devslp & PORT_DEVSLP_ADSE) && (dito_conf == dito))
 		return;
 
 	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
@@ -2137,11 +2144,6 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 	if (rc)
 		return;
 
-	dm = (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
-	dito = devslp_idle_timeout / (dm + 1);
-	if (dito > 0x3ff)
-		dito = 0x3ff;
-
 	/* Use the nominal value 10 ms if the read MDAT is zero,
 	 * the nominal value of DETO is 20 ms.
 	 */
-- 
2.17.1
