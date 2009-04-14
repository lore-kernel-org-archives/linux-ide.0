From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] sata_sil: enable 32-bit PIO
Date: Mon, 13 Apr 2009 22:57:28 -0600
Message-ID: <49E417B8.8070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:59880 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZDNE5o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 00:57:44 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2511655ywb.1
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2009 21:57:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

32-bit PIO seems to work fine on sata_sil hardware (tested on SiI3114) and is
listed as OK in the Silicon Image datasheets. Enable it.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index e67ce8e..030ec07 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -183,7 +183,7 @@ static struct scsi_host_template sil_sht = {
 };
 
 static struct ata_port_operations sil_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.dev_config		= sil_dev_config,
 	.set_mode		= sil_set_mode,
 	.bmdma_setup            = sil_bmdma_setup,

