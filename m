From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 14:45:41 -0600
Message-ID: <200508111445.41428.bjorn.helgaas@hp.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <42FBB6C5.2070404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:10905 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932348AbVHKUpt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:45:49 -0400
In-Reply-To: <42FBB6C5.2070404@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

On Thursday 11 August 2005 2:36 pm, Jeff Garzik wrote:
> Bjorn Helgaas wrote:
> > IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> > around in I/O port space.  Poking at things that don't exist causes MCAs
> > on HP ia64 systems.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > Index: work-vga/drivers/ide/Kconfig
> > ===================================================================
> > --- work-vga.orig/drivers/ide/Kconfig	2005-08-10 14:57:47.000000000 -0600
> > +++ work-vga/drivers/ide/Kconfig	2005-08-10 14:58:02.000000000 -0600
> > @@ -276,6 +276,7 @@
> >  
> >  config IDE_GENERIC
> >  	tristate "generic/default IDE chipset support"
> > +	depends on !IA64
> 
> hmmmmmmmmm.  Are you POSITIVE that the legacy IDE ports are never enabled?
> 
> In modern Intel chipsets, this still occurs with e.g. combined mode.

I don't know about combined mode.  If the legacy IDE ports are
enabled, shouldn't they be described via ACPI, and hence usable
via the ide_pnp - PNPACPI - ACPI path?
