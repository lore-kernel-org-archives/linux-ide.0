From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze
	system
Date: Thu, 14 Feb 2008 13:42:24 +0100
Message-ID: <20080214124224.GC9708@homac.suse.de>
References: <20080210195556.GA5261@homac> <47AFB4DB.1000204@gmail.com> <20080211100446.GA4646@homac.suse.de> <47B02E96.4050900@gmail.com> <20080211112802.GA4528@homac.suse.de> <47B04984.1020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:42545 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760737AbYBNMld (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 07:41:33 -0500
Content-Disposition: inline
In-Reply-To: <47B04984.1020401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com, jeff@garzik.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On Mon 11. Feb - 22:11:32, Tejun Heo wrote:
> Holger Macht wrote:
> >> It should be called via ata_acpi_{ap|dev}_notify() callbacks installed
> >> via acpi_install_notify_handler().  Can you add dump_stack() in the
> >> function and verify that it actually is being called?  It could be that
> >> the method is called too late or libata takes too long to actually
> >> unplug the device.  Hmmm... It seems what ata_acpi_handle_hotplug() does
> >> isn't enough for undock.  It probably should request detaching the
> >> device instead of just notifying hotplug event.  Anyways, please lemme
> >> know whether and when the function is called.
> > 
> > I already checked, it's never called AFAICS. And I couldn't find a place
> > where it should be installed, otherwise, I would have sent a patch. The
> > dock driver already calls the notify methods on devices in the dock
> > station before doing the real undock.
> 
> ata_acpi_associate() calls acpi_install_notify_handler() for each
> device.  Isn't that enough?

I don't think it is. When the device/bay is inside a dock station, we need
to register for dock events, too. I've sent a patch in a different mail:

 http://lkml.org/lkml/2008/2/14/123

Regards,
	Holger
