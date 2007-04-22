From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_amd: remove contamination added during
 cable_detect conversion
Date: Sun, 22 Apr 2007 19:20:33 +0100
Message-ID: <20070422192033.4bc83c49@the-village.bc.nu>
References: <20070422170438.GK10619@htj.dyndns.org>
	<20070422184037.537ae748@the-village.bc.nu>
	<462BA0A5.2080900@gmail.com>
	<20070422185917.5fe14e97@the-village.bc.nu>
	<462BA607.5010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56423 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754323AbXDVSRF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 14:17:05 -0400
In-Reply-To: <462BA607.5010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> Yeap, definitely.  Can you please retest pata_acpi with ata_acpi_gtm()
> fixed?  I have an UDMA2 ODD (HL-DT-ST DVDRAM GSA-H10N) and UDMA4 HDD
> (WDC WD153AA) attached to 40c cable and ACPI mode discovery doesn't work
> at all.  The only thing I can get working here is storing the BIOS
> setting.  :-(

I'll try it next week although my BIOS worked beautifully with the
original code and without ata_acpi_gtm being fixed !

I've also seen some BIOSes which implement _gtm/_stm solely as "stuff it
back in BIOS boot up mode"

Alan
