From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Tue, 20 Feb 2007 00:17:32 +0100
Message-ID: <200702200017.32924.bzolnier@gmail.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp> <1171920081.18571.77.camel@localhost.localdomain> <20070219234651.4a19a912@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:58011 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965524AbXBSXLa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 18:11:30 -0500
Received: by mu-out-0910.google.com with SMTP id g7so601453muf
        for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2007 15:11:28 -0800 (PST)
In-Reply-To: <20070219234651.4a19a912@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Linas Vepstas <linas@austin.ibm.com>, Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, James K Lewis <jim@jklewis.com>


On Tuesday 20 February 2007 00:46, Alan wrote:
> > > into one in drivers/ide but really want splitting for libata with some
> > > kind of libata-pmac owning the shared stuff
> > 
> > You meand driver/ide/ppc/pmac.c ?
> 
> Yes
> 
> > moving them out of the macio_asic to a PCI device at one point, so yes,
> > maybe you are right, I should move the DMA bits to some "common" file
> > and split the various implementations.
> 
> I suspect it is worth doing when moving to libata at least, even if not
> for the older driver.

fully agreed, the way to go for both drivers

Bart
