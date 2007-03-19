From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 11:04:12 -0700
Message-ID: <20070319110412.ea6f4363.kristen.c.accardi@intel.com>
References: <200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com>
	<20070318082751.GA28591@homac2>
	<20070318183652.GB29422@khazad-dum.debian.net>
	<20070318185529.GA14885@homac2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7954 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030461AbXCSSGm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 14:06:42 -0400
In-Reply-To: <20070318185529.GA14885@homac2>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org

On Sun, 18 Mar 2007 19:55:30 +0100
Holger Macht <hmacht@suse.de> wrote:

> On Sun 18. Mar - 15:36:52, Henrique de Moraes Holschuh wrote:
> > On Sun, 18 Mar 2007, Holger Macht wrote:
> > > those ThinkPads where it is needed. Afterwards it does the corresponding
> > > dock/undock request on ibm_acpi. And this works reliably good what I can
> > > see from the feedback I already got. But for this to work, userspace would
> > 
> > It should work with the generic bay device too, but I have no ideas about
> > dock.  But you'll need to deal with udev with the new bay device, something
> > I am not too happy about.  These things are ACPI events, they should remain
> > so unless all other ACPI events are going to become uevents.
> 
> It doesn't work, I've already tried. The bay driver only emits an event if
> you really try to remove the bay, but not on docking/undocking.
> 
> Regards,
> 	Holger
> 

this *should* work.  The Bay driver registers with the dock driver to get
dock events:

        /* if we are on a dock station, we should register for dock
         * notifications.
         */
        if (bay_is_dock_device(handle)) {
                bay_dprintk(handle, "Is dependent on dock\n");
                register_hotplug_dock_device(handle, bay_notify, new_bay);
        }
 

then, on undock the dock driver calls the bay_notify function and passes
it the EJECT request event.  This causes the bay driver to emit an event to
userspace.

        case ACPI_NOTIFY_EJECT_REQUEST:
                kobject_uevent(&dev->kobj, KOBJ_CHANGE);
                break;
        default:
 

an event to userspace.
