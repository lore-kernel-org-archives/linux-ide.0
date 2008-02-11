From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze
	system
Date: Mon, 11 Feb 2008 15:06:03 +0100
Message-ID: <20080211140603.GA4576@homac.suse.de>
References: <20080210195556.GA5261@homac> <47AFB4DB.1000204@gmail.com> <20080211100446.GA4646@homac.suse.de> <47B02E96.4050900@gmail.com> <20080211112802.GA4528@homac.suse.de> <47B04984.1020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:45843 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbYBKOFP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 09:05:15 -0500
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

It should be. I tried once more and noticed that
ata_acpi_handle_hotplug(...) is called when the cdrom is about to be
removed via the bay driver (just removing the device, not the whole dock
station). Actually there is a connection between the bay and the dock
driver, and one of them should notice that the cdrom/bay device is
dependent on the dock, but I don't know what's going wrong here. Kristen
(CC) should definitely know more about this interaction...

On a related note, shouldn't ata_acpi_handle_hotplug delete the device
like what is done when doing

  echo 1 > /sys/devices/.../block/sr0/device/delete

?

Regards,
	Holger
