From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: 2.6.17-rc5-mm3: oops when ejecting dock
Date: Tue, 06 Jun 2006 17:16:52 -0700
Message-ID: <1149639412.13089.85.camel@whizzy>
References: <4483EB38.30609@goop.org> <1149554579.6006.10.camel@whizzy>
	 <4484D244.3010905@goop.org> <1149634494.13089.53.camel@whizzy>
	 <44861109.7090502@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30322 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751382AbWFGAFd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 20:05:33 -0400
In-Reply-To: <44861109.7090502@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Tue, 2006-06-06 at 16:34 -0700, Jeremy Fitzhardinge wrote:
> Kristen Accardi wrote:
> > So, here is a patch which will fix the bug.  The problem that I found
> > after I fixed the bug occurs in this circumstance:
> > 1.  boot in ultrabase
> > 2.  undock
> >
> > But not in this case:
> > 1.  boot outside base
> > 2.  dock/undock etc.
> >
> > The symptom of the problem is that you will undock and your machine will
> > get a softlockup on a CPU and just hang.  Checking the log file (when
> > possible) shows lots errors from hdc: and ide: (this ultrabase has a
> > cdrom on it which would be hdc).  I am using an x40 to duplicate the
> > issue, so you may have a different experience than I do.  The problem
> > seems to be that the cdrom that is on the ultrabase is not unplugging
> > gracefully.  I may have to hook up with whoever is working on the ide
> > hotplug and see if this is something I can fix.
> >
> > Incidentally, the reason it works fine when you boot outside the base
> > and then dock/undock is because the cdrom is also not getting properly
> > inserted.  So, it appears to power it on, but it is not actually being
> > hotplugged.
> 
> I've observed this without the acpi dock driver present.
> 
> I was wondering if the ibm acpi ultrabay file ("bay") entry could be 
> used to "eject" the optical device.  It doesn't appear on the X60 
> (listed as "not supported"), probably because the ACPI name changed to 
> SATA from than IDE0; I haven't really looked into it yet.  But I think 
> the basic problem is that the IDE layer doesn't seem to support hot 
> add/remove of devices.
> 

Using the eject file won't help for a couple of other reasons besides
just the name change.  First, it requires that the device be present at
boot.  Second, AFAIK it just calls the device's _EJ0 method, which I
don't think is really the only thing that is needed here.  I think we
also need a generic way to do this without using the ibm driver.  You
could scan the acpi namespace for IDE controllers based on checking for
some methods that are used only in IDE or SATA devices and write a acpi
driver to handle insert/remove events, but it seems like for device
hotplug though you'd still somehow need to rescan from ide.  To me it
seems unwise to do anything outside the ide subsystem other than notify
of an event and call some handler or something.


> I guess that means that at present the acpi dock driver does nothing, 
> but it at least gives us an event to hang the ata device events off once 
> the subsystem supports hot (or even warm) device add/remove.
> 
>     J
