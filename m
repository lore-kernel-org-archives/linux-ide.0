From: Alan <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH] sata_sis: missing PM support
Date: Wed, 01 Jan 2014 21:39:31 +0000
Message-ID: <20140101213924.19334.8990.stgit@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50435 "EHLO
	alan.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754591AbaAAVud (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jan 2014 16:50:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org

sata_sis has no suspend/resume methods. The default ones will do fine and
are needed on some systems.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/ata/sata_sis.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index fe3ca09..1ad2f62 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -83,6 +83,10 @@ static struct pci_driver sis_pci_driver = {
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static struct scsi_host_template sis_sht = {

