From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Fri, 24 Aug 2007 14:48:58 +0100
Message-ID: <20070824144858.384b1040@the-village.bc.nu>
References: <46C1DCBB.9020308@double-you.de>
	<20070814184301.3201d162@the-village.bc.nu>
	<46C2047D.4040901@double-you.de>
	<20070815002447.40f7f206@the-village.bc.nu>
	<46CE8CC7.4080900@double-you.de>
	<46CEAB1B.9060908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42966 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752403AbXHXNky (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 09:40:54 -0400
In-Reply-To: <46CEAB1B.9060908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Karim 'Kasi Mir' Senoucci <ks@double-you.de>, linux-ide@vger.kernel.org

On Fri, 24 Aug 2007 05:55:39 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Karim 'Kasi Mir' Senoucci wrote:
> > Alan Cox schrieb:
> >>> in the sata_mv source. Should I add something like:
> >>>
> >>>         { PCI_VDEVICE(TTI, 0x2300), chip_604x }

> You need to use the sata_mv from kernel 2.6.23-rcX.
> 
> Patching into older drivers isn't guaranteed to work.

May also be the actual chip on the 2300 is different to the older ones
and isn't a 604x.
