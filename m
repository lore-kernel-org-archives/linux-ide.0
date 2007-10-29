From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: ATAPI devices in AHCI mode not working
Date: Mon, 29 Oct 2007 16:40:13 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701EA70F4@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com><20071029203028.35645f26@the-village.bc.nu><39B20DF628532344BC7A2692CB6AEE0701EA6FBF@orsmsx420.amr.corp.intel.com> <20071029221332.1c9525a9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10929 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbXJ2Xmm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 19:42:42 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20071029221332.1c9525a9@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Sent: Monday, October 29, 2007 3:14 PM
>To: Gaston, Jason D
>Cc: linux-ide@vger.kernel.org
>Subject: Re: ATAPI devices in AHCI mode not working
>
>> ata1: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101100 irq 216
>> ata2: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101180 irq 216
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: ATAPI: ATAPI   DVD D  DH16D2S, EP52, max UDMA/100
>> ata1.00: configured for UDMA/100
>
>Much better - no misdetected link type, no device claiming to be PATA
>when its SATA.
>
>
>Right that eliminates all the obvious goings on being caused by broken
>devices which is a start. Doesn't shed any light on the rest of it.
What
>happens if you boot with irqpoll enabled ? (wondering if the timeouts
are
>ACPI or IRQ routing stuff)

I rebuilt the kernel; the DVD and USB devices are functional now. I'm
not sure what the problem was before.  On a side note: In 2.6.24.rc1 the
DVD starts working right away, but on a SLES10_SP1 kernel, it takes some
time for it to step down to a PIO mode before the DVD can be mounted.
Oh well.

Thanks!

Jason
