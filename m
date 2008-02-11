From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze	system
Date: Mon, 11 Feb 2008 22:11:32 +0900
Message-ID: <47B04984.1020401@gmail.com>
References: <20080210195556.GA5261@homac> <47AFB4DB.1000204@gmail.com> <20080211100446.GA4646@homac.suse.de> <47B02E96.4050900@gmail.com> <20080211112802.GA4528@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:45819 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbYBKNLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 08:11:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2166473wah.23
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 05:11:39 -0800 (PST)
In-Reply-To: <20080211112802.GA4528@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com, jeff@garzik.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Holger Macht wrote:
>> It should be called via ata_acpi_{ap|dev}_notify() callbacks installed
>> via acpi_install_notify_handler().  Can you add dump_stack() in the
>> function and verify that it actually is being called?  It could be that
>> the method is called too late or libata takes too long to actually
>> unplug the device.  Hmmm... It seems what ata_acpi_handle_hotplug() does
>> isn't enough for undock.  It probably should request detaching the
>> device instead of just notifying hotplug event.  Anyways, please lemme
>> know whether and when the function is called.
> 
> I already checked, it's never called AFAICS. And I couldn't find a place
> where it should be installed, otherwise, I would have sent a patch. The
> dock driver already calls the notify methods on devices in the dock
> station before doing the real undock.

ata_acpi_associate() calls acpi_install_notify_handler() for each
device.  Isn't that enough?

> immediate_undock=1:
>  User presses undock button on the dock station, dock driver calls ACPI
>  undock method immediately.
> 
> immediate_undock=0:
>  User presses undock button on the dock station, dock driver throws uevent
>  and waits for userland to undock the system via sysfs.
> 
> immediate_undock is currently set to 1 by default.

Thanks for the explanation.

-- 
tejun
