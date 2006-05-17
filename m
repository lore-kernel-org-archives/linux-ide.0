From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 17:56:42 -0400
Message-ID: <446B9C1A.1060106@rtr.ca>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org> <446B9AA7.4000305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060702020604030202010706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:42729 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751167AbWEQV4n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 17:56:43 -0400
In-Reply-To: <446B9AA7.4000305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <mlord@pobox.com>, Ric Wheeler <ric@emc.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

This is a multi-part message in MIME format.
--------------060702020604030202010706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> ..
> Right.  Also, we need to snoop some passthrough commands and 
> revalidate/reconfigure when configuration is explicitly changed.

Once the sysfs attr's actually work, I'll probably re-do my hdparm
stuff to detect use them when available, avoiding the need for libata
to snoop passthrough commands.  But Jeff may (or not) want to snoop anyway.

As a workaround for now, Ric is using the ugly hack attached here.

Cheers

--------------060702020604030202010706
Content-Type: text/x-patch;
 name="wce_change_detect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wce_change_detect.patch"

--- linux/drivers/scsi/libata-scsi.c.orig	2006-05-15 14:20:27.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c	2006-05-17 17:50:11.000000000 -0400
@@ -2479,6 +2479,18 @@
 		goto invalid_fld;
 
 	/*
+	 * Filter: detect changes to WCE on the drive
+	 */
+	if (tf->command == ATA_CMD_SET_FEATURES && (tf->feature & 0x7f) == 2) {
+		extern void sd_set_WCE(struct device *, int);
+		struct scsi_device *sdev = qc->scsicmd->device;
+		struct device *dev = &sdev->sdev_gendev;
+		unsigned int wce = tf->feature == 2 ? 1 : 0;
+		qc->dev->id[85] = (qc->dev->id[85] & ~(1 << 5)) | (wce << 5);
+		sd_set_WCE(dev, wce);
+	}
+
+	/*
 	 * Set flags so that all registers will be written,
 	 * and pass on write indication (used for PIO/DMA
 	 * setup.)
--- linux/drivers/scsi/sd.c.orig	2005-12-12 18:50:34.000000000 -0500
+++ linux/drivers/scsi/sd.c	2006-03-06 15:09:44.000000000 -0500
@@ -1828,5 +1828,12 @@
 		unregister_blkdev(sd_major(i), "sd");
 }
 
+void sd_set_WCE (struct device *dev, int off_on)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	sdkp->WCE = off_on;
+}
+EXPORT_SYMBOL(sd_set_WCE);
+
 module_init(init_sd);
 module_exit(exit_sd);

--------------060702020604030202010706--
