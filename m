From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 1/1] sgiioc4: Disable module unload
Date: Tue, 21 Nov 2006 17:59:52 -0800
Message-ID: <20061122015952.GH75625@sgi.com>
References: <20061121031552.GA73433@sgi.com> <20061121172816.63495f1f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:48301 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S967005AbWKVB7x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2006 20:59:53 -0500
Content-Disposition: inline
In-Reply-To: <20061121172816.63495f1f.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org

On Tue, Nov 21, 2006 at 05:28:16PM -0800, Andrew Morton wrote:
> On Mon, 20 Nov 2006 19:15:52 -0800
> Jeremy Higdon <jeremy@sgi.com> wrote:
> 
> > This patch removes a module_exit function that it sgiioc4 should not have had.
> > 
> > Signed-off-by: Jeremy Higdon <jeremy@sgi.com>
> > 
> > 
> > --- linux-2.6.19-rc6/drivers/ide/pci/sgiioc4.c	2006-11-15 20:03:40.000000000 -0800
> > +++ linux-2.6.19-rc6-mod/drivers/ide/pci/sgiioc4.c	2006-11-20 18:45:08.506724280 -0800
> > @@ -768,14 +768,7 @@
> >  	return ioc4_register_submodule(&ioc4_ide_submodule);
> >  }
> >  
> > -static void __devexit
> > -ioc4_ide_exit(void)
> > -{
> > -	ioc4_unregister_submodule(&ioc4_ide_submodule);
> > -}
> > -
> >  late_initcall(ioc4_ide_init); /* Call only after IDE init is done */
> > -module_exit(ioc4_ide_exit);
> >  
> >  MODULE_AUTHOR("Aniket Malatpure/Jeremy Higdon");
> >  MODULE_DESCRIPTION("IDE PCI driver module for SGI IOC4 Base-IO Card");
> 
> Why?  We'd prefer that the module be unloadable, wouldn't we?

It seems that the IDE layer doesn't support that.  sgiioc4 was the only
driver in drivers/ide/pci that had an exit function.  After an unload,
the devices would stay around and the next attempt to reference would
crash...

Thanks,

jeremy
