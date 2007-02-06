From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Tue, 06 Feb 2007 18:11:44 +0900
Message-ID: <45C84650.3030703@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010902090903000404010309"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:21081 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbXBFJLu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 04:11:50 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1855743nze
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2007 01:11:49 -0800 (PST)
In-Reply-To: <45C4E6BB.6020307@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>, Art Haas <ahaas@airmail.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

This is a multi-part message in MIME format.
--------------010902090903000404010309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mark Lord wrote:
> Tejun Heo wrote:
>> ..
>> Then, PACKET_IDENTIFY after configuring transfer mode fails with
>> -ENOENT.  Meaning it saw (status & (ATA_BUSY|ATA_DRQ|ATA_ERR|ATA_DF)) ==
>> 0 in HSM_ST.
> ..
>> So, PATA gurus, can you bless us with enlightenment?  :-)
> 
> Heh.. guaranteeing detection of all the strange implementations out there
> is part black magic.
> 
> But the simple thing to do here is, just for fun, hack the code
> to do the infamous 50 millisecond hard wait before issuing the
> PACKET_IDENTIFY.
> If that fixes it, then it's just a matter of tuning to discover the real
> amount of delay required, and a nicer way of doing the delay.

Okay.

> Also, zero out the features register before issuing PACKET_IDENTIFY,
> if the code isn't already doing that.

Okay.

> After the drive asserts BUSY, and later deasserts BUSY,
> there might be a slight delay before the drive asserts DRQ.
> So, it is possible for the status to read zeros in the important bits.
> 
> My suggestion is to wait up to the infamous 50 milliseconds again here,
> if needed.

Okay, the attached patch does what Mark suggested.  Art, can you please
give it a shot and report dmesg?  My thanks for sticking around till now.

-- 
tejun

--------------010902090903000404010309
Content-Type: text/x-patch;
 name="wait-for-drq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wait-for-drq.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 667acd2..4c81433 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1478,7 +1478,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	}
 
 	tf.protocol = ATA_PROT_PIO;
-	tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
+	/* POLLING for polling detection, ISADDR|DEVICE to clear TF */
+	tf.flags |= ATA_TFLAG_POLLING | ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
@@ -4477,6 +4478,18 @@ fsm_start:
 				goto fsm_start;
 
 		} else {
+			unsigned long timeout = jiffies + msecs_to_jiffies(50);
+
+			while (time_before(jiffies, timeout)) {
+				if (status & ATA_DRQ)
+					break;
+				ata_dev_printk(qc->dev, KERN_INFO,
+					"XXX: waiting for DRQ, status=0x%x\n",
+					status);
+				msleep(10);
+				status = ata_chk_status(ap);
+			}
+
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */

--------------010902090903000404010309--
