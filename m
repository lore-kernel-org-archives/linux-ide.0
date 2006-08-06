From: Tejun Heo <htejun@gmail.com>
Subject: [git-patch] libata: improve initialization and legacy handling, take
 #3
Date: Mon, 07 Aug 2006 02:56:03 +0900
Message-ID: <44D62D33.9070601@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080809040300090200070708"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:45682 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751176AbWHFR4n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 13:56:43 -0400
Received: by py-out-1112.google.com with SMTP id z74so1290577pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 10:56:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080809040300090200070708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

tj-upstream, tj-pata-drivers, tj-ALL have been updated per Alan's 
comment[1].  tj-upstream-fixes isn't affected.  Diff against the last 
take[L] is attached.

Updated git trees are available at...

http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream-fixes
git://htj.dyndns.org/libata-tj tj-upstream-fixes

http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream
git://htj.dyndns.org/libata-tj tj-upstream

http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-pata-drivers
git://htj.dyndns.org/libata-tj tj-pata-drivers

http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-ALL
git://htj.dyndns.org/libata-tj tj-ALL

Thanks.

-- 
tejun

[L] http://article.gmane.org/gmane.linux.ide/12401
[1] http://article.gmane.org/gmane.linux.ide/12412

--------------080809040300090200070708
Content-Type: text/x-patch;
 name="diff-against-last.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-against-last.patch"

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0bcf867..d3dd8e6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3048,6 +3048,7 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_port *ap = dev->ap;
 	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
+	int i;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -3075,6 +3076,16 @@ static void ata_dev_xfermask(struct ata_
 			       "other device, disabling DMA\n");
 	}
 
+	/* Use the lowest common PIO mode to avoid violating device
+	 * selection timing.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		if (!ata_dev_absent(d))
+			xfer_mask &= ata_pack_xfermask(d->pio_mask,
+						       UINT_MAX, UINT_MAX);
+	}
+
 	if (ap->ops->mode_filter)
 		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
 

--------------080809040300090200070708--
