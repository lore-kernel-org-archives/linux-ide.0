From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze	system
Date: Mon, 11 Feb 2008 20:16:38 +0900
Message-ID: <47B02E96.4050900@gmail.com>
References: <20080210195556.GA5261@homac> <47AFB4DB.1000204@gmail.com> <20080211100446.GA4646@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:46746 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYBKLQq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 06:16:46 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4735312wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 03:16:45 -0800 (PST)
In-Reply-To: <20080211100446.GA4646@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com, jeff@garzik.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Hello,

Holger Macht wrote:
>> In the above example, even the reset sequence itself can cause hang if
>> the hardware is implemented slightly differently.  The reason why
>> set_piomode() locks up but reset sequence doesn't is simple dumb luck.
>> I think the proper fix is to tell libata to detach the cdrom before
>> undocking.
> 
> Wouldn't the proper fix be to call ata_acpi_handle_hotplug _somewhere_?
> (which is currently called nowhere AFAICS)

It should be called via ata_acpi_{ap|dev}_notify() callbacks installed
via acpi_install_notify_handler().  Can you add dump_stack() in the
function and verify that it actually is being called?  It could be that
the method is called too late or libata takes too long to actually
unplug the device.  Hmmm... It seems what ata_acpi_handle_hotplug() does
isn't enough for undock.  It probably should request detaching the
device instead of just notifying hotplug event.  Anyways, please lemme
know whether and when the function is called.

> Anyway, kernel hackers keep telling me that the kernel should just do the
> right thing. Shouldn't userspace never be able to freeze the system?

Yeah, I think most things should be done automatically but it's true
that somethings are a bit awkward to handle in kernel.  Also, if you're
root, you can almost always crash the machine from userland.

> It's completely ok for me to handle this from userspace, if that's the
> position of the libata developers.

Let's see whether we can fix the ACPI handler first.

> In this case, we should change the dock driver to default to
> immediate_undock=false, because otherwise it's far too risky to freeze the
> system.

I'm not too familiar with how docks work.  Can you please explain
briefly what immediate_undock is?

Thanks.

-- 
tejun
