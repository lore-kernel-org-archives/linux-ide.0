From: "Andre Hedrick (anhedric)" <anhedric@cisco.com>
Subject: RE: CFA 4.0 patch
Date: Tue, 15 May 2012 04:07:32 -0700
Message-ID: <4E75C4FECC27A44E9F7E0737D71946900F686C8D@xmb-sjc-21e.amer.cisco.com>
References: <4E75C4FECC27A44E9F7E0737D71946900F686C5B@xmb-sjc-21e.amer.cisco.com> <4FB22CA8.8080207@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:31416 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab2EOLRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2012 07:17:00 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4FB22CA8.8080207@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org

Hi Sergei,

I am glad to see the mailing lists are still rough and tumble as they
were in the past.

I am so sorry, it has been 10 plus years since I was the global
maintainer or drivers/ide and co-author of ATA/ATAPI-6 and 7.  Your
first comment is a whatever, patch line wrap who cares.  Now the second
comment, I happen to know what it does and I am letting everyone know
what it fails to do also.

The enclosed text came directly from the CFA 4.0 standard document, read
it again please.

Take care now, mate.

Cheers,
Andre

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com] 
Sent: Tuesday, May 15, 2012 3:15 AM
To: Andre Hedrick (anhedric)
Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; lkml@vger.kernel.org
Subject: Re: CFA 4.0 patch

Hello.

On 15-05-2012 8:57, Andre Hedrick (anhedric) wrote:

> This is a missing part of the CFA 4.0 and above support.

> 6.2.1.6.1 Word 0: General Configuration
> 	This field indicates the general characteristics of the device.
> When Word 0 of the Identify drive information is 848Ah then the device
> is a CompactFlash Storage Card and complies with the CFA specification
> and CFA command set. It is recommended that PC Card modes of operation
> report only the 848Ah value as they are always intended as removable
> devices.

> Bits 15-0: CF Standard Configuration Value
> Word 0 is 848Ah. This is the recommended value of Word 0.
> 	Some operating systems require Bit 6 of Word 0 to be set to 1
> (Non-removable device) to use the card as the root storage device. The
> Card must be the root storage device when a host completely replaces
> conventional disk storage with a CompactFlash Card in True IDE mode.
To
> support this requirement and provide capability for any future
removable
> media Cards, alternate handling of Word 0 is permitted.

> Bits 15-0: CF Preferred Alternate Configuration Values

> 044Ah: This is the alternate value of Word 0 turns on ATA device and
> turns off Removable Media and Removable Device while 	preserving all
> Retired bits in the word.

> 0040h: This is the alternate value of Word 0 turns on ATA device and
> turns off Removable Media and Removable Device while 	zeroing all
> Retired bits in the word

> Cheers,
> Andre
> --------------------
> The Linux X-ATA/SATA guy
>
>
> --- linux-2.6.32.orig/include/linux/ata.h	Mon May 14 15:48:24 2012
> +++ linux-2.6.32/include/linux/ata.h	Mon May 14 15:51:42 2012
> @@ -819,6 +819,10 @@
>   {
>   	if (id[ATA_ID_CONFIG] == 0x848A)	/* Traditional CF */
>   		return 1;
> +	if (id[ATA_ID_CONFIG] == 0x044A)	/* Alternative CF w/
> removable turned off, preserving retired bits */
> +		return 1;
> +	if (id[ATA_ID_CONFIG] == 0x0040)	/* Alternative CF w/
> removable turned off, zeroing retired bits*/
> +		return 1;

    Have you read the code below this point? We rely on the CFA feature
set 
bit in the word 83 if the word 0 is non-traditional. Or does this below
check 
not detect your CF?
    Your patch won't apply to the recent kernels anyway.

>   	/*
>   	 * CF specs don't require specific value in the word 0 anymore
> and yet
>   	 * they forbid to report the ATA version in the word 80 and
> require the

    Patch is also line wrapped.

WBR, Sergei
