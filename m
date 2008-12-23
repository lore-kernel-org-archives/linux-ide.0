From: Tejun Heo <tj@kernel.org>
Subject: Re: PIONEER DVD-RW DVRTD08 is disabled if there is no disc present
 at   boot time
Date: Tue, 23 Dec 2008 12:03:28 +0900
Message-ID: <49505500.8080409@kernel.org>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>	 <494F65C1.80602@kernel.org> <1229947998.6045.10.camel@Thutmosis>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020107030200010501060208"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46588 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbYLWDDg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 22:03:36 -0500
In-Reply-To: <1229947998.6045.10.camel@Thutmosis>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CCE-pbwz-4@reply.e4ward.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107030200010501060208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

linux-ide@momail.e4ward.com wrote:
> There's no error in dmesg output. But when I boot with a disk in the
> drive, I get the following errors in the boot screen:
> * Loading hardware devices
> [23.927373] end_request: I/O error, dev sr0, sector 1431744
> [23.927373] Buffer I/O error on device sr0, logical block 178968
> and then several more with just a different number in the square
> brackets. However, that does not seem to affect the operation of the
> drive.

Does the attached patch fix the problem?  Please do some data
integrity checks as it skips setxfermode on the drive.  If it's native
SATA, it probably should be okay but still it's way out of the spec.

Thanks.

-- 
tejun

--------------020107030200010501060208
Content-Type: text/x-patch;
 name="nosetxfer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nosetxfer.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c71f3ac..d89817a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3303,14 +3303,17 @@ static int ata_dev_set_mode(struct ata_device *dev)
 	struct ata_eh_context *ehc = &dev->link->eh_context;
 	const char *dev_err_whine = "";
 	int ign_dev_err = 0;
-	unsigned int err_mask;
+	unsigned int err_mask = 0;
 	int rc;
 
 	dev->flags &= ~ATA_DFLAG_PIO;
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-	err_mask = ata_dev_set_xfermode(dev);
+	if (!(dev->horkage & ATA_HORKAGE_NOSETXFER))
+		err_mask = ata_dev_set_xfermode(dev);
+	else
+		dev_err_whine = " (SET_XFERMODE skipped)";
 
 	if (err_mask & ~AC_ERR_DEV)
 		goto fail;
@@ -4132,6 +4135,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices that do not need bridging limits applied */
 	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK, },
 
+	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
+
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b79c319..f647d26 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -376,6 +376,7 @@ enum {
 	ATA_HORKAGE_BRIDGE_OK	= (1 << 10),	/* no bridge limits */
 	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 11), /* use ATAPI DMA for commands
 						    not multiple of 16 bytes */
+	ATA_HORKAGE_NOSETXFER	= (1 << 12),
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */

--------------020107030200010501060208--
