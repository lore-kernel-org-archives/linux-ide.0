From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PATA: RPC now selects HAVE_PATA_PLATFORM for pata platform driver
Date: Mon, 29 Sep 2008 17:44:39 +0100
Message-ID: <20080929164439.GA8298@flint.arm.linux.org.uk>
References: <20080926171251.731613895@fluff.org.uk> <48E05AB5.8070106@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48499 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYI2QpZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 12:45:25 -0400
Content-Disposition: inline
In-Reply-To: <48E05AB5.8070106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org

On Mon, Sep 29, 2008 at 12:33:57AM -0400, Jeff Garzik wrote:
> Ben Dooks wrote:
> >The RPC machine type now selects HAVE_PATA_PLATFORM so we can remove
> >the special case in the PATA_PLATFORM configuration code.
> >
> >Cc: Russell King <rmk@arm.linux.org.uk>
> >Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Interestingly, the version posted to the ARM lists has:

| The RPC machine type now selects HAVE_PATA_PLATFORM so we can remove
| the special case in the PATA_PLATFORM configuration code.
| 
| Acked-by: Russell King <rmk@arm.linux.org.uk>
| Signed-off-by: Ben Dooks <ben-linux@fluff.org>

as the comments... I don't think I acked it, and I certainly wouldn't
have acked it with that address.  So, no idea what Ben's playing at.

But anyway...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> >
> >Index: linux-2.6.26-rc5-quilt1/drivers/ata/Kconfig
> >===================================================================
> >--- linux-2.6.26-rc5-quilt1.orig/drivers/ata/Kconfig	2008-06-10 
> >12:38:03.000000000 +0100
> >+++ linux-2.6.26-rc5-quilt1/drivers/ata/Kconfig	2008-06-10 
> >12:38:03.000000000 +0100
> >@@ -661,7 +661,7 @@ config HAVE_PATA_PLATFORM
> > 
> > config PATA_PLATFORM
> > 	tristate "Generic platform device PATA support"
> >-	depends on EMBEDDED || ARCH_RPC || PPC || HAVE_PATA_PLATFORM
> >+	depends on EMBEDDED || PPC || HAVE_PATA_PLATFORM
> > 	help
> > 	  This option enables support for generic directly connected ATA
> > 	  devices commonly found on embedded systems.
> 
> applied
> 
> 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
