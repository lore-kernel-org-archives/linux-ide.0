From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_uli: ignore SIMPLEX
Date: Tue, 16 Jan 2007 14:55:51 +0900
Message-ID: <20070116055551.GN10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:42923 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932374AbXAPFz7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 00:55:59 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Some uli controllers have stuck SIMPLEX bit which can't be cleared
with ata_pci_clear_simplex(), but the controller is capable of doing
DMAs on both channels simultaneously.  Ignore it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 5c603ca..62b9269 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -226,6 +226,13 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	probe_ent->private_data = hpriv;
 
+	/* these chips have stuck dummy simplex bit, ignore it */
+	if (probe_ent->_host_flags & ATA_HOST_SIMPLEX) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "BMDMA simplex set, ignored\n");
+		probe_ent->_host_flags &= ~ATA_HOST_SIMPLEX;
+	}
+
 	switch (board_idx) {
 	case uli_5287:
 		hpriv->scr_cfg_addr[0] = ULI5287_BASE;
