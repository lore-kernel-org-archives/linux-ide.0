From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Sat, 03 Nov 2007 10:16:37 +0900
Message-ID: <472BCBF5.9080507@gmail.com>
References: <472B402A.4030009@gmail.com>	<472B4078.90009@gmail.com>	<20071102154215.1a93249c@the-village.bc.nu>	<472BA249.6000107@gmail.com>	<20071102234545.61353ce1@the-village.bc.nu>	<472BC4F3.7060209@gmail.com> <20071103011251.679334a8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:18972 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbXKCBQp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 21:16:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1129574wah
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 18:16:44 -0700 (PDT)
In-Reply-To: <20071103011251.679334a8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> 2. UDMA mode is configured but equal to or under UDMA33.  Dunno whether
>> it's cable or device limit but anyways you better limit it to UDMA33 too.
> 
> If it is under UDMA33 you know it isn't a cable limit
> 
> If it is UDMA 33 and the device top is > UDMA 33 it might be
> 
> This matters as you've got to account for both master and slave, as well
> as hotplug in theory.

I'm not sure whether that level of sophistication is necessary here.
This is more like a transfer rate filter thing rather than actual cable
detection.  We're basically just trying to follow what BIOS did.  Maybe
we should return ATA_CBL_PATA_MAYBE_80 unconditionally and implement
ata_acpi_more_filter()?

-- 
tejun
