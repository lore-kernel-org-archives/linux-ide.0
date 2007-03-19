From: Holger Macht <hmacht@suse.de>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 16:47:28 +0100
Message-ID: <20070319154726.GA7774@homac2>
References: <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070319132243.GA2869@srcf.ucam.org> <20070319134822.GA4885@homac2.suse.de> <20070319140403.GA3697@srcf.ucam.org> <20070319153659.GB15942@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070319153659.GB15942@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon 19. Mar - 12:36:59, Henrique de Moraes Holschuh wrote:
> On Mon, 19 Mar 2007, Matthew Garrett wrote:
> > > But you still have to deal with mounted filesystems, no matter if it a
> > > cardbus or a cdrom. Wouldn't we need something like 'save removal'
> > > triggered from userspace like you maybe know from 'the other' operating
> > > system?
> > 
> > Yes, there's a need for a mechanism to deal with all of this safely, but 
> > the same is true of any storage device that can be hotplugged (USB, 
> > firewire, anything in a hotplug bay...)
> 
> True.  The best available procedure to do this for ACPI bay/dock currently
> is, AFAIK:
> 
> 1. Send event when bay/dock "please release" button/lever is pressed. Do
> *nothing* else.  I know bay does this right, maybe dock doesn't.

Yes, the dock driver just does the undock, without any event.

As you know, the "please release" mechanism is how it works with
ibm_acpi. ACPI event comes through proc and userspace does echo undock >
....That would also be my favourite because it already works quite
well. Just without generic docking.

> 2. Wait for something to echo 1 >eject or to call the appropriate routine
> directly, or (if this exists) for an notification from firmware that the
> user IS disconnecting the device for real.
> 
> 3. delete the device.  This means force-umount, force-close, etc.
> 
> 4. Tell the hardware to eject.
> 
> 
> Note that currently (2) and (3) are swapped, as (3) is being done by
> userspace request, instead of by the kernel.  This is something I *don't*
> like.  IMO should do as PCMCIA and hotplug PCI does, and do that in kernel
> space.

Right.

> The time window where one can ask the user something or notify it is not a
> good idea to eject is between (1) and (2).  If the eject command is issued,
> delete devices (includes sync, of course) and eject.

Yes, at this point in time, userspace is required to have finished the
tasks it is responsible for.

Regards,
	Holger
