From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 02:48:22 +0200
Message-ID: <200705130248.22844.arnd@arndb.de>
References: <20070512145041.GA13025@lixom.net> <200705130111.03153.arnd@arndb.de> <20070513005830.38ba8e3b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61535 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbXEMAse (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 20:48:34 -0400
In-Reply-To: <20070513005830.38ba8e3b@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Olof Johansson <olof@lixom.net>, paulus@samba.org, linux-ide@vger.kernel.org

On Sunday 13 May 2007, Alan Cox wrote:
> > Why not provide a proper pata_of.c driver based on ata_generic? That
> > will help the next person that has a builtin ata controller and wants
> > to get it running as an of_device.
> 
> Easier to use pata_platform I would think ? Just create the OF device and
> bind it to pata_platform.

Not sure I understand what you mean. pata_platform expects a platform_device,
which cannot be cast from an of_device.

Actually, it might be possible to merge the common parts of pata_platform,
ata_generic and ata_of into one module, and have one driver for each
of the three bus_types on top of it. Currently, the only difference between
ata_generic and pata_platform is the ->set_mode function, which can
probably be made generic (controlled by a flag in the ata_port).

Olof, have you looked at which of the two ->set_mode functions is more
appropriate for electra? I would guess that you actually want to use
the ata_generic one.

	Arnd <><
