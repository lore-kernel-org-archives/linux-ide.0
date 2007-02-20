From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Tue, 20 Feb 2007 09:14:23 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702200912410.2082@pademelon.sonytel.be>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp> <200702151141.49708.jens@de.ibm.com>
 <20070215171414.GU923@austin.ibm.com> <200702151909.26082.arnd@arndb.de>
 <20070219215659.15539fb3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vervifontaine.sonytel.be ([80.88.33.193]:34944 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964980AbXBTIOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 03:14:25 -0500
In-Reply-To: <20070219215659.15539fb3@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, James K Lewis <jim@jklewis.com>

On Mon, 19 Feb 2007, Alan wrote:
> > I fear that the hardest part is yet to come, when we integrate the
> > driver for the the PS3 (currently called gelic_net) into spidernet.
> > The trouble is that the hardware is sufficiently similar to share
> > all the high-level mechanisms like the DMA data structures and
> > descriptor chains, but the low-level mechanisms are hidden in the
> > hypervisor on the PS3. Someone will have to invest a significant
> > amount of time coordinating this so we don't break celleb and qs20
> > in the process.
> 
> That to me implies they should be different drivers using a common
> libata-something file. The PPC mac drivers likewise are currently mashed
> into one in drivers/ide but really want splitting for libata with some
> kind of libata-pmac owning the shared stuff

FYI, the gelic_net and spidernet drivers Arnd was talking about are _Ethernet_
drivers, not (S)ATA drivers.

That's what happens to the casual reader when the email subjects no longer
match ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
