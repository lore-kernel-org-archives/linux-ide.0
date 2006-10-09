From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [patch 1/2] libata: _GTF support
Date: Mon, 9 Oct 2006 08:10:37 -0700
Message-ID: <20061009081037.620bb5e3.rdunlap@xenotime.net>
References: <20060927223441.205181000@localhost.localdomain>
	<20060927153627.c931de2d.kristen.c.accardi@intel.com>
	<20061009114150.GA32716@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:49875 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932925AbWJIPJM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Oct 2006 11:09:12 -0400
Received: from midway.site ([71.117.236.95]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 9 Oct 2006 08:09:09 -0700
In-Reply-To: <20061009114150.GA32716@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Seyfried <seife@suse.de>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 9 Oct 2006 13:41:50 +0200 Stefan Seyfried wrote:

> On Wed, Sep 27, 2006 at 03:36:27PM -0700, Kristen Carlson Accardi wrote:
> > _GTF is an acpi method that is used to reinitialize the drive.  It returns
> > a task file containing ata commands that are sent back to the drive to restore
> > it to boot up defaults.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > 
> > ---
> >  Documentation/kernel-parameters.txt |    5 
>  
> > --- 2.6-mm.orig/Documentation/kernel-parameters.txt
> > +++ 2.6-mm/Documentation/kernel-parameters.txt
> > @@ -48,6 +48,7 @@ parameter is applicable:
> >  	ISAPNP	ISA PnP code is enabled.
> >  	ISDN	Appropriate ISDN support is enabled.
> >  	JOY	Appropriate joystick support is enabled.
> > +	LIBATA  Libata driver is enabled
> >  	LP	Printer support is enabled.
> >  	LOOP	Loopback device support is enabled.
> >  	M68k	M68k architecture is enabled.
> > @@ -1013,6 +1014,10 @@ and is between 256 and 4096 characters. 
> >  			emulation library even if a 387 maths coprocessor
> >  			is present.
> >  
> > +	noacpi		[LIBATA] Disables use of ACPI in libata suspend/resume
> > +			when set.
> > +			Format: <int>
> 
> this will confuse users that already think they can disable ACPI with "noacpi"
> (instead of "acpi=off") and that already fight with "noapic". I have seen too
> many confusions of this kind in bugreports.
> 
> Couldn't it be made "libata=noacpi" like we have "pci=noacpi" already?

It only applies to the libata module, so it could be more fully
documented as "libata.noacpi=1" to disable ACPI for libata.
We don't usually do that in Documentation/kernel-parameters.txt,
but there are a few cases/examples of doing so.

Of course, that's for libata built-in the kernel image.  If libata
is a loadable module, it's just
	modprobe libata noacpi=1
or set it in /etc/modprobe.conf.

---
~Randy
