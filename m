From: Holger Macht <hmacht@suse.de>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 15:37:46 +0100
Message-ID: <20070319143746.GC4885@homac2.suse.de>
References: <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070319132243.GA2869@srcf.ucam.org> <20070319134822.GA4885@homac2.suse.de> <20070319140403.GA3697@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070319140403.GA3697@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon 19. Mar - 14:04:03, Matthew Garrett wrote:
> On Mon, Mar 19, 2007 at 02:48:22PM +0100, Holger Macht wrote:
> 
> >   1. libata integration into the bay driver
> 
> It actually makes sense to tie all PATA/SATA devices to their ACPI 
> handles where appropriate - there's already code to do that in 
> libata-acpi.c, but it would be nicer if it was integrated in the same 
> way that PCI devices are.
> 
> >   2. The dock station driver has to inform the bay driver that an undock
> >      event took place, right?
> 
> Yeah.
> 
> > But you still have to deal with mounted filesystems, no matter if it a
> > cardbus or a cdrom. Wouldn't we need something like 'save removal'
> > triggered from userspace like you maybe know from 'the other' operating
> > system?
> 
> Yes, there's a need for a mechanism to deal with all of this safely, but 
> the same is true of any storage device that can be hotplugged (USB, 
> firewire, anything in a hotplug bay...)

Sure. What actually bothers me is that in its current state, the dock
station driver signals 'green' on the dock station as soon as the user
presses the hardware undock button, but regardlessly of anything else. I
think it would be ok to let the ACPI undock event up to userspace because
in many situations it knows best when it is save to undock.

Regards,
	Holger

