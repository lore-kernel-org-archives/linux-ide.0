From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: CFA 4.0 patch
Date: Tue, 15 May 2012 14:15:04 +0400
Message-ID: <4FB22CA8.8080207@mvista.com>
References: <4E75C4FECC27A44E9F7E0737D71946900F686C5B@xmb-sjc-21e.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47320 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972Ab2EOKPa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2012 06:15:30 -0400
Received: by lahd3 with SMTP id d3so4009027lah.19
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2012 03:15:29 -0700 (PDT)
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

    Have you read the code below this point? We rely on the CFA feature set 
bit in the word 83 if the word 0 is non-traditional. Or does this below check 
not detect your CF?
    Your patch won't apply to the recent kernels anyway.

>   	/*
>   	 * CF specs don't require specific value in the word 0 anymore
> and yet
>   	 * they forbid to report the ATA version in the word 80 and
> require the

    Patch is also line wrapped.

WBR, Sergei
