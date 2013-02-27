From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Resend][PATCH] ACPI / glue: Drop .find_bridge() callback from
 struct acpi_bus_type
Date: Wed, 27 Feb 2013 14:20:32 -0800
Message-ID: <20130227222032.GA28616@kroah.com>
References: <2612891.I2roH54cPk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:58265 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab3B0WUf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2013 17:20:35 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so653081pbc.14
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2013 14:20:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2612891.I2roH54cPk@vostro.rjw.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Yinghai Lu <yinghai@kernel.org>

On Wed, Feb 27, 2013 at 11:06:52PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After PCI has stopped using the .find_bridge() callback in
> struct acpi_bus_type, the only remaining users of it are SATA and
> USB.  However, SATA only pretends to be a user, because it points
> that callback to a stub always returning -ENODEV, and USB uses it
> incorrectly, because as a result of the way it is used by USB every
> device in the system that doesn't have a bus type or parent is
> passed to usb_acpi_find_device() for inspection.
> 
> What USB actually needs, though, is to call usb_acpi_find_device()
> for USB ports that don't have a bus type defined, but have
> usb_port_device_type as their device type.

Ick, that's not good.  Can you have the original creator of that code
(someone else from Intel, I can't remember at the moment), fix that up
properly and send me patches?

> Please let me know if there are any objections.

No objection from me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

