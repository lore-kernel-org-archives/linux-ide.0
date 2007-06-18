From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 14:42:07 +0100
Message-ID: <20070618144207.751a254b@the-village.bc.nu>
References: <200706181520.06682.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37887 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758609AbXFRNgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 09:36:41 -0400
In-Reply-To: <200706181520.06682.chunkeey@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chr <chunkeey@web.de>
Cc: linux-ide@vger.kernel.org

On Mon, 18 Jun 2007 15:20:06 +0200
Chr <chunkeey@web.de> wrote:

> Hi,
> 
> I got a new laptop and I had a little problem that the DVD drive wasn't recognized by
> libata's piix driver (but the old IDE Subsystem found it!).
> 
> So, after adding the new pciid 8086:2850 it works!
> But, I don't know if it's ich_pata_100 or ich_pata_133 since the 
> dvd/cd drives only goes up to udma2 speeds.

Its ich_pata_133 - all the newer chips are. They work even better if you
set them into AHCI mode in the BIOS and then they should "just work" with
recent kernels as the AHCI driver now matches by class.

Alan
