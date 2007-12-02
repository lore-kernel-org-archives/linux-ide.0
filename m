From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Sun, 2 Dec 2007 17:58:38 -0600
Message-ID: <20071202235838.GA19678@lixom.net>
References: <20071127153708.GA12490@localhost.localdomain> <20071202114617.GA2923@zarina> <20071202154539.GA12415@lixom.net> <200712030040.22701.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:46674 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbXLBXyw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 18:54:52 -0500
Content-Disposition: inline
In-Reply-To: <200712030040.22701.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Anton Vorontsov <cbou@mail.ru>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org

On Mon, Dec 03, 2007 at 12:40:21AM +0100, Arnd Bergmann wrote:
> On Sunday 02 December 2007, Olof Johansson wrote:
> 
> > Yes, I agree with Sergei: I don't think the pio/ata mode belongs there,
> > "ata-generic" (or "generic-ata") sounds good to me. If firmwares want to
> > specify pata/sata stuff as more specific compatible fields, then they are
> > free to, but the driver shouldn't depend on it as long as "ata-generic"
> > is in the list.
> 
> Yes, that makes sense. Let me just make it clear that I no longer think
> we should have the PIO mode or the ATA level in the compatible property.
> The PIO modes should really have their own property, if any, and the ATA
> standard would need to be a property of the attached device, not a property
> of the controller.

Right. And configuring PIO modes is something quite hardware specific,
which defeats the purpose of having a "generic" driver as a catch-all
for "simple" configs in the first place. If the hardware needs (much)
tuning it probably makes more sense to do it as a separate driver.

> I can see a point in listing the ATA devices themselves in the device tree,
> but it's probably not really worth it for the fdt setup, since they
> can easily be probed at runtime.

If the firmware probes them and/or knows about them. It's the kind of
thing that can change quite often. We don't list USB devices under the usb
controllers either, since they're quite volatile and the device tree is
(fairly) static on the DTS-based platforms.

> > I will need to add a compatible field to it myself (our firmware uses
> > "electra-ide") + some minor changes, but I will do that on top of this
> > patch once it goes in since it involves removing the old code from
> > arch/powerpc/platforms/pasemi.
> 
> I'd suggest to also have electra-ide hardcoded in the driver alongside
> ata-generic, as a special case for backwards compatibility.

Yep, that's my plan, I'll do that when I move it over.


-Olof
