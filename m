From: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 01:19:54 -0500
Message-ID: <20070513061954.GA16623@lixom.net>
References: <20070512145041.GA13025@lixom.net> <200705130111.03153.arnd@arndb.de> <20070513005830.38ba8e3b@the-village.bc.nu> <200705130248.22844.arnd@arndb.de> <1179022810.32247.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:58327 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384AbXEMGRI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 May 2007 02:17:08 -0400
Content-Disposition: inline
In-Reply-To: <1179022810.32247.54.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, paulus@samba.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sun, May 13, 2007 at 12:20:10PM +1000, Benjamin Herrenschmidt wrote:
>
> Then, the plans I have in mind for the future of that stuff are around
> the idea of registering "constructors" based on bus matches and device
> matches respectively.
> 
> The kernel will then walk the whole OF device-tree at boot, and will
> instanciate devices using those constructors, passing them the struct
> device of whatever was the parent.
> 
> Thus we could easily have platforms registers constructors for specific
> devices that build a platform device off an OF node.

Great. That should fit perfectly with the glue I have now, it'll turn
into the constructor instead.

I honestly don't see what the benefit is of this recent obsession
with creating of_platform devices for every new device that's not
PCI, especially when there's an already well-fitting driver in the
traditional platform model. It's not like the code to link the two is
large and complex.

Also, in this particular case, the bindings are not standardized, and
there's a good chance that whatever new platform uses a similar device
will need to do something slightly different.


-Olof
