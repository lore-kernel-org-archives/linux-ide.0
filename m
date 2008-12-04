From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious
 IRQs
Date: Thu, 4 Dec 2008 16:35:43 +0000
Message-ID: <20081204163543.04697aae@lxorguk.ukuu.org.uk>
References: <49263552.8090602@kernel.org>
	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>
	<492C30EE.9080600@garzik.org>
	<492CBA05.8000107@kernel.org>
	<20081126104731.4b370d18@lxorguk.ukuu.org.uk>
	<492D88B9.7040608@garzik.org>
	<492D8B1C.405@kernel.org>
	<20081126184024.3447c017@lxorguk.ukuu.org.uk>
	<492D9C30.8080208@kernel.org>
	<49380667.5040705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45064 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750951AbYLDQfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 11:35:47 -0500
In-Reply-To: <49380667.5040705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Keep in mind that disable_irq() is nasty for other devices
> sharing the same PCI interrupt as the IDE interface..

Well currently we disable all the interrupts to that CPU which is fairly
unfriendly too so it's not perfect but its certainly better and it is
what works with old IDE.

If you care about performance you have an AHCI controller ;)

Alan
