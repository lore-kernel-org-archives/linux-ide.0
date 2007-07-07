From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 7 Jul 2007 20:07:10 +0200
Message-ID: <200707072007.10448.arnd@arndb.de>
References: <20070707094852.9473.21013.stgit@localhost.localdomain> <200707071419.52650.arnd@arndb.de> <468FC4AC.9030701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:52493 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbXGGSO4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 14:14:56 -0400
In-Reply-To: <468FC4AC.9030701@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Saturday 07 July 2007, Sergei Shtylyov wrote:
> Arnd Bergmann wrote:
> 
> >>This adds support for MMIO IDE device like CompactFlash 
> >>in TrueIDE mode.
> 
> >>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com> 
> >>Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> > Hmm, are we still adding new IDE drivers? Do you also have a
> 
>     Yes, why not?

The last time someone (I think Akira Iguchi) wanted to add
a new powerpc specific IDE driver, that was rejected based
on the argument that drivers/ide/ is going away soon. Most
current distros have already moved over to using libata
exclusively.

> > about to add the electra_ide.c driver in 2.6.23, I guess there
> > should really be _one_ driver that is able to handle all
> > of_device based ATA hosts.
> 
>     One driver to rule them all. :-)
>     That may be not so simple as it seems...

It's certainly not easy to support all ATA chips that
have special capabilities and bugs, but the electra and the
mpc8349-itx both seem to support only the most basic ATA
PIO mode anyway, which does not require much special
handling beyond finding the right mmio addresses.

	Arnd <><
