From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 14:39:27 +0100
Message-ID: <20070513143927.59ca253e@the-village.bc.nu>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
	<200705130248.22844.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58603 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760923AbXEMNfS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 May 2007 09:35:18 -0400
In-Reply-To: <200705130248.22844.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, paulus@samba.org, linux-ide@vger.kernel.org

> > Easier to use pata_platform I would think ? Just create the OF device and
> > bind it to pata_platform.
> 
> Not sure I understand what you mean. pata_platform expects a platform_device,
> which cannot be cast from an of_device.

Other than the binding and wanting to use the standard ->set_mode they
appear to be identical so a copy of pata_platform ought to turn into a
pata_of very nicely.

> Olof, have you looked at which of the two ->set_mode functions is more
> appropriate for electra? I would guess that you actually want to use
> the ata_generic one.

You almost certainly simply don't want to provide one. I'm not sure the
pata_platform default one is right at all as it will assume the firmware
tuned everything. ata_generic does this purely because it is a "last
resort" driver for chips we can't tune/program at all.

Alan
