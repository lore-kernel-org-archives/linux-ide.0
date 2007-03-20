From: Holger Macht <hmacht@suse.de>
Subject: Re: CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 17:07:07 +0100
Message-ID: <20070320160707.GB6079@homac2.suse.de>
References: <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070319132243.GA2869@srcf.ucam.org> <20070319134822.GA4885@homac2.suse.de> <20070319140403.GA3697@srcf.ucam.org> <20070319143746.GC4885@homac2.suse.de> <20070319111109.1a62740b.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:33320 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872AbXCTQHP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 12:07:15 -0400
Content-Disposition: inline
In-Reply-To: <20070319111109.1a62740b.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org

On Mon 19. Mar - 11:11:09, Kristen Carlson Accardi wrote:
> On Mon, 19 Mar 2007 15:37:46 +0100
> Holger Macht <hmacht@suse.de> wrote:
> 
> > Sure. What actually bothers me is that in its current state, the dock
> > station driver signals 'green' on the dock station as soon as the user
> > presses the hardware undock button, but regardlessly of anything else. I
> > think it would be ok to let the ACPI undock event up to userspace because
> > in many situations it knows best when it is save to undock.
> 
> I disagree - as I mentioned, not all laptops actually let you (userspace)
> control the undock process because they don't lock.  The dock driver
> does notify user space of an undock, before it actually undocks:

Yes, I know that, but userspace won't have enough time to interact with
the user in this case. I just imagine having an external disk connected to
the usb port of the docking station. In the moment the user undocks, his
unsynced or unwritten data is lost because the usb port gets
disconnected. The user needs the knowledge to actually "save remove" the
external disk before he undocks. You are right, this won't help in case
the dock station has no indication when it is "safe" to undock. 

> 
>         /*
>          * here we need to generate the undock
>          * event prior to actually doing the undock
>          * so that the device struct still exists.
>          */
>         dock_event(ds, event, UNDOCK_EVENT);
>         hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
>         undock(ds);
>         eject_dock(ds);
>  
> 
> We even notify other subsystems of our intent to undock prior to actually
> doing it.  
