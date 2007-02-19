From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Mon, 19 Feb 2007 21:56:59 +0000
Message-ID: <20070219215659.15539fb3@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<200702151909.26082.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39426 "EHLO
	localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932689AbXBSVHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 16:07:19 -0500
In-Reply-To: <200702151909.26082.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linas Vepstas <linas@austin.ibm.com>, Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, James K Lewis <jim@jklewis.com>

> I fear that the hardest part is yet to come, when we integrate the
> driver for the the PS3 (currently called gelic_net) into spidernet.
> The trouble is that the hardware is sufficiently similar to share
> all the high-level mechanisms like the DMA data structures and
> descriptor chains, but the low-level mechanisms are hidden in the
> hypervisor on the PS3. Someone will have to invest a significant
> amount of time coordinating this so we don't break celleb and qs20
> in the process.

That to me implies they should be different drivers using a common
libata-something file. The PPC mac drivers likewise are currently mashed
into one in drivers/ide but really want splitting for libata with some
kind of libata-pmac owning the shared stuff

Alan
