From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: CFA 4.0 patch
Date: Tue, 15 May 2012 15:37:02 +0400
Message-ID: <4FB23FDE.7020604@mvista.com>
References: <4E75C4FECC27A44E9F7E0737D71946900F686C5B@xmb-sjc-21e.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43966 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757814Ab2EOLh3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2012 07:37:29 -0400
Received: by lahd3 with SMTP id d3so4052658lah.19
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2012 04:37:27 -0700 (PDT)
In-Reply-To: <4E75C4FECC27A44E9F7E0737D71946900F686C5B@xmb-sjc-21e.amer.cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Andre Hedrick (anhedric)" <anhedric@cisco.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, lkml@vger.kernel.org

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
> conventional disk storage with a CompactFlash Card in True IDE mode. To
> support this requirement and provide capability for any future removable
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
If bits 15:12 are set to 0h then Bits 11:0 are set using the definitions below 
and the Card is
required to support for the CFA command set and report that in bit 2 of Word 83.
Bit 15:12 values other than 8h and 0h are prohibited.

    That's why our code does what it does, and not checks for the alternate 
values. If our check in word 83 fails, we therefore have a broken device.

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
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

WBR, Sergei
