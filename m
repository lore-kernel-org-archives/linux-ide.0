From: Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ata: ahci: fix race between EH and ahci interrupt
Date: Tue, 2 Apr 2019 20:06:42 +0800
Message-ID: <20190402120642.9274-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
List-Id: linux-ide@vger.kernel.org

There is a race condition between EH and ahci interrupt when the EH is
interrupted after the ata port is thaw by the ahci interrupt. In the
ahci interrupt callback the port will be frozen again but the EH thread
will not be scheduled because it is already running.

[interrupt]                             [scsi_eh]
ahci_error_intr                         scsi_error_handler
  =>ata_port_freeze
  =>ahci_freeze (turn IRQ off)
  =>ata_port_abort
    =>ata_port_schedule_eh
      =>host_eh_scheduled++;
	host_eh_scheduled = 1
    =>scsi_eh_wakeup
					 =>ata_scsi_error
					 =>ata_eh_thaw_port
					   =>ahci_thaw (turn IRQ on)
ahci_error_intr
  =>ata_port_freeze
  =>ahci_freeze (turn IRQ off)
  =>ata_port_abort
    =>ata_port_schedule_eh
      =>host_eh_scheduled++;
	host_eh_scheduled = 2
      =>EH already running
					 =>ata_std_end_eh
					   =>host_eh_scheduled = 0;
					 =>EH over, IRQ remain off

The host_eh_scheduled is 0 and scsi EH thread will not be scheduled again,
and the ata port remain freeze and will never be enabled. If EH thread is
already running, no need to freeze port and schedule EH again.

Reported-by: luojian <luojian5@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/ata/libahci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 692782dddc0f..cba0f5dcb36f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1805,9 +1805,15 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 	/* okay, let's hand over to EH */
 
-	if (irq_stat & PORT_IRQ_FREEZE)
+	if (irq_stat & PORT_IRQ_FREEZE) {
+		/*
+		 * EH already running, this may happen if the port is thawed in the EH.
+		 * But we cannot freeze it again otherwise the port will never be thawed.
+		 */
+		if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
+			return;
 		ata_port_freeze(ap);
-	else if (fbs_need_dec) {
+	} else if (fbs_need_dec) {
 		ata_link_abort(link);
 		ahci_fbs_dec_intr(ap);
 	} else
-- 
2.17.2
