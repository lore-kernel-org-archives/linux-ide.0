From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.17-rc5-mm3: oops when ejecting dock
Date: Tue, 06 Jun 2006 16:34:33 -0700
Message-ID: <44861109.7090502@goop.org>
References: <4483EB38.30609@goop.org> <1149554579.6006.10.camel@whizzy>	 <4484D244.3010905@goop.org> <1149634494.13089.53.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1149634494.13089.53.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Kristen Accardi wrote:
> So, here is a patch which will fix the bug.  The problem that I found
> after I fixed the bug occurs in this circumstance:
> 1.  boot in ultrabase
> 2.  undock
>
> But not in this case:
> 1.  boot outside base
> 2.  dock/undock etc.
>
> The symptom of the problem is that you will undock and your machine will
> get a softlockup on a CPU and just hang.  Checking the log file (when
> possible) shows lots errors from hdc: and ide: (this ultrabase has a
> cdrom on it which would be hdc).  I am using an x40 to duplicate the
> issue, so you may have a different experience than I do.  The problem
> seems to be that the cdrom that is on the ultrabase is not unplugging
> gracefully.  I may have to hook up with whoever is working on the ide
> hotplug and see if this is something I can fix.
>
> Incidentally, the reason it works fine when you boot outside the base
> and then dock/undock is because the cdrom is also not getting properly
> inserted.  So, it appears to power it on, but it is not actually being
> hotplugged.

I've observed this without the acpi dock driver present.

I was wondering if the ibm acpi ultrabay file ("bay") entry could be 
used to "eject" the optical device.  It doesn't appear on the X60 
(listed as "not supported"), probably because the ACPI name changed to 
SATA from than IDE0; I haven't really looked into it yet.  But I think 
the basic problem is that the IDE layer doesn't seem to support hot 
add/remove of devices.

I guess that means that at present the acpi dock driver does nothing, 
but it at least gives us an event to hang the ata device events off once 
the subsystem supports hot (or even warm) device add/remove.

    J
