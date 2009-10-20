From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: disk with ata_piix freezes
Date: Mon, 19 Oct 2009 18:39:08 -0600
Message-ID: <4ADD06AC.20104@gmail.com>
References: <4ADC3B7C.2070207@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52426 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbZJTAjJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Oct 2009 20:39:09 -0400
Received: by ewy3 with SMTP id 3so4256808ewy.17
        for <linux-ide@vger.kernel.org>; Mon, 19 Oct 2009 17:39:13 -0700 (PDT)
In-Reply-To: <4ADC3B7C.2070207@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Christoph Uhde <UhdeJC@gmx.net>
Cc: linux-ide@vger.kernel.org

On 10/19/2009 04:12 AM, Jan Christoph Uhde wrote:
> Hi,
> my net-book suffers serious disk freezes. I am using the ata_piix driver
> fom the latest ubuntu karmic kernel and have tried almost everything i
> could find .. every kernel option from force_pcs to .. acpi=.+ , pci=.+
> and i would really like to keep acpi .. :(
>
> Since google will not help this time i will ask here for help:
>
>
> ata port 1 device 0
> action = 0x6 i am to stupid to read the acton from libata.h:(
>
> exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> cmd ca/00:28:67:b5:7e/00:00:00:00:00/e0 tag 0 dma 20480 out
> res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> status: { DRDY }

Unfortunately this error output is not all that useful as it just says 
that a command (in this case a write) never completed. However, some of 
the data from your SMART output is a bit odd:

> 199 UDMA_CRC_Error_Count 0x003e 200 253 000 Old_age Always - 20

So looks like you had some data transfer errors..

> Error 20 occurred at disk power-on lifetime: 55 hours (2 days + 7 hours)
> When the command that caused the error occurred, the device was active
> or idle.
>
> After command completion occurred, registers were:
> ER ST SC SN CL CH DH
> -- -- -- -- -- -- --
> 84 51 05 82 a9 11 e0 Error: ICRC, ABRT 5 sectors at LBA = 0x0011a982 =
> 1157506
>
> Commands leading to the command that caused the error were:
> CR FR SC SN CL CH DH DC Powered_Up_Time Command/Feature_Name
> -- -- -- -- -- -- -- -- ---------------- --------------------
> c8 00 08 7f a9 11 e0 08 00:04:19.791 READ DMA
> ef 10 03 9e 3e 05 a0 08 00:04:11.675 SET FEATURES [Reserved for Serial ATA]
> ea 00 00 9e 3e 05 a0 08 00:04:08.477 FLUSH CACHE EXIT
> ca 00 08 97 3e 05 e9 08 00:04:08.476 WRITE DMA
> ea 00 00 96 3e 05 a0 08 00:04:08.370 FLUSH CACHE EXIT

So the command failed due to a CRC error on the SATA link. There should 
really be nothing the kernel or the driver could be doing that could 
cause this on a SATA device. What's the model of this netbook? This 
sounds like some kind of hardware issue to me..

I suspect that disabling ACPI only helps by coincidence (changes power 
usage pattern or something) as it has a lot of effects on the system, 
and isn't really a practical thing to do on any modern system because of 
the amount of functionality that this disables..
