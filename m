From: Tejun Heo <tj@kernel.org>
Subject: Re: Can you please test the attached patch for nv hardreset problem?
Date: Wed, 15 Oct 2008 14:22:19 +0900
Message-ID: <48F57E0B.6050403@kernel.org>
References: <48E80F11.3060101@kernel.org>	 <64630f150810111634gbe4cfdfjccafc9f6f781edcc@mail.gmail.com>	 <48F30678.7020807@kernel.org>	 <64630f150810131213m64d8fc72j38debf71a692db16@mail.gmail.com>	 <48F3F368.2090901@kernel.org> <64630f150810141431r1d070cddl1c2a6b32ae80b64c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090103010704050607020908"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36079 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbYJOFYd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 01:24:33 -0400
In-Reply-To: <64630f150810141431r1d070cddl1c2a6b32ae80b64c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gettinther <gettinther@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, Robert Hancock <hancockr@shaw.ca>

This is a multi-part message in MIME format.
--------------090103010704050607020908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

gettinther wrote:
> The log simply ignores the drive altogether.
> 
> from the sound coming from the drive, it does seem that the drive
> initially starts at boot, then stops.  After that stage the device
> detection takes place.  as the item is a pata to sata converter
> (emulated sata), it does not support hot plugging.
> 
> I also need to mention that this behavior (start-stop during boot) did
> not happen on the 2.6.24 and I need to check the 2.6.27.  However the
> device is detected by both of these kernels.

Hmmm...

> Oct 14 21:18:12 localhost kernel: ata2: SATA link up 1.5 Gbps (SStatus
> 113 SControl 300)

Hmmm... Can you please apply the attached patch on top of it and
report the boot log?

-- 
tejun

--------------090103010704050607020908
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e97afce..1fc4f80 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1160,6 +1160,8 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 	 * We follow the current spec and consider that 0x69/0x96
 	 * identifies a port multiplier and 0x3c/0xc3 a SEMB device.
 	 */
+	printk("XXX classify %02x/%02x\n", tf->lbam, tf->lbah);
+
 	if ((tf->lbam == 0) && (tf->lbah == 0)) {
 		DPRINTK("found ATA device by sig\n");
 		return ATA_DEV_ATA;
@@ -5855,7 +5857,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 			ehi->probe_mask |= ATA_ALL_DEVICES;
 			ehi->action |= ATA_EH_RESET | ATA_EH_LPM;
-			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+			ehi->flags |= ATA_EHI_NO_AUTOPSY/* | ATA_EHI_QUIET*/;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
 			ap->pflags |= ATA_PFLAG_LOADING;

--------------090103010704050607020908--
