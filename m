From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/13] libata: export ata_set_sata_spd()
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <11443978131307-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:62430 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932372AbWDGIQ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:16:59 -0400
Received: by wproxy.gmail.com with SMTP id 58so295241wri
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:16:58 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

This will be used by LLDD hardreset implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 ++-
 include/linux/libata.h     |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

850540dc36ec347cca6604f668804fc81b537660
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 56e1cc6..3668845 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1736,7 +1736,7 @@ int ata_set_sata_spd_needed(struct ata_p
  *	0 if spd doesn't need to be changed, 1 if spd has been
  *	changed.  -EOPNOTSUPP if SCR registers are inaccessible.
  */
-static int ata_set_sata_spd(struct ata_port *ap)
+int ata_set_sata_spd(struct ata_port *ap)
 {
 	u32 scontrol;
 
@@ -5111,6 +5111,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 EXPORT_SYMBOL_GPL(ata_port_probe);
+EXPORT_SYMBOL_GPL(ata_set_sata_spd);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bf2f334..1c75024 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -503,6 +503,7 @@ extern void ata_port_probe(struct ata_po
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
+extern int ata_set_sata_spd(struct ata_port *ap);
 extern int ata_drive_probe_reset(struct ata_port *ap,
 			ata_probeinit_fn_t probeinit,
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-- 
1.2.4


