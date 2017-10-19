From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH 2/2] Allow error handler to change speed only if link is online.
Date: Thu, 19 Oct 2017 13:30:36 -0500
Message-ID: <1508437836-31649-3-git-send-email-dmilburn@redhat.com>
References: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752519AbdJSSai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 19 Oct 2017 14:30:38 -0400
In-Reply-To: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

This patch prevents the error handler from changing link->sata_spd unless the
link is online. 

(debug output)

[   79.658098] ATA_EH_RESET: sstatus 0x0 link->sata_spd 0x0 
[   79.658104] SATA_PRINT_LINK_STATUS: sstatus 0x0 scontrol 0x300
[   79.658109] ata4: SATA link down (SStatus 0 SControl 300)
[   79.658113] ATA_PHYS_LINK_OFFLINE: sata_scr_read sstatus 0x0
[   79.658117] ATA_PHYS_LINK_OFFLINE: sata_scr_read sstatus 0x0
[   79.658128] SATA_DOWN_SPD_LIMIT: sstatus 0x0
[   79.658130] SATA_DOWN_SPD_LIMIT: spd 0x0 mask 0xffffffff
[   79.658132] SATA_DOWN_SPD_LIMIT: bit 31 mask 0x7fffffff
[   79.658134] SATA_DOWN_SPD_LIMIT: spd 0x0 mask 0x1
[   79.658137] ata4: limiting SATA link speed to 1.5 Gbps

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata-eh.c   | 6 ++++--
 drivers/ata/libata.h      | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 38c40cf..57c7e56 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -177,7 +177,7 @@ struct ata_force_ent {
 MODULE_VERSION(DRV_VERSION);
 
 
-static bool ata_sstatus_online(u32 sstatus)
+bool ata_sstatus_online(u32 sstatus)
 {
 	return (sstatus & 0xf) == 0x3;
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e4effef..d469951 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2911,9 +2911,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	}
 
 	/* record current link speed */
-	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0)
+	if (!sata_scr_read(link, SCR_STATUS, &sstatus) && 
+	    ata_sstatus_online(sstatus))
 		link->sata_spd = (sstatus >> 4) & 0xf;
-	if (slave && sata_scr_read(slave, SCR_STATUS, &sstatus) == 0)
+	if (slave && !sata_scr_read(slave, SCR_STATUS, &sstatus) &&
+	    ata_sstatus_online(sstatus))
 		slave->sata_spd = (sstatus >> 4) & 0xf;
 
 	/* thaw the port */
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 839d487..7787fcc 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -52,6 +52,7 @@ enum {
 extern int libata_noacpi;
 extern int libata_allow_tpm;
 extern struct device_type ata_port_type;
+extern bool ata_sstatus_online(u32 sstatus);
 extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
 extern void ata_force_cbl(struct ata_port *ap);
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
-- 
1.8.3.1

