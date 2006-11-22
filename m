From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] sgiioc4: Disable module unload
Date: Wed, 22 Nov 2006 21:29:23 +0100
Message-ID: <58cb370e0611221229s46550e24j3f8f61fa8631448c@mail.gmail.com>
References: <20061121031552.GA73433@sgi.com>
	 <20061121172816.63495f1f.akpm@osdl.org>
	 <20061122015952.GH75625@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:60627 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756955AbWKVU30 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Nov 2006 15:29:26 -0500
Received: by nf-out-0910.google.com with SMTP id o25so634545nfa
        for <linux-ide@vger.kernel.org>; Wed, 22 Nov 2006 12:29:25 -0800 (PST)
In-Reply-To: <20061122015952.GH75625@sgi.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On 11/22/06, Jeremy Higdon <jeremy@sgi.com> wrote:
> On Tue, Nov 21, 2006 at 05:28:16PM -0800, Andrew Morton wrote:
> > On Mon, 20 Nov 2006 19:15:52 -0800
> > Jeremy Higdon <jeremy@sgi.com> wrote:
> >
> > > This patch removes a module_exit function that it sgiioc4 should not have had.
> > >
> > > Signed-off-by: Jeremy Higdon <jeremy@sgi.com>
> > >
> > >
> > > --- linux-2.6.19-rc6/drivers/ide/pci/sgiioc4.c      2006-11-15 20:03:40.000000000 -0800
> > > +++ linux-2.6.19-rc6-mod/drivers/ide/pci/sgiioc4.c  2006-11-20 18:45:08.506724280 -0800
> > > @@ -768,14 +768,7 @@
> > >     return ioc4_register_submodule(&ioc4_ide_submodule);
> > >  }
> > >
> > > -static void __devexit
> > > -ioc4_ide_exit(void)
> > > -{
> > > -   ioc4_unregister_submodule(&ioc4_ide_submodule);
> > > -}
> > > -
> > >  late_initcall(ioc4_ide_init); /* Call only after IDE init is done */
> > > -module_exit(ioc4_ide_exit);
> > >
> > >  MODULE_AUTHOR("Aniket Malatpure/Jeremy Higdon");
> > >  MODULE_DESCRIPTION("IDE PCI driver module for SGI IOC4 Base-IO Card");
> >
> > Why?  We'd prefer that the module be unloadable, wouldn't we?

not supported in the current IDE layer model
(lack of dynamic allocation for ide_hwifs[] and some needed locking)

> It seems that the IDE layer doesn't support that.  sgiioc4 was the only
> driver in drivers/ide/pci that had an exit function.  After an unload,
> the devices would stay around and the next attempt to reference would
> crash...

ack

Andrew, please apply.

Bart
