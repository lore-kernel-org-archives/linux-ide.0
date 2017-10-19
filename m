From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH 1/2] libata: initialize link speed from sstatus if online.
Date: Thu, 19 Oct 2017 13:30:35 -0500
Message-ID: <1508437836-31649-2-git-send-email-dmilburn@redhat.com>
References: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752713AbdJSSai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 19 Oct 2017 14:30:38 -0400
In-Reply-To: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

If not, a 6Gbps link may be limited to 1.5 Gbps instead of 3.0 Gbps, since
ata_dev_init initializes link->sata_spd to 0.

[  938.387795] ata4: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
[  938.387803] ata4: irq_stat 0x00400040, connection status changed
[  938.387807] ata4: SError: { HostInt PHYRdyChg 10B8B DevExch }
[  938.387814] ata4: hard resetting link
[  939.108967] ata4: SATA link down (SStatus 0 SControl 300)
[  944.100701] ata4: hard resetting link
[  944.404187] ata4: SATA link down (SStatus 0 SControl 300)
[  944.404198] ata4: limiting SATA link speed to 1.5 Gbps
[  949.394013] ata4: hard resetting link
[  949.697465] ata4: SATA link down (SStatus 0 SControl 310)
[  949.697476] ata4.00: disabled
[  949.697490] ata4: EH complete
[  949.697503] ata4.00: detaching (SCSI 3:0:0:0)

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ee4c1ec..38c40cf 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3002,16 +3002,16 @@ int ata_bus_probe(struct ata_port *ap)
  */
 static void sata_print_link_status(struct ata_link *link)
 {
-	u32 sstatus, scontrol, tmp;
+	u32 sstatus, scontrol;
 
 	if (sata_scr_read(link, SCR_STATUS, &sstatus))
 		return;
 	sata_scr_read(link, SCR_CONTROL, &scontrol);
 
 	if (ata_phys_link_online(link)) {
-		tmp = (sstatus >> 4) & 0xf;
+		link->sata_spd = (sstatus >> 4) & 0xf;
 		ata_link_info(link, "SATA link up %s (SStatus %X SControl %X)\n",
-			      sata_spd_string(tmp), sstatus, scontrol);
+			      sata_spd_string(link->sata_spd), sstatus, scontrol);
 	} else {
 		ata_link_info(link, "SATA link down (SStatus %X SControl %X)\n",
 			      sstatus, scontrol);
-- 
1.8.3.1

