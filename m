From: Tejun Heo <tj@kernel.org>
Subject: [PATCH UPDATED #upstream-fixes] libata: handle SEMB signature better
Date: Wed, 15 Apr 2009 06:21:10 +0900
Message-ID: <49E4FE46.1010006@kernel.org>
References: <49E466DE.7020701@kernel.org> <49E47DBF.9060502@garzik.org> <49E4FA13.1090400@kernel.org> <49E4FB42.7010609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34244 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbZDNVWU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 17:22:20 -0400
In-Reply-To: <49E4FB42.7010609@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, David Haun <drhaun88@gmail.com>, liw@liw.fi, jmcarranza@gmail.com

WDC WD1600JS-62MHB5 successfully hits the window between ATA/ATAPI-7
and Serial ATA II standards and reports 3c/c3 signature which now is
assigned to SEMB.  Make ata_dev_classify() report ATA_DEV_SEMB on the
sig and let ata_dev_read_id() work around it by trying IDENTIFY once.

This fixes bko#11579.

UPDATED: Jeff spotted stupid bug caused by lingering debug code.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: David Haun <drhaun88@gmail.com>
Reported-by: Lars Wirzenius <liw@liw.fi>
Reported-by: Juan Manuel <jmcarranza@gmail.com>
---
 drivers/ata/libata-core.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 065507c..a61af38 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1231,6 +1231,9 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 	 *
 	 * We follow the current spec and consider that 0x69/0x96
 	 * identifies a port multiplier and 0x3c/0xc3 a SEMB device.
+	 * Unfortunately, WDC WD1600JS-62MHB5 (a hard drive) reports
+	 * SEMB signature.  This is worked around in
+	 * ata_dev_read_id().
 	 */
 	if ((tf->lbam == 0) && (tf->lbah == 0)) {
 		DPRINTK("found ATA device by sig\n");
@@ -1248,8 +1251,8 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 	}
 
 	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3)) {
-		printk(KERN_INFO "ata: SEMB device ignored\n");
-		return ATA_DEV_SEMB_UNSUP; /* not yet */
+		DPRINTK("found SEMB device by sig (could be ATA device)\n");
+		return ATA_DEV_SEMB;
 	}
 
 	DPRINTK("unknown device\n");
@@ -2080,6 +2083,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
 	const char *reason;
+	bool is_semb = class == ATA_DEV_SEMB;
 	int may_fallback = 1, tried_spinup = 0;
 	int rc;
 
@@ -2090,6 +2094,8 @@ retry:
 	ata_tf_init(dev, &tf);
 
 	switch (class) {
+	case ATA_DEV_SEMB:
+		class = ATA_DEV_ATA;	/* some hard drives report SEMB sig */
 	case ATA_DEV_ATA:
 		tf.command = ATA_CMD_ID_ATA;
 		break;
@@ -2126,6 +2132,14 @@ retry:
 			return -ENOENT;
 		}
 
+		if (is_semb) {
+			ata_dev_printk(dev, KERN_INFO, "IDENTIFY failed on "
+				       "device w/ SEMB sig, disabled\n");
+			/* SEMB is not supported yet */
+			*p_class = ATA_DEV_SEMB_UNSUP;
+			return 0;
+		}
+
 		if ((err_mask == AC_ERR_DEV) && (tf.feature & ATA_ABORTED)) {
 			/* Device or controller might have reported
 			 * the wrong device class.  Give a shot at the
