From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH 1/4] [libata] Blackfin pata-bf54x driver: Remove obsolete PM function
Date: Wed, 30 Jan 2008 16:43:25 +0800
Message-ID: <1201682608-22827-2-git-send-email-bryan.wu@analog.com>
References: <1201682608-22827-1-git-send-email-bryan.wu@analog.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:25724 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbYA3Ind (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 03:43:33 -0500
In-Reply-To: <1201682608-22827-1-git-send-email-bryan.wu@analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <bryan.wu@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/ata/pata_bf54x.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index a32e3c4..ca62bb7 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1373,10 +1373,6 @@ static struct scsi_host_template bfin_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations bfin_pata_ops = {
-- 
1.5.3.4
