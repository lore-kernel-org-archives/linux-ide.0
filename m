From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: add hp-poll support to controllers with hotplug interrutps
Date: Tue, 4 Jul 2006 23:16:17 +0900
Message-ID: <11520225772128-git-send-email-htejun@gmail.com>
References: <11520225771424-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:20829 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932256AbWGDOPl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 10:15:41 -0400
Received: by py-out-1112.google.com with SMTP id t32so1859047pyc
        for <linux-ide@vger.kernel.org>; Tue, 04 Jul 2006 07:15:40 -0700 (PDT)
In-Reply-To: <11520225771424-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch adds hp-poll support to the following drivers.

* ahci
* sata_nv (nf2 and c804 only)
* sata_sil
* sata_sil24

All the above controllers are capable of hotplug-by-interrupt and
hp-poll will be used only for watching disabled ports.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c       |    4 +++-
 drivers/scsi/sata_nv.c    |    4 ++++
 drivers/scsi/sata_sil.c   |    2 ++
 drivers/scsi/sata_sil24.c |    3 +++
 4 files changed, 12 insertions(+), 1 deletions(-)

15decf1370fe778e6df39cb8944cf5568e46b5b5
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 54f01b2..a404ec0 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -253,10 +253,12 @@ static const struct ata_port_operations 
 
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
-
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
 };
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 5cc42c6..79b0550 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -217,6 +217,8 @@ static const struct ata_port_operations 
 	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_nf2_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -244,6 +246,8 @@ static const struct ata_port_operations 
 	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_ck804_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 9f2a48a..01abe09 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -205,6 +205,8 @@ static const struct ata_port_operations 
 	.thaw			= sil_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index b8e590d..0904088 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -405,6 +405,9 @@ static const struct ata_port_operations 
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.port_start		= sil24_port_start,
 	.port_stop		= sil24_port_stop,
 	.host_stop		= sil24_host_stop,
-- 
1.3.2


