From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata: honor the transfer cycle time speficied by the
 EIDE device
Date: Wed, 16 Nov 2005 17:06:18 +0800
Message-ID: <437AF68A.6020702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:4488 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030250AbVKPJGf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 04:06:35 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAG96TI9011735
	for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 04:06:29 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAG97k0i052266
	for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 02:07:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAG96Sdv018911
	for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 02:06:29 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Jeff,

  The following code segment is not functional because the transfer cycle time speficied by 
  the EIDE device is later overwritten by ata_timing_quantize():

	/*
	 * If the drive is an EIDE drive, it can tell us it needs extended
	 * PIO/MW_DMA cycle timing.
	 */
	if (adev->id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE drive */
		memset(&p, 0, sizeof(p));
		(snip)
		ata_timing_merge(&p, t, t, ATA_TIMING_CYCLE | ATA_TIMING_CYC8B);
               <== uninitialized "t" is used here
	}

	/*
	 * Convert the timing to bus clock counts.
	 */
	ata_timing_quantize(s, t, T, UT);  <== t is overwritten by quantized s

  The patch has been submitted for ide-timing.h before:
  http://marc.theaimsgroup.com/?l=linux-ide&m=110820013425454&w=2
  Resubmitted for libata.

Changes:
  - Minor fix to honor the following transfer cycle time speficied by the device
    - id[65]: Minimum Multiword DMA transfer cycle time per word
    - id[67]: Minimum PIO transfer cycle time without flow control
    - id[68]: Minimum PIO transfer cycle time with IORDY

Patch against the mainline tree
(f6ff56cd56b83d8edf4b3cffc5c53c56b37a5081)
For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=======

--- linux/drivers/scsi/libata-core.c	2005-11-16 16:26:39.000000000 +0800
+++ time/drivers/scsi/libata-core.c	2005-11-16 16:30:59.000000000 +0800
@@ -1570,11 +1570,13 @@ int ata_timing_compute(struct ata_device
 
 	/*
 	 * Find the mode. 
-	*/
+	 */
 
 	if (!(s = ata_timing_find_mode(speed)))
 		return -EINVAL;
 
+	memcpy(t, s, sizeof(*s));
+
 	/*
 	 * If the drive is an EIDE drive, it can tell us it needs extended
 	 * PIO/MW_DMA cycle timing.
@@ -1595,7 +1597,7 @@ int ata_timing_compute(struct ata_device
 	 * Convert the timing to bus clock counts.
 	 */
 
-	ata_timing_quantize(s, t, T, UT);
+	ata_timing_quantize(t, t, T, UT);
 
 	/*
 	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T

