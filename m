From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: problem with register_hw_with_fixup
Date: Tue, 23 Jan 2007 09:53:41 +0000
Message-ID: <20070123095341.4017f2f0@localhost.localdomain>
References: <45B5CCA8.7010603@janz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40711 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932929AbXAWJm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 04:42:29 -0500
In-Reply-To: <45B5CCA8.7010603@janz.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Althoefer <as@janz.de>
Cc: linux-ide@vger.kernel.org

On Tue, 23 Jan 2007 09:51:52 +0100
Stefan Althoefer <as@janz.de> wrote:

> hi,
> 
> I'm currently developing a ide driver for an embedded ARM device.
> The device hardware is somewhat wired, as all IDE access must
> be done 16bit, even the control bytes. I therefore need special
> access functions.

For new drivers you should really be looking at drivers/ata

> However, in probe_hwif_init_with_fixup() I find this sequence:
> 
> -----%<-----------------
> int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
> {
> 	probe_hwif(hwif);
> 
> 	if (fixup)
> 		fixup(hwif);
> -------------------------
> 
> fixup() gets called after probe_hwif, hence my special function
> pointers will not be installed in time.

fixup is intended for doing drive level fixups and was added fairly
recently to deal with things like IT8212 in RAID mode and some PCMCIA
decode problems which run after the probe.

There isn't a good way to handle this with the old IDE layer. PMac does
it by walking the hwif array itself (without any proper locking). Adding
the call you need might be a good idea, but moving fixup will break
things.

Alan

