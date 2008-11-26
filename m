From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious
 IRQs
Date: Wed, 26 Nov 2008 18:40:24 +0000
Message-ID: <20081126184024.3447c017@lxorguk.ukuu.org.uk>
References: <49263552.8090602@kernel.org>
	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>
	<492C30EE.9080600@garzik.org>
	<492CBA05.8000107@kernel.org>
	<20081126104731.4b370d18@lxorguk.ukuu.org.uk>
	<492D88B9.7040608@garzik.org>
	<492D8B1C.405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34249 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752482AbYKZSka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Nov 2008 13:40:30 -0500
In-Reply-To: <492D8B1C.405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> circumstances, during resume SRST, the drive would raise the IRQ line
> regardless of NIEN and will stay that way for several seconds, thus
> triggering nobody cared.  Other than detecting and clearing the
> spurious IRQ, there just isn't much driver can do to work around
> problems like this.

There is. It also means your patch isn't sufficient - if that IRQ had
been level triggered you'd have hung the box solid.

The old IDE code makes use of disable_irq/enable_irq (and really ought to
make use of on chip private IRQ mask bits as first choice but doesn't).

Sounds to me like there are two things we can do to help

Make the nIEN masking via a helper that can on suitable chips also mask
on chip.

Make use of disable_irq_nosync() in the case of devices that ignore nIEN
in the IRQ handler, setting a flag then re-enable it when the driver
path completes the reset and the bit goes clear.

We need to start using enable/disable_irq and/or local chip IRQ masking
for PIO in some places anyway.

Alan
