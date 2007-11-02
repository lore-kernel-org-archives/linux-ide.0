From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Sat, 03 Nov 2007 07:18:49 +0900
Message-ID: <472BA249.6000107@gmail.com>
References: <472B402A.4030009@gmail.com>	<472B4078.90009@gmail.com> <20071102154215.1a93249c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:3787 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472AbXKBWS6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:18:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so909658rvb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:18:58 -0700 (PDT)
In-Reply-To: <20071102154215.1a93249c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> Using the initial GTM value is the right thing to do because both are
>> trying to check firmware setting and by the time ->cable_detect runs
>> the controller is already forced into PIO0 by reset.
> 
> As we only look at the DMA bits that doesn't matter but I agree it would
> be cleaner if we were more careful. Also our mode setting outside
> pata_acpi doesn't touch the ACPI settings so its ok for that reason too.

GTM results do change whether you call STM or not.  GTM in many cases is
implemented as reading the current configuration value from the
controller so if you configure PIO0, it will return PIO0 timings.  And,
yeah, on ASUS A8N-E, if you configure PIO0, GTM answer says DMA is off.

>> + * Determine cable type from UDMA configuration in @gtm.  If UDMA is
>> + * disabled, it returns ATA_CBL_PATA_UNK.  If UDMA is enabled and
>> + * faster than 33, PATA_80; otherwise, PATA_40.
> 
> NAK
> 
> Consider the case of a UDMA 33 capable device on an 80 wire cable. We
> simply can't use the cable detect methods to prove it is 40 wire this way.
> 
> What we actually know is
> 
> 	If UDMA > 33 selected		-> UDMA > 33 works
> 					80 wire
> 					Short
> 					or SATA
> 
> 	If UDMA > 33 not selected	Unknown
> 					40 wire
> 					80 + Drive limit
> 					80 + Controller limit
> 					80 + BIOS is set to PIO
> 					etc
> 
> The only case I can see you could reasonably suggest 40 wire would be
> IFF the drive is capable of UDMA > 33 _and_ the ACPI mode is UDMA 33.

What the function answers is not actually cable type but "according to
the current configuration, using this cable type won't violate BIOS
configuration" kind of answer.  How the caller is to use that is the
caller's responsibility.

-- 
tejun
