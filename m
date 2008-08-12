From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 2/2] fastboot: use a DMI match table to set defaults for
 port-disable
Date: Tue, 12 Aug 2008 09:10:09 +0100
Message-ID: <20080812091009.05a32b39@lxorguk.ukuu.org.uk>
References: <20080811153542.61095e5c@infradead.org>
	<20080811153730.74599410@infradead.org>
	<1218503351.25524.28.camel@californication>
	<20080811220440.5cc1bc2d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38537 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751773AbYHLI1S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 04:27:18 -0400
In-Reply-To: <20080811220440.5cc1bc2d@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> if you solder the board... well you can add a tiny kernel patch or
> change the dmi ;)

Lots of people have them modified and you can even buy them pre-modded as
an end user. It needs to be simpler than hacking your kernel. In fact
this argues that the port disables should be handled by user space not by
the kernel ?

We have various other libata arguments so what would happen if instead we
pushing setting it up to userspace but fixing the libata. options line
for settings to take PCI bus info so you always hit the right port.

Yes you'd still need to fix some drivers to cope with that behaviour too
but it would kick policy (which this is) back into the hands of the
distro and end user.

Spinning a new kernel to get your off the shelf modded Eee PC wrking
isn't very user friendly.

Alan
