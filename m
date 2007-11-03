From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Sat, 3 Nov 2007 01:23:54 +0000
Message-ID: <20071103012354.466096c2@the-village.bc.nu>
References: <472B402A.4030009@gmail.com>
	<472B4078.90009@gmail.com>
	<20071102154215.1a93249c@the-village.bc.nu>
	<472BA249.6000107@gmail.com>
	<20071102234545.61353ce1@the-village.bc.nu>
	<472BC4F3.7060209@gmail.com>
	<20071103011251.679334a8@the-village.bc.nu>
	<472BCBF5.9080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43492 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751873AbXKCBWr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 21:22:47 -0400
In-Reply-To: <472BCBF5.9080507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> detection.  We're basically just trying to follow what BIOS did.  Maybe
> we should return ATA_CBL_PATA_MAYBE_80 unconditionally and implement

MAYBE_80 = UNK.

> ata_acpi_more_filter()?

We can also use UNK intelligently in the eh code to go straight from
UDMA133/100/66 to 33 (if you don't already I've not read that logic
recently)
