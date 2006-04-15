From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 04/22] isd200: limit to BLK_DEV_IDE
Date: Sat, 15 Apr 2006 13:51:03 +0200
Message-ID: <20060415115103.GD15022@stusta.de>
References: <20060413230141.330705000@quad.kroah.org> <20060413230714.GE5613@kroah.com> <443F01CC.3080609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60173 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932498AbWDOLvG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Apr 2006 07:51:06 -0400
Content-Disposition: inline
In-Reply-To: <443F01CC.3080609@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <gregkh@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, mdharm-usb@one-eyed-alien.net, usb-storage@lists.one-eyed-alien.net, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Thu, Apr 13, 2006 at 09:58:36PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >-stable review patch.  If anyone has any objections, please let us know.
> >
> >------------------
> >
> >From: Randy Dunlap <rdunlap@xenotime.net>
> >
> >Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
> >are set to (y, m) since isd200 calls ide_fix_driveid() in the
> >BLK_DEV_IDE code.
> >
> >Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >
> >---
> > drivers/usb/storage/Kconfig |    3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >--- linux-2.6.16.5.orig/drivers/usb/storage/Kconfig
> >+++ linux-2.6.16.5/drivers/usb/storage/Kconfig
> >@@ -48,7 +48,8 @@ config USB_STORAGE_FREECOM
> > 
> > config USB_STORAGE_ISD200
> > 	bool "ISD-200 USB/ATA Bridge support"
> >-	depends on USB_STORAGE && BLK_DEV_IDE
> >+	depends on USB_STORAGE
> >+	depends on BLK_DEV_IDE=y || BLK_DEV_IDE=USB_STORAGE
> 
> Wouldn't 'select' be more appropriate for IDE?

Your suggestion sounds like a good idea for 2.6.17, but for -stable I'd 
prefer this patch.

What bothers me more is that this doesn't seem to be fixed in any way in 
Linus' tree...

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

