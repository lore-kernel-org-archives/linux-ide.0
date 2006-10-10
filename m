From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: add hp-poll support to controllers with hotplug interrutps
Date: Tue, 10 Oct 2006 14:36:13 +0900
Message-ID: <11604585733529-git-send-email-htejun@gmail.com>
References: <116045857221-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:3425 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964992AbWJJFgU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Oct 2006 01:36:20 -0400
Received: by py-out-1112.google.com with SMTP id n25so2655674pyg
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 22:36:19 -0700 (PDT)
In-Reply-To: <116045857221-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch adds hp-poll support to the following drivers.

* ahci
* sata_nv (nf2 and c804 only)
* sata_sil
* sata_sil24

All the above controllers are capable of hotplug-by-interrupt and
hp-poll will be used only for watching disabled ports.
---
 drivers/ata/ahci.c       |    4 +++-
 drivers/ata/sata_nv.c    |    4 ++++
 drivers/ata/sata_sil.c   |    2 ++
 drivers/ata/sata_sil24.c |    3 +++
 4 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2592912..d95d99b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -262,10 +262,12 @@ static const struct ata_port_operations 
 
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
-
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 323b607..a75d5cc 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -200,6 +200,8 @@ static const struct ata_port_operations 
 	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_nf2_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -227,6 +229,8 @@ static const struct ata_port_operations 
 	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_ck804_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index ae5edb8..43553db 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -205,6 +205,8 @@ static const struct ata_port_operations 
 	.thaw			= sil_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 169e200..c84efc3 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -410,6 +410,9 @@ static const struct ata_port_operations 
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.port_start		= sil24_port_start,
 	.port_stop		= sil24_port_stop,
 	.host_stop		= sil24_host_stop,
-- 
1.4.2.3


