From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] pata_isapnp: Don't use invalid I/O ports
Date: Thu, 12 Sep 2013 23:01:29 +0200
Message-ID: <1379019689-21467-1-git-send-email-linux@rainbow-software.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The test for 2nd I/O port validity is broken (reversed):
On devices with no control port, the driver attempts to use invalid port 0,
resulting in logs full of bad_io_access errors.
On devices with control port, the driver does not use it.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/ata/pata_isapnp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 4bceb88..b33d1f9 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -78,7 +78,7 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 
 	ap->ioaddr.cmd_addr = cmd_addr;
 
-	if (pnp_port_valid(idev, 1) == 0) {
+	if (pnp_port_valid(idev, 1)) {
 		ctl_addr = devm_ioport_map(&idev->dev,
 					   pnp_port_start(idev, 1), 1);
 		ap->ioaddr.altstatus_addr = ctl_addr;
-- 
Ondrej Zary
