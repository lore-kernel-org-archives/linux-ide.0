From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6.19 patch] drivers/ide/pci/generic.c: re-add the __setup("all-generic-ide",...)
Date: Thu, 19 Oct 2006 18:13:38 +0200
Message-ID: <20061019161338.GT3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061017155934.GC3502@stusta.de> <4534C7A7.7000607@hp.com> <20061018221520.GK3502@stusta.de> <20061018231844.GA16857@devserv.devel.redhat.com> <20061019152651.GR3502@stusta.de> <20061019090741.853ea100.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48906 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946177AbWJSQNl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Oct 2006 12:13:41 -0400
Content-Disposition: inline
In-Reply-To: <20061019090741.853ea100.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alan Cox <alan@redhat.com>, Patrick Jefferson <henj@hp.com>, Kenny Graunke <kenny@whitecape.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Oct 19, 2006 at 09:07:41AM -0700, Randy Dunlap wrote:
> On Thu, 19 Oct 2006 17:26:51 +0200 Adrian Bunk wrote:
>...
> > --- linux-2.6/drivers/ide/pci/generic.c.old	2006-10-19 16:35:15.000000000 +0200
> > +++ linux-2.6/drivers/ide/pci/generic.c	2006-10-19 16:46:21.000000000 +0200
> > @@ -40,6 +40,19 @@
> >  
> >  static int ide_generic_all;		/* Set to claim all devices */
> >  
> > +/*
> > + * the module_param_named() was added for the modular case
> > + * the __setup() is left as compatibility for existing setups
> > + */
> > +#ifndef MODULE
> > +static int __init ide_generic_all_on(char *unused)
> > +{
> > +	ide_generic_all = 1;
> > +	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.");
> > +	return 1;
> > +}
> > +__setup("all-generic-ide", ide_generic_all_on);
> > +#endif
> >  module_param_named(all_generic_ide, ide_generic_all, bool, 0444);
> >  MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE storage controllers.");
> 
> Missing update to Documentation/kernel-parameters.txt ?
> (maybe it's been missing forever?)

It's been missing forever.

I'm not sure whether documenting it now where it's deprecated and nearly 
dead makes sense..

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

