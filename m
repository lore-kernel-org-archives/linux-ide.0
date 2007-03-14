From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] Add ledtrig_ide_activity () to libata
Date: Wed, 14 Mar 2007 13:11:59 +0900
Message-ID: <20070314131159.e402363e.iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from l247104.ppp.asahi-net.or.jp ([218.219.247.104]:54561 "EHLO
	ns.nigauri.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933820AbXCNEmc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 00:42:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: takasi-y@ops.dti.ne.jp, iwamatsu@nigauri.org

Hi , all .

I noticed that that ledtrig_ide_activity was not enable in libata. 

I append the patch to correct it. 
Please apply. 

regards ,
 Nobuhiro
-- 
Nobuhiro Iwamatsu
	E-Mail : hemamu@t-base.ne.jp
	GPG ID : 3170EBE9 

Signed-off-by: Nobuhiro Iwamatsu <iwamtsu@nigauri.org>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc362fa..51930be 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -407,6 +407,7 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 		tf->lbah = cyl >> 8;
 		tf->device |= head;
 	}
+	ledtrig_ide_activity();
 
 	return 0;
 }
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 80acd08..0b99f57 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -113,7 +113,7 @@ config LEDS_TRIGGER_TIMER
 
 config LEDS_TRIGGER_IDE_DISK
 	bool "LED IDE Disk Trigger"
-	depends on LEDS_TRIGGERS && BLK_DEV_IDEDISK
+	depends on LEDS_TRIGGERS && ( BLK_DEV_IDEDISK || ATA)
 	help
 	  This allows LEDs to be controlled by IDE disk activity.
 	  If unsure, say Y.
