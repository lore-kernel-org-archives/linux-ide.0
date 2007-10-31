From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATAPI devices in AHCI mode not working
Date: Wed, 31 Oct 2007 17:07:16 +0900
Message-ID: <472837B4.3000109@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com><20071029203028.35645f26@the-village.bc.nu><39B20DF628532344BC7A2692CB6AEE0701EA6FBF@orsmsx420.amr.corp.intel.com> <20071029221332.1c9525a9@the-village.bc.nu> <39B20DF628532344BC7A2692CB6AEE0701EA70F4@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070405050305050407050600"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:6575 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbXJaIHY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 04:07:24 -0400
Received: by rv-out-0910.google.com with SMTP id k20so61780rvb
        for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 01:07:23 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701EA70F4@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070405050305050407050600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gaston, Jason D wrote:
>> -----Original Message-----
>> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>> Sent: Monday, October 29, 2007 3:14 PM
>> To: Gaston, Jason D
>> Cc: linux-ide@vger.kernel.org
>> Subject: Re: ATAPI devices in AHCI mode not working
>>
>>> ata1: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101100 irq 216
>>> ata2: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101180 irq 216
>>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> ata1.00: ATAPI: ATAPI   DVD D  DH16D2S, EP52, max UDMA/100
>>> ata1.00: configured for UDMA/100
>> Much better - no misdetected link type, no device claiming to be PATA
>> when its SATA.
>>
>>
>> Right that eliminates all the obvious goings on being caused by broken
>> devices which is a start. Doesn't shed any light on the rest of it.
> What
>> happens if you boot with irqpoll enabled ? (wondering if the timeouts
> are
>> ACPI or IRQ routing stuff)
> 
> I rebuilt the kernel; the DVD and USB devices are functional now. I'm
> not sure what the problem was before.  On a side note: In 2.6.24.rc1 the
> DVD starts working right away, but on a SLES10_SP1 kernel, it takes some
> time for it to step down to a PIO mode before the DVD can be mounted.
> Oh well.

Yeah, there has been quite some update in libata between SLES10_SP1 and
2.6.24-rc1.  The controller being ahci, I wonder whether this is caused
by the different in check_atapi_dma().

1. Does other optical drives have the same problem?  If not, please post
the result of "hdparm -I /dev/sr0" with the problematic one attached.

2. If you apply the attached patch to 2.6.24-rc1, does it behave the
same as the SLES10SP1 kernel?

-- 
tejun

--------------070405050305050407050600
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8ee56e5..5d9b193 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4491,11 +4491,13 @@ int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
+#if 0
 	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
 	 * few ATAPI devices choke on such DMA requests.
 	 */
 	if (unlikely(qc->nbytes & 15))
 		return 1;
+#endif
 
 	if (ap->ops->check_atapi_dma)
 		return ap->ops->check_atapi_dma(qc);

--------------070405050305050407050600--
