From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: is Promise TX4302 supported?
Date: Wed, 27 Jun 2007 09:41:06 +0200 (MEST)
Message-ID: <200706270741.l5R7f6NP026694@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:39000 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbXF0HlV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 03:41:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jkt@gentoo.org, linux-ide@vger.kernel.org

On Wed, 27 Jun 2007 03:46:47 +0200, jkt@gentoo.org wrote:
> I'm considering buying a four-channel SATA PCI controller marked as
> Promise TX-4302 (two internal SATA links, two eSATA, independent on each
> other). According to the product page at Promise [1], Linux is missing
> from the list of supported operating systems, although Google suggests
> that online stores include Linux in the list of supported OSes.
> 
> I wasn't able to find this chip mentioned at the list of supported
> chipsets [2]. There's a similarly looking TX-4, but I don't like the
> idea of buying a nice room decoration instead of a working device.
> 
> I wasn't able to find out any reference to AHCI in the specs, either.

I can't find any publicly available linux driver source or
technical documentation for the TX4302, so I cannot say if
it will work as-is, or what the differences to the standard
SATA300 TX4 might be.
