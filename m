From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Wed, 07 Feb 2007 11:53:17 +0900
Message-ID: <45C93F1D.8090504@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com> <20070206163303.GA2185@artsapartment.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020901050505090403080106"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:64939 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030188AbXBGRzV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 12:55:21 -0500
Received: by nz-out-0506.google.com with SMTP id s1so246635nze
        for <linux-ide@vger.kernel.org>; Wed, 07 Feb 2007 09:55:20 -0800 (PST)
In-Reply-To: <20070206163303.GA2185@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

This is a multi-part message in MIME format.
--------------020901050505090403080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Art Haas wrote:
>>> Also, zero out the features register before issuing PACKET_IDENTIFY,
>>> if the code isn't already doing that.
>> Okay.
>>
>>> After the drive asserts BUSY, and later deasserts BUSY,
>>> there might be a slight delay before the drive asserts DRQ.
>>> So, it is possible for the status to read zeros in the important bits.
>>>
>>> My suggestion is to wait up to the infamous 50 milliseconds again here,
>>> if needed.
>> Okay, the attached patch does what Mark suggested.  Art, can you please
>> give it a shot and report dmesg?  My thanks for sticking around till now.
> 
> SUCCESS!!!!!

Yay!

[--snip--]
> ata_piix 0000:00:07.1: version 2.00ac7
> ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> scsi0 : ata_piix
> ata1.00: ATA-2, max UDMA/33, 6303024 sectors: LBA 
> ata1.00: ata1: dev 0 multi count 16
> ata1.01: ATA-4, max UDMA/66, 16514064 sectors: LBA 
> ata1.01: ata1: dev 1 multi count 16
> ata1.00: configured for UDMA/33
> ata1.01: configured for UDMA/33
> scsi1 : ata_piix
> ata2.00: ATAPI, max MWDMA1
> ata2.00: configured for MWDMA1

So, it succeeded without any DRQ wait.  Can you please apply only the 
attached patch over vanilla 2.6.20 and see if your problem is fixed?

This problem has been around for quite a while now and there probably 
have been other users hit by this out there.  Thanks a lot, Mark.

-- 
tejun

--------------020901050505090403080106
Content-Type: text/x-patch;
 name="clear-TF-for-IDENTIFY.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clear-TF-for-IDENTIFY.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 667acd2..d6fcf0a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1478,7 +1478,16 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	}
 
 	tf.protocol = ATA_PROT_PIO;
-	tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
+
+	/* Some devices choke if TF registers contain garbage.  Make
+	 * sure those are properly initialized.
+	 */
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+
+	/* Device presence detection is unreliable on some
+	 * controllers.  Always poll IDENTIFY if available.
+	 */
+	tf.flags |= ATA_TFLAG_POLLING;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);

--------------020901050505090403080106--

