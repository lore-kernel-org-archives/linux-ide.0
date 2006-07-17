From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: add hp-poll support to controllers with hotplug interrutps
Date: Mon, 17 Jul 2006 16:00:49 +0900
Message-ID: <11531196491485-git-send-email-htejun@gmail.com>
References: <11531196483920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:25207 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932356AbWGQG7b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:59:31 -0400
Received: by py-out-1112.google.com with SMTP id x31so3890187pye
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:59:30 -0700 (PDT)
In-Reply-To: <11531196483920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
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

 drivers/scsi/ahci.c       |    3 +++
 drivers/scsi/sata_nv.c    |    4 ++++
 drivers/scsi/sata_sil.c   |    2 ++
 drivers/scsi/sata_sil24.c |    3 +++
 4 files changed, 12 insertions(+), 0 deletions(-)

a7fe2cefdb1abfed43df9e12c3f05d885638b07b
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index b5fe19a..9fc2e57 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -261,6 +261,9 @@ static const struct ata_port_operations 
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.set_powersave		= ahci_set_powersave,
 
 	.port_start		= ahci_port_start,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 56da255..cdf3b65 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -216,6 +216,8 @@ static const struct ata_port_operations 
 	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_nf2_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -243,6 +245,8 @@ static const struct ata_port_operations 
 	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_ck804_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index d0a8507..62deca4 100644
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
index 0b5c3f1..0c1f082 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -407,6 +407,9 @@ static const struct ata_port_operations 
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.set_powersave		= sil24_set_powersave,
 
 	.port_start		= sil24_port_start,
-- 
1.3.2


