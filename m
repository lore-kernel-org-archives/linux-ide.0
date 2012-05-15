From: "Andre Hedrick (anhedric)" <anhedric@cisco.com>
Subject: RE: CFA 4.0 patch
Date: Tue, 15 May 2012 12:20:36 -0700
Message-ID: <4E75C4FECC27A44E9F7E0737D71946900F686DE1@xmb-sjc-21e.amer.cisco.com>
References: <4E75C4FECC27A44E9F7E0737D71946900F686C5B@xmb-sjc-21e.amer.cisco.com> <4FB23FDE.7020604@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtv-iport-4.cisco.com ([173.36.130.15]:54076 "EHLO
	mtv-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966416Ab2EOTUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2012 15:20:43 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4FB23FDE.7020604@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Sergei,

Sorry wrong answer about broken devices, and if I had taken such short
cuts in the past, the strength of the cheap storage would not have been
there or present today in Linux.

Just because someone calls it broken, because they don't read "ALL" the
associated specification, it means they don't understand what they don't
know.  So try again with all the information before the classic call if
"it is broken" because I can't or don't know how to fix.

Cheers,
Andre

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com] 
Sent: Tuesday, May 15, 2012 4:37 AM
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

    If you did read a bit further, you'd have seen:

Bit 15-12: Configuration Flag
If bits 15:12 are set to 8h then Word 0 shall be 848Ah.
If bits 15:12 are set to 0h then Bits 11:0 are set using the definitions
below 
and the Card is
required to support for the CFA command set and report that in bit 2 of
Word 83.
Bit 15:12 values other than 8h and 0h are prohibited.

    That's why our code does what it does, and not checks for the
alternate 
values. If our check in word 83 fails, we therefore have a broken
device.

> Cheers,
> Andre
> --------------------
> The Linux X-ATA/SATA guy

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
>   	/*
>   	 * CF specs don't require specific value in the word 0 anymore
> and yet
>   	 * they forbid to report the ATA version in the word 80 and
> require the
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

WBR, Sergei
