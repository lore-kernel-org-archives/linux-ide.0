From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Wed, 28 Nov 2007 10:21:34 +0900
Message-ID: <474CC29E.8020102@gmail.com>
References: <47434526.7010304@verizonbusiness.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030306030505070704060105"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.236]:61366 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759543AbXK1BWF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 20:22:05 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1386185hue
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 17:22:03 -0800 (PST)
In-Reply-To: <47434526.7010304@verizonbusiness.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Paulus <mark.paulus@verizonbusiness.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306030505070704060105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Mark Paulus wrote:
> sata_sil 0000:02:0b.0: version 2.2
> ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 22 (level, low) -> IRQ 18
> scsi0 : sata_sil
> scsi1 : sata_sil
> ata1: SATA max UDMA/100 cmd 0xe0812080 ctl 0xe081208a bmdma 0xe0812000
> irq 18
> ata2: SATA max UDMA/100 cmd 0xe08120c0 ctl 0xe08120ca bmdma 0xe0812008
> irq 18
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
> ata1.00: 19541088 sectors, multi 16: LBA ata1.00: applying bridge limits
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
> ata1.00: revalidation failed (errno=-5)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: failed to set xfermode (err_mask=0x40)
> ata1.00: limiting speed to UDMA/100:PIO3
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: failed to set xfermode (err_mask=0x40)

It looks like for some reason the port is being frozen repeatedly.  Can
you please apply the attached patch and post the dmesg?

Thanks.

-- 
tejun

--------------030306030505070704060105
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.patch"

---
 drivers/ata/sata_sil.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: tree0/drivers/ata/sata_sil.c
===================================================================
--- tree0.orig/drivers/ata/sata_sil.c
+++ tree0/drivers/ata/sata_sil.c
@@ -390,11 +390,15 @@ static void sil_host_intr(struct ata_por
 			ap->eh_info.serror |= serror;
 		}
 
+		ata_port_printk(ap, KERN_INFO, "XXX SATA_IRQ, serror=0x%x\n",
+				serror);
 		goto freeze;
 	}
 
-	if (unlikely(!qc))
+	if (unlikely(!qc)) {
+		ata_port_printk(ap, KERN_INFO, "XXX DMA completion w/o qc\n");
 		goto freeze;
+	}
 
 	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
 		/* this sometimes happens, just clear IRQ */

--------------030306030505070704060105--
