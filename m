From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Sat, 3 Nov 2007 01:12:51 +0000
Message-ID: <20071103011251.679334a8@the-village.bc.nu>
References: <472B402A.4030009@gmail.com>
	<472B4078.90009@gmail.com>
	<20071102154215.1a93249c@the-village.bc.nu>
	<472BA249.6000107@gmail.com>
	<20071102234545.61353ce1@the-village.bc.nu>
	<472BC4F3.7060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:45992 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755214AbXKCBLk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Nov 2007 21:11:40 -0400
In-Reply-To: <472BC4F3.7060209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> 2. UDMA mode is configured but equal to or under UDMA33.  Dunno whether
> it's cable or device limit but anyways you better limit it to UDMA33 too.

If it is under UDMA33 you know it isn't a cable limit

If it is UDMA 33 and the device top is > UDMA 33 it might be

This matters as you've got to account for both master and slave, as well
as hotplug in theory.
