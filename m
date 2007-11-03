From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Sat, 03 Nov 2007 16:03:56 +0900
Message-ID: <472C1D5C.6030900@gmail.com>
References: <472B402A.4030009@gmail.com>	<472B4078.90009@gmail.com>	<20071102154215.1a93249c@the-village.bc.nu>	<472BA249.6000107@gmail.com>	<20071102234545.61353ce1@the-village.bc.nu>	<472BC4F3.7060209@gmail.com>	<20071103011251.679334a8@the-village.bc.nu>	<472BCBF5.9080507@gmail.com> <20071103012354.466096c2@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:17112 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759393AbXKCHEF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 03:04:05 -0400
Received: by rv-out-0910.google.com with SMTP id k20so993298rvb
        for <linux-ide@vger.kernel.org>; Sat, 03 Nov 2007 00:04:03 -0700 (PDT)
In-Reply-To: <20071103012354.466096c2@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> detection.  We're basically just trying to follow what BIOS did.  Maybe
>> we should return ATA_CBL_PATA_MAYBE_80 unconditionally and implement
> 
> MAYBE_80 = UNK.

Yeah, right.  I somehow thought it was close to "don't really know but
treat as 40c" but it's more like "don't really know maybe 80c".

I think implementing this as mode filter is the better approach and
reflects the situation better.  We can't really tell the cable type.
All we know is how BIOS/firmware configured it and we're just trying to
use the same transfer mode.

Do you agree?  Then, I'll go ahead and redo the patch and implement this
mess as mode filter.

>> ata_acpi_more_filter()?
> 
> We can also use UNK intelligently in the eh code to go straight from
> UDMA133/100/66 to 33 (if you don't already I've not read that logic
> recently)

The default behavior of the current EH code should be enough.  It first
decelerate one step (e.g. UDMA/133->UDMA/100) and then right to UDMA/33.
 With the pending speed down update patch applied, it will take at most
three consecutive errors to reach UDMA/33 from any speed above that.

Thanks.

-- 
tejun
