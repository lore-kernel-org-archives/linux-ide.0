From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [Resend][PATCH] ACPI / glue: Drop .find_bridge() callback from
 struct acpi_bus_type
Date: Wed, 27 Feb 2013 15:31:08 -0800
Message-ID: <CAE9FiQVEBZy+HP+tthD_C_gJ_6v2be-pGCD0A4TE0z+c8MHXtA@mail.gmail.com>
References: <2612891.I2roH54cPk@vostro.rjw.lan>
	<20130227222032.GA28616@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62831 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab3B0XbJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2013 18:31:09 -0500
In-Reply-To: <20130227222032.GA28616@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Wed, Feb 27, 2013 at 2:20 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Feb 27, 2013 at 11:06:52PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> After PCI has stopped using the .find_bridge() callback in
>> struct acpi_bus_type, the only remaining users of it are SATA and
>> USB.  However, SATA only pretends to be a user, because it points
>> that callback to a stub always returning -ENODEV, and USB uses it
>> incorrectly, because as a result of the way it is used by USB every
>> device in the system that doesn't have a bus type or parent is
>> passed to usb_acpi_find_device() for inspection.
>>
>> What USB actually needs, though, is to call usb_acpi_find_device()
>> for USB ports that don't have a bus type defined, but have
>> usb_port_device_type as their device type.
>
> Ick, that's not good.  Can you have the original creator of that code
> (someone else from Intel, I can't remember at the moment), fix that up
> properly and send me patches?

[Add To: Lan Tianyu <tianyu.lan@intel.com>]

>
>> Please let me know if there are any objections.

I still prefer to ask USB to add bus_type instead at first.

Thanks

Yinghai
