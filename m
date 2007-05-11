From: akpm@linux-foundation.org
Subject: [patch 01/20] git-libata-all: sata_via build fix
Date: Thu, 10 May 2007 22:48:43 -0700
Message-ID: <200705110548.l4B5mhlp007615@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:55557 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757576AbXEKFs6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:48:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, htejun@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

Cc: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_via.c |    4 ----
 1 file changed, 4 deletions(-)

diff -puN drivers/ata/sata_via.c~git-libata-all-sata_via-build-fix drivers/ata/sata_via.c
--- a/drivers/ata/sata_via.c~git-libata-all-sata_via-build-fix
+++ a/drivers/ata/sata_via.c
@@ -116,10 +116,6 @@ static struct scsi_host_template svia_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static const struct ata_port_operations vt6420_sata_ops = {
_
