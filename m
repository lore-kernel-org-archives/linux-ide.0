From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: libata bridge limits
Date: Wed, 27 Aug 2008 15:23:18 +0200
Message-ID: <20080827132318.GH20055@kernel.dk>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk> <20080826101713.GW20055@kernel.dk> <48B3F7C3.6010600@wasp.net.au> <20080826124816.GA20055@kernel.dk> <48B3FD40.3000109@kernel.org> <20080826130657.GB20055@kernel.dk> <20080826135822.GE20055@kernel.dk> <48B45B33.1050703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:59576 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757929AbYH0Nv4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Aug 2008 09:51:56 -0400
Content-Disposition: inline
In-Reply-To: <48B45B33.1050703@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, Brad Campbell <brad@wasp.net.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Tue, Aug 26 2008, Jeff Garzik wrote:
> Jens Axboe wrote:
> >OK, something like this. Jeff, if you think this is fine, let me know
> >and I'll submit a proper patch with description and so on.
> >
> >diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> >index 79e3a8e..879ceac 100644
> >--- a/drivers/ata/libata-core.c
> >+++ b/drivers/ata/libata-core.c
> >@@ -2100,6 +2100,10 @@ retry:
> > static inline u8 ata_dev_knobble(struct ata_device *dev)
> > {
> > 	struct ata_port *ap = dev->link->ap;
> >+
> >+	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
> >+		return 0;
> >+
> > 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
> > }
> > 
> >@@ -3998,6 +4002,9 @@ static const struct ata_blacklist_entry 
> >ata_device_blacklist [] = {
> > 	{ "TSSTcorp CDDVDW SH-S202N", "SB00",	  ATA_HORKAGE_IVB, },
> > 	{ "TSSTcorp CDDVDW SH-S202N", "SB01",	  ATA_HORKAGE_IVB, },
> > 
> >+	/* Devices that do not need bridging limits applied */
> >+	{ "Mtron",		NULL,		0, },
> >+
> > 	/* End Marker */
> > 	{ }
> > };
> >diff --git a/include/linux/libata.h b/include/linux/libata.h
> >index 225bfc5..9f194c0 100644
> >--- a/include/linux/libata.h
> >+++ b/include/linux/libata.h
> >@@ -364,6 +364,7 @@ enum {
> > 	ATA_HORKAGE_IPM		= (1 << 7),	/* Link PM problems */
> > 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs 
> > 	*/
> > 	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET 
> > 	*/
> >+	ATA_HORKAGE_BRIDGE_OK	= (1 << 10),	/* no bridge limits */
> > 
> > 	 /* DMA mask for user DMA control: User visible values; DO NOT
> > 	    renumber */
> 
> 
> This one seems fine to me...

OK, so here's a version that I also tested. I applied the bridge ok flag
to MTRON MSP-SATA, that is the closest match to the 70xx and 75xx
series.

---

From: Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH] libata: add whitelist for devices with known good pata-sata bridges

libata currently imposes a UDMA5 max transfer rate and 200 sector max
transfer size for SATA devices that sit behind a pata-sata bridge. Lots
of devices have known good bridges that don't need this limit applied.
The MTRON SSD disks are such devices. Transfer rates are increased by
20-30% with the restriction removed.

So add a "blacklist" entry for the MTRON devices, with a flag indicating
that the bridge is known good.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 79e3a8e..78cd9b3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2100,6 +2100,10 @@ retry:
 static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
+
+	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
+		return 0;
+
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
@@ -3998,6 +4002,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "TSSTcorp CDDVDW SH-S202N", "SB00",	  ATA_HORKAGE_IVB, },
 	{ "TSSTcorp CDDVDW SH-S202N", "SB01",	  ATA_HORKAGE_IVB, },
 
+	/* Devices that do not need bridging limits applied */
+	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK, },
+
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 225bfc5..9f194c0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -364,6 +364,7 @@ enum {
 	ATA_HORKAGE_IPM		= (1 << 7),	/* Link PM problems */
 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
 	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
+	ATA_HORKAGE_BRIDGE_OK	= (1 << 10),	/* no bridge limits */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */

-- 
Jens Axboe

