From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Wed, 15 Aug 2007 00:24:47 +0100
Message-ID: <20070815002447.40f7f206@the-village.bc.nu>
References: <46C1DCBB.9020308@double-you.de>
	<20070814184301.3201d162@the-village.bc.nu>
	<46C2047D.4040901@double-you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45006 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753895AbXHNXQ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 19:16:56 -0400
In-Reply-To: <46C2047D.4040901@double-you.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karim 'Kasi Mir' Senoucci <ks@double-you.de>
Cc: linux-ide@vger.kernel.org

> in the sata_mv source. Should I add something like:
> 
>         { PCI_VDEVICE(TTI, 0x2300), chip_604x },
> 
> as well?

Yes


> Last but not least: I'm assuming that this driver - when working 
> correctly - will let me access the RAID arrays I setup via BIOS or 
> Windows driver, but there will be no way to create or modify the arrays 
> from within linux itself, right?

The RAID is entirely software so its up to software what is handled. I
don't know if dmraid will handle whatever format HPT have used this time
but you may be lucky.

