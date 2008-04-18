From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] [v2] libata-core: set debug logging via module param
Date: Fri, 18 Apr 2008 10:52:59 -0500
Message-ID: <20080418155259.GA7429@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54584 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYDRPyM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 11:54:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Set debug level using ata_logging_level module parameter.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 libata-core.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 733eb94..c87f7bd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -158,6 +158,10 @@ int libata_allow_tpm = 0;
 module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
 MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands");
 
+unsigned int ata_logging_level = ATA_MSG_DRV|ATA_MSG_ERR|ATA_MSG_WARN;
+module_param(ata_logging_level, int, 0444);
+MODULE_PARM_DESC(ata_logging_level, "Bit mask of logging levels");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -5190,14 +5194,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->dev = host->dev;
 	ap->last_ctl = 0xFF;
 
-#if defined(ATA_VERBOSE_DEBUG)
-	/* turn on all debugging levels */
-	ap->msg_enable = 0x00FF;
-#elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
-#else
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
-#endif
+	/* set debugging level */
+	ap->msg_enable = ata_logging_level;
 
 #ifdef CONFIG_ATA_SFF
 	INIT_DELAYED_WORK(&ap->port_task, ata_pio_task);
