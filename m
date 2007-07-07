From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Date: Sat, 7 Jul 2007 17:12:44 +0200
Message-ID: <200707071712.45173.arnd@arndb.de>
References: <20070707094852.9473.21013.stgit@localhost.localdomain> <20070707094900.9473.48577.stgit@localhost.localdomain> <20070707150708.GA5387@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbXGGPTE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 11:19:04 -0400
In-Reply-To: <20070707150708.GA5387@lixom.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Olof Johansson <olof@lixom.net>, Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 07 July 2007, Olof Johansson wrote:
> On Sat, Jul 07, 2007 at 01:49:00PM +0400, Vitaly Bordug wrote:
> > 
> > This updates relevant platform code
> > (freescale mpc8349itx target) to make the CompactFlash
> > work in TrueIDE mode.
> 
> Shouldn't you be writing a PCMCIA driver instead for the CF, so it
> handles other devices as well? Then you get storage "for free", as
> well as hotplug, etc.

CF memory cards can be in either TrueIDE mode or PCMCIA mode. If you
only need to support memory cards, you should always use True-IDE
mode, because that offers a _much_ higher throughput with PIO mode
6 (25 MB/s) or UDMA mode 6 (133MB/s), compared to the PIO mode 0
(3.3 MB/s) in PCMCIA mode.

Of course, if the bus can only sustain PIO mode 0 anyway, you can
just as well do a PCMCIA driver, and get the ability to plug in
other cards, e.g. wlan or modem cards.

	Arnd <><
