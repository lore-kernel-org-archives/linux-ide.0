From: Tejun Heo <htejun@gmail.com>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Thu, 07 Dec 2006 21:37:09 +0900
Message-ID: <45780AF5.2020605@gmail.com>
References: <20060924221020.GB2080@artsapartment.org>	<4562C65C.2010802@gmail.com>	<20061206181652.GA3107@artsapartment.org>	<45779852.1030909@gmail.com> <20061207105525.4ebb4547@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030408010904080903010109"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:60095 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032143AbWLGMhQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Dec 2006 07:37:16 -0500
Received: by nz-out-0102.google.com with SMTP id s1so319739nze
        for <linux-ide@vger.kernel.org>; Thu, 07 Dec 2006 04:37:15 -0800 (PST)
In-Reply-To: <20061207105525.4ebb4547@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Art Haas <ahaas@airmail.net>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030408010904080903010109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Alan wrote:
> On Thu, 07 Dec 2006 13:28:02 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Please test the attached patch.
> 
> That should be getting done automatically by the driver and used to work
> with the old eh/probe code. It does rely on having done the initial PIO0
> identify of both devices and the mode decision being made before mode
> setting functions are called however, and that is/was documented as a
> guarantee, and is relied upon all over.

I broke it in the following commit while implementing per-dev xfermode.
 I have no idea what I was thinking.  :-(

commit 37deecb5139ee431233781a9a093d9fcaab54c5b
[PATCH] libata: implement per-dev xfermask

> Definitely worth testing Art, especially if it shows something up.

Art, I attached the wrong patch and it won't apply to vanilla 2.6.19.
Patch against 2.6.19 is attached here.  Please test this one.

> Tejun: pata_amd does the timing merges itself both for 8bit which is
> shared and in the timing compute for the DMA cases. Also the other
> pattern to these reports is ATAPI, although that might I guess be a
> symptom of "slave". 

Yeap, I noticed the ATAPI devices and also that in many reports those
devices are pretty old ones which support only upto MWDMA modes.  My
suspicion was that people are pairing a slower ODD with a newer HDD on
the same channel and seeing this problem.

> The other problem is that mmio bus reset is broken, but the AMD always
> uses PIO cycles so that shouldn't be involved.
> 
> Alan (still baffled by this one)

Let's see if this patch fixes anything.

-- 
tejun

--------------030408010904080903010109
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 915a55a..b54ca36 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3109,6 +3109,7 @@ static void ata_dev_xfermask(struct ata_device *dev)
 	struct ata_port *ap = dev->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
+	int i;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -3120,10 +3121,27 @@ static void ata_dev_xfermask(struct ata_device *dev)
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
+	/* apply xfermask limits of this device */
 	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	/* PIO xfermask limits are shared by all devices on the same
+	 * channel to avoid violating device selection timing.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		unsigned int pio_mask;
+
+		if (ata_dev_absent(d))
+			continue;
+
+		ata_unpack_xfermask(ata_id_xfermask(d->id),
+				    &pio_mask, NULL, NULL);
+		pio_mask &= d->pio_mask;
+		xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
+	}
+
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared
 	 *	cable

--------------030408010904080903010109--
