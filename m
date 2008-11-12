From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.28-rc3 libata: still "failed to IDENTIFY" on bootup
Date: Wed, 12 Nov 2008 11:35:02 +0900
Message-ID: <491A40D6.1000207@kernel.org>
References: <20081109130231.GA20290@rhlx01.hs-esslingen.de> <4919521E.2040703@kernel.org> <20081111161113.GA4179@rhlx01.hs-esslingen.de> <20081111174634.GA11632@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090309060308020404010704"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49008 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbYKLCfW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 21:35:22 -0500
In-Reply-To: <20081111174634.GA11632@rhlx01.hs-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------090309060308020404010704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andreas Mohr wrote:
> when searching for the "identify retried exceeded" BSD error message
> the CRX700E-mentioning page is the _only_ one that comes up on Google!!
> (IOW, it strongly looks like this issue seems quite isolated to CRX700E drives
> only and we should find a way to implement an IDENTIFY-timeout-related blacklist flag,
> for CRX700E, somehow).
> 
> ...right?
> 
> (BTW, does a drive firmware have to do something special to obey
> Cable Select protocol properly, and would this thus indicate a firmware bug indeed?)

I think libata screwed up somewhere.  Can you please apply the attached
patch and report the kernel log?

-- 
tejun

--------------090309060308020404010704
Content-Type: text/x-patch;
 name="phantom-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="phantom-debug.patch"

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4b47394..abbb5f0 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1226,11 +1226,16 @@ fsm_start:
 		} else {
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
+				ata_dev_printk(qc->dev, KERN_INFO, "XXX status=0x%x hdiag=%d\n",
+					       status, qc->dev->horkage & ATA_HORKAGE_DIAGNOSTIC);
+
 				/* handle BSY=0, DRQ=0 as error */
-				if (likely(status & (ATA_ERR | ATA_DF)))
+				if (likely(status & (ATA_ERR | ATA_DF))) {
 					/* device stops HSM for abort/error */
 					qc->err_mask |= AC_ERR_DEV;
-				else {
+					if (qc->dev->horkage & ATA_HORKAGE_DIAGNOSTIC)
+						qc->err_mask |= AC_ERR_NODEV_HINT;
+				} else {
 					/* HSM violation. Let EH handle this.
 					 * Phantom devices also trigger this
 					 * condition.  Mark hint.
@@ -1838,6 +1843,8 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 
 	/* determine if device is ATA or ATAPI */
 	class = ata_dev_classify(&tf);
+	ata_dev_printk(dev, KERN_INFO, "XXX sff_dev_classify present=%d hdiag=%d tf=%02x:%02x:%02x class=%d\n",
+		       present, dev->horkage & ATA_HORKAGE_DIAGNOSTIC, tf.lbal, tf.lbam, tf.lbah, class);
 
 	if (class == ATA_DEV_UNKNOWN) {
 		/* If the device failed diagnostic, it's likely to
@@ -1981,6 +1988,7 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 		devmask |= (1 << 0);
 	if (slave_possible && ata_devchk(ap, 1))
 		devmask |= (1 << 1);
+	ata_link_printk(link, KERN_INFO, "XXX devmask=%x\n", devmask);
 
 	/* select device 0 again */
 	ap->ops->sff_dev_select(ap, 0);

--------------090309060308020404010704--
