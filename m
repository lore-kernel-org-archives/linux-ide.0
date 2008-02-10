From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: is there a value to CONFIG_NO_ATA_LEGACY?
Date: Sun, 10 Feb 2008 18:05:46 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802101805070.16164@localhost.localdomain>
References: <alpine.LFD.1.00.0802101442240.14742@localhost.localdomain> <20080210225410.3c28deeb@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:43768 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbYBJXGC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 18:06:02 -0500
In-Reply-To: <20080210225410.3c28deeb@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Sun, 10 Feb 2008, Alan Cox wrote:

> On Sun, 10 Feb 2008 14:44:16 -0500 (EST)
> "Robert P. J. Day" <rpjday@crashcourse.ca> wrote:
>
> >
> >   in drivers/ata/libata-sff.c:
> >
> > ...
> > #if defined(CONFIG_NO_ATA_LEGACY)
> >                 /* Some platforms with PCI limits cannot address compat
> >                    port space. In that case we punt if their firmware has
> >                    left a device in compatibility mode */
> >                 if (legacy_mode) {
> >                         printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
> >                         return -EOPNOTSUPP;
> >                 }
> > #endif
> > ...
> >
> >   there is no Kconfig file that defines that variable -- should that
> > test be removed?  or is something eventually coming that defines it?
>
> It is used by some of the unsubmitted tree stuff certainly and is there
> because some platforms will need it (eg FRV).

ok, good enough, i'm just trying to cull my list of unreferenced
Kconfig variables.

rday
--


========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

Home page:                                         http://crashcourse.ca
Fedora Cookbook:    http://crashcourse.ca/wiki/index.php/Fedora_Cookbook
========================================================================
