From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER
Date: Wed, 07 Jan 2009 11:01:05 +0900
Message-ID: <49640CE1.6070808@kernel.org>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>	 <494F65C1.80602@kernel.org> <1229947998.6045.10.camel@Thutmosis>	 <49505500.8080409@kernel.org> <1230126055.6430.17.camel@Thutmosis>	 <495886E7.7050204@kernel.org>  <1230586376.11130.46.camel@Thutmosis> <1231282276.6376.13.camel@Thutmosis>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57702 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756218AbZAGCBY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 21:01:24 -0500
In-Reply-To: <1231282276.6376.13.camel@Thutmosis>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at
Cc: linux-ide@vger.kernel.org

PIONEER DVD-RW DVRTD08 times out SETXFER if no media is present.  The
device is SATA and simply skipping SETXFER works around the problem.
Implement ATA_HORKAGE_NOSETXFER and apply it to the device.

Reported by Moritz Rigler in the following thread.

  http://thread.gmane.org/gmane.linux.ide/36790

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   10 ++++++++--
 include/linux/libata.h    |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fecca42..eceaace 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3310,14 +3310,17 @@ static int ata_dev_set_mode(struct ata_device *dev)
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
@@ -4207,6 +4210,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices that do not need bridging limits applied */
 	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK, },
 
+	/* Devices which choke on SETXFER.  Presumably SATA only. */
+	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
+
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3449de5..e78dc6b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -377,6 +377,7 @@ enum {
 	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 11), /* use ATAPI DMA for commands
 						    not multiple of 16 bytes */
 	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firwmare update warning */
+	ATA_HORKAGE_NOSETXFER	= (1 << 13),
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
