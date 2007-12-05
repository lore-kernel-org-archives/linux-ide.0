From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] [libata] pata_platform: make probe and remove functions device type neutral
Date: Wed, 5 Dec 2007 18:37:27 +0300
Message-ID: <20071205153727.GA27896@localhost.localdomain>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170625.GA15599@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7128 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752172AbXLEPdd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 10:33:33 -0500
Content-Disposition: inline
In-Reply-To: <20071204170625.GA15599@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>

On Tue, Dec 04, 2007 at 08:06:25PM +0300, Anton Vorontsov wrote:
> Split pata_platform_{probe,remove} into two pieces:
> 1. pata_platform_{probe,remove} -- platform_device-dependant bits;
> 2. __ptata_platform_{probe,remove} -- device type neutral bits.
> 
> This is done to not duplicate code for the OF-platform driver.

Paul, do you have any objections regarding that one?

If there is no objections, could you stamp Acked-by on it?
Thus I can resend this set one more time for the merge, w/o
fourth patch.

>  /**
> - *	pata_platform_probe		-	attach a platform interface
> - *	@pdev: platform device
> + *	__pata_platform_probe		-	attach a platform interface
> + *	@dev: device
> + *	@io_res: Resource representing I/O base
> + *	@ctl_res: Resource representing CTL base
> + *	@irq_res: Resource representing IRQ and its flags
> + *	@ioport_shift: I/O port shift
  + *	@__pio_mask: PIO mask

^^^ added

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
