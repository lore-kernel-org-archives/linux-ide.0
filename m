From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER
Date: Mon, 25 May 2009 12:10:19 +0900
Message-ID: <4A1A0C1B.7020801@kernel.org>
References: <1229894315.6931.17.camel@Thutmosis>	<494EDDBE.3010306@shaw.ca>	<494F65C1.80602@kernel.org>	<1229947998.6045.10.camel@Thutmosis>	<49505500.8080409@kernel.org>	<1230126055.6430.17.camel@Thutmosis>	<495886E7.7050204@kernel.org>	<1230586376.11130.46.camel@Thutmosis>	<1231282276.6376.13.camel@Thutmosis>	<49640CE1.6070808@kernel.org>	<20090107094043.580f5bf7@lxorguk.ukuu.org.uk>	<496483A5.6020105@kernel.org> <20090107105339.289f47a4@lxorguk.ukuu.org.uk> <49648C41.6030002@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090909000900080209000205"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49800 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbZEYDLc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 May 2009 23:11:32 -0400
In-Reply-To: <49648C41.6030002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, linux-ide@vger.kernel.org, m.nov4k@gmail.com

This is a multi-part message in MIME format.
--------------090909000900080209000205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Reviving an old thread and quoting whole body for new reporter.

Tejun Heo wrote:
> Alan Cox wrote:
>>>> Sorry you can't just blindly do this because some of the controllers snoop
>>>> the SETXFER command to set their timings and whether they expect DMA. Also
>>>> we've no idea if this is a bug in a specific firmware revision, a quirky
>>>> pata/sata bridge or a timing problem of some sort.
>>> I think it'll generally be okay for SATA unless it's bridged over to
>>> PATA controller.  Any other ideas?
>> We seem to have one report, from one user, with one configuration, on one
>> controller, using one firmware set.
> 
> There are two more reports linked from the thread.
> 
>   http://ubuntuforums.org/showthread.php?t=986871
>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/299865
> 
> And all of them are showing the same problem.  This being a slim SATA
> drive for a laptop, I don't really expect to see the drive in varied
> configurations.  The problem might as well be limited to certain OEM
> drive(s).
> 
>> That to me isn't meaningful evidence of anything that needs a workaround,
>> beyond maybe doing what old IDE does and if a setxfer times out
>> continuing in hope.
> 
> So, as far as the validity of the report goes, I think it's at
> reasonable level.  Add to that my general trigger happiness toward
> quirks and the machine is a VAIO and to me quirking it doesn't seem
> too careless.
> 
>> (We should of course then re-read the identify pages and check the mode
>> in use)
> 
> Of course, whether the workaround is proper is a completely separate
> issue but unless other devices with the same problem creep up and the
> device is happy with the quirk, I don't really think we should modify
> the default configuration sequence for devices like this.
> 
> That said, Moritz, can you please post the output of "hdparm -I" with
> and without the quirk applied?  And can you please use a preoper mail
> address?

Martin Novak (cc'd) is reporting the same problem.  I really think
doing nothing is the worst choice here.  Given the rarity of the
issue, I don't think we need worry too much about long term impact of
the quirk.

Anyways, Martin, can you please post what I asked Moritz - the output
of "hdparm -I" with and without the quirk applied?  Quirk patch is
attached.

Thanks.

-- 
tejun

--------------090909000900080209000205
Content-Type: text/x-patch;
 name="horkage-notsetxfer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="horkage-notsetxfer.patch"

libata: implement and use HORKAGE_NOSETXFER

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
index c924230..5dcdcb4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3390,14 +3390,17 @@ static int ata_dev_set_mode(struct ata_device *dev)
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
@@ -4292,6 +4295,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices which aren't very happy with higher link speeds */
 	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS, },
 
+	/* Devices which choke on SETXFER.  Presumably SATA only. */
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

--------------090909000900080209000205--
