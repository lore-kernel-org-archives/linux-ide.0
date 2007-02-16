From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Implement the technote about promise/maxtor drives
Date: Fri, 16 Feb 2007 14:53:54 +0800
Message-ID: <45D55502.2020702@tw.ibm.com>
References: <20070131171251.4210bcdb@localhost.localdomain> <45D55003.6030307@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:60564 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbXBPGyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 01:54:03 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G6s0L6019490
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 01:54:00 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1G6s0Ps510834
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 23:54:00 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1G6s0fH010377
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 23:54:00 -0700
In-Reply-To: <45D55003.6030307@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Albert wrote:
> Alan wrote:
> 
>>I don't have the hardware combination to test this one so would
>>appreciate people testing it before it goes anywhere further
>>
> 
> 
> I've gotten two Maxtor UDMA/133 drives for testing with 2.6.20-git11.
> Those Maxtors drives are quite old: the media access commands no longer
> work, but device identify/configuration still works.
> 
> Below is the test result:
> 
> 1. Before the patch, both drives are configured to UDMA/133:
> 
<snip>
> 
> ======================================================================================
> 2. After the patch, the slave drive is limited to UDMA/100:
> 
> pata_pdc2027x 0000:02:05.0: version 0.74-ac5
> ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
> ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
> pata_pdc2027x 0000:02:05.0: PLL input clock 16992 kHz
> ata3: PATA max UDMA/133 cmd 0xe08497c0 ctl 0xe0849fda bmdma 0xe0849000 irq 10
> ata4: PATA max UDMA/133 cmd 0xe08495c0 ctl 0xe0849dda bmdma 0xe0849008 irq 10
> scsi2 : pata_pdc2027x
> input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
> ata3.00: ATA-5: MAXTOR 6L060L3, A93.0500, max UDMA/133
> ata3.00: 117266688 sectors, multi 16: LBA 
> ata3.01: ATA-7: Maxtor 6Y060L0, YAR41BW0, max UDMA/133
> ata3.01: 120103200 sectors, multi 16: LBA 
> ata3.00: configured for UDMA/133
> ata3.01: configured for UDMA/100
> scsi3 : pata_pdc2027x
> ATA: abnormal status 0x8 on port 0xe08495df
<snip>

> ===================================================
> So, it looks the patch works as designed/intended.
> BTW, maybe we should print something similar to the "applying bridge limits" message,
> otherwise the end users might wonder why their slave drive is configured as UDMA/100.
> 

Some Maxtor drives have "Maxtor" and others have "MAXTOR" in the identify device data.
If the slave is a "MAXTOR" one, the following code segment doesn't work.

+	/* If the master is a maxtor in UDMA6 then the slave should not use UDMA 6 */
+	if(strstr(model_num, "Maxtor") == 0 && pair->dma_mode == XFER_UDMA_6)
+		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));

Maybe we should check both "Maxtor" and "MAXTOR"?
--
albert

