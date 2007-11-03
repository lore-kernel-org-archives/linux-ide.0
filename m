From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Sat, 03 Nov 2007 09:46:43 +0900
Message-ID: <472BC4F3.7060209@gmail.com>
References: <472B402A.4030009@gmail.com>	<472B4078.90009@gmail.com>	<20071102154215.1a93249c@the-village.bc.nu>	<472BA249.6000107@gmail.com> <20071102234545.61353ce1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:63630 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbXKCAqv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 20:46:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so931920rvb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 17:46:51 -0700 (PDT)
In-Reply-To: <20071102234545.61353ce1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> What the function answers is not actually cable type but "according to
>> the current configuration, using this cable type won't violate BIOS
>> configuration" kind of answer.  How the caller is to use that is the
>> caller's responsibility.
> 
> How does the caller make use of it ? The only way I can think of to use
> it is that if either drive says UDMA > 33 then we know its 80 wire.
> Otherwise we can't really prove anything. And if neither drive says > 80
> wire we have to go on what other info we have, which for NVidia appears
> to be "guess 40".
> 
> I'm not sure therefore we gain anything ?

I was trying to discern between the following three.

1. UDMA mode isn't configured at all.  Either BIOS forgot it, isn't
there or some other entity cleared it before the driver is loaded.  I
can't tell you anything.  If you have another source for cable
detection, use it instead.

2. UDMA mode is configured but equal to or under UDMA33.  Dunno whether
it's cable or device limit but anyways you better limit it to UDMA33 too.

3. UDMA mode is configured and above UDMA33.  Do whatever you wanna do.

Return values are ATA_CBL_PATA_UNK, ATA_CBL_PATA_UDMA33 and
ATA_CBL_PATA_UDMA66 respectively.

Thanks.

-- 
tejun
