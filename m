From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Mon, 3 Dec 2007 00:40:21 +0100
Message-ID: <200712030040.22701.arnd@arndb.de>
References: <20071127153708.GA12490@localhost.localdomain> <20071202114617.GA2923@zarina> <20071202154539.GA12415@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51555 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbXLBXkx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2007 18:40:53 -0500
In-Reply-To: <20071202154539.GA12415@lixom.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Anton Vorontsov <cbou@mail.ru>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org

On Sunday 02 December 2007, Olof Johansson wrote:

> Yes, I agree with Sergei: I don't think the pio/ata mode belongs there,
> "ata-generic" (or "generic-ata") sounds good to me. If firmwares want to
> specify pata/sata stuff as more specific compatible fields, then they are
> free to, but the driver shouldn't depend on it as long as "ata-generic"
> is in the list.

Yes, that makes sense. Let me just make it clear that I no longer think
we should have the PIO mode or the ATA level in the compatible property.
The PIO modes should really have their own property, if any, and the ATA
standard would need to be a property of the attached device, not a property
of the controller.

I can see a point in listing the ATA devices themselves in the device tree,
but it's probably not really worth it for the fdt setup, since they
can easily be probed at runtime.

> I will need to add a compatible field to it myself (our firmware uses
> "electra-ide") + some minor changes, but I will do that on top of this
> patch once it goes in since it involves removing the old code from
> arch/powerpc/platforms/pasemi.

I'd suggest to also have electra-ide hardcoded in the driver alongside
ata-generic, as a special case for backwards compatibility.

	Arnd <><
