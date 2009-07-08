From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER
Date: Thu, 09 Jul 2009 08:07:44 +0900
Message-ID: <4A5526C0.2030302@kernel.org>
References: <1229894315.6931.17.camel@Thutmosis>	<494EDDBE.3010306@shaw.ca>	<494F65C1.80602@kernel.org>	<1229947998.6045.10.camel@Thutmosis>	<49505500.8080409@kernel.org>	<1230126055.6430.17.camel@Thutmosis>	<495886E7.7050204@kernel.org>	<1230586376.11130.46.camel@Thutmosis>	<1231282276.6376.13.camel@Thutmosis>	<49640CE1.6070808@kernel.org>	<20090107094043.580f5bf7@lxorguk.ukuu.org.uk>	<496483A5.6020105@kernel.org>	<20090107105339.289f47a4@lxorguk.ukuu.org.uk>	<49648C41.6030002@kernel.org>	<4A1A0C1B.7020801@kernel.org>	<20090525091110.626da5f8@lxorguk.ukuu.org.uk>	<4A545236.6080808@kernel.org>	<20090708111413.7bb25e1e@lxorguk.ukuu.org.uk>	<4A547FF6.7010609@kernel.org> <20090708132104.10e969a1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36573 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280AbZGHXJF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2009 19:09:05 -0400
In-Reply-To: <20090708132104.10e969a1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, linux-ide@vger.kernel.org, m.nov4k@gmail.com, lars21ce@gmx.de

Hello,

Alan Cox wrote:
>> 2. Skip SETXFER.  Any direct SATA connection to the device would work
>>    fine.
>>
>> 2. Ignore SETXFER timeout.  Probably would work for TF based
>>    controllers but it's largely untested for sata controllers and the
>>    behavior is likely undefined for more advanced controllers.
> 
>> So, #2 seems like the logical choice here.  If worst comes to worst
> 
> You have two #2's

Oops.

> but I agree that providing its for this specific drive
> and we document it carefully so people don't add it to stuff that is
> wrong then your first #2 is probably safest.
> 
> Possibly  HORKAGE_NO_SETXFER_SATA and check word 93 ?

How about something like the following?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 045a486..2c6aeda 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3392,17 +3392,27 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 
 static int ata_dev_set_mode(struct ata_device *dev)
 {
+	struct ata_port *ap = dev->link->ap;
 	struct ata_eh_context *ehc = &dev->link->eh_context;
+	const bool nosetxfer = dev->horkage & ATA_HORKAGE_NOSETXFER;
 	const char *dev_err_whine = "";
 	int ign_dev_err = 0;
-	unsigned int err_mask;
+	unsigned int err_mask = 0;
 	int rc;
 
 	dev->flags &= ~ATA_DFLAG_PIO;
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-	err_mask = ata_dev_set_xfermode(dev);
+	if (nosetxfer && ap->flags & ATA_FLAG_SATA && ata_id_is_sata(dev->id))
+		dev_err_whine = " (SET_XFERMODE skipped)";
+	else {
+		if (nosetxfer)
+			ata_dev_printk(dev, KERN_WARNING,
+				       "NOSETXFER but PATA detected - can't "
+				       "skip SETXFER, might malfunction\n");
+		err_mask = ata_dev_set_xfermode(dev);
+	}
 
 	if (err_mask & ~AC_ERR_DEV)
 		goto fail;
@@ -4297,6 +4307,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices which aren't very happy with higher link speeds */
 	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS, },
 
+	/*
+	 * Devices which choke on SETXFER.  Applies only if both the
+	 * device and controller are SATA.
+	 */
+	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
+
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d501db..2b641af 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -385,6 +385,7 @@ enum {
 						    not multiple of 16 bytes */
 	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firmware update warning */
 	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
+	ATA_HORKAGE_NOSETXFER	= (1 << 14),
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */

-- 
tejun
