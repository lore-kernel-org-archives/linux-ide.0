From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] ata: disable port while unloading ATA controller driver
Date: Mon, 28 Nov 2016 01:18:56 +0200
Message-ID: <20161127231856.11466-1-vz@mleia.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50908 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbcK0XTm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 27 Nov 2016 18:19:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

While removing ATA controller driver ata_port_detach() sets
ATA_PFLAG_UNLOADING flag and charges the error handler, however actual
port disabling does not happen due to unset ATA_PFLAG_EH_PENDING flag.

To take care about clean port removal and ATA_PFLAG_EH_PENDING flag
setting it is sufficient to replace ata_port_schedule_eh() call with
ata_port_freeze().

The problem is reported by an assertion in ata_port_detach(),
if a controller driver is unloaded manually or on boot with
DEBUG_TEST_DRIVER_REMOVE option enabled:

  # rmmod ahci_imx
  WARNING: CPU: 2 PID: 379 at drivers/ata/libata-core.c:6484 ata_port_detach+0x11c/0x12c
  Modules linked in: ahci_imx(-) i2c_imx
  CPU: 2 PID: 379 Comm: rmmod Not tainted 4.9.0-rc6+ #66
  Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  Backtrace:
  [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
  [<>] (show_stack) from [<>] (dump_stack+0xb4/0xe8)
  [<>] (dump_stack) from [<>] (__warn+0xd8/0x104)
  [<>] (__warn) from [<>] (warn_slowpath_null+0x28/0x30)
  [<>] (warn_slowpath_null) from [<>] (ata_port_detach+0x11c/0x12c)
  [<>] (ata_port_detach) from [<>] (ata_platform_remove_one+0x2c/0x44)
  [<>] (ata_platform_remove_one) from [<>] (platform_drv_remove+0x2c/0x44)
  [<>] (platform_drv_remove) from [<>] (__device_release_driver+0x90/0x12c)
  [<>] (__device_release_driver) from [<>] (driver_detach+0xc0/0xc4)
  [<>] (driver_detach) from [<>] (bus_remove_driver+0x64/0xdc)
  [<>] (bus_remove_driver) from [<>] (driver_unregister+0x30/0x50)
  [<>] (driver_unregister) from [<>] (platform_driver_unregister+0x14/0x18)
  [<>] (platform_driver_unregister) from [<>] (imx_ahci_driver_exit+0x14/0x1c [ahci_imx])
  [<>] (imx_ahci_driver_exit [ahci_imx]) from [<>] (SyS_delete_module+0x140/0x1f4)
  [<>] (SyS_delete_module) from [<>] (ret_fast_syscall+0x0/0x1c)

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 43842fd..6d64fe3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6505,7 +6505,7 @@ static void ata_port_detach(struct ata_port *ap)
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_UNLOADING;
-	ata_port_schedule_eh(ap);
+	ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	/* wait till EH commits suicide */
-- 
2.10.2

