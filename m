From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] ACPI / glue: Add .match() callback to struct
 acpi_bus_type
Date: Thu, 28 Feb 2013 21:07:06 -0800
Message-ID: <20130301050706.GB25192@kroah.com>
References: <2612891.I2roH54cPk@vostro.rjw.lan>
 <20130228023313.GC4042@kroah.com>
 <1504144.f1SBuDyFqp@vostro.rjw.lan>
 <194591401.DiJi7SfL1g@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <194591401.DiJi7SfL1g@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Feb 28, 2013 at 10:53:21PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> USB uses the .find_bridge() callback from struct acpi_bus_type
> incorrectly, because as a result of the way it is used by USB every
> device in the system that doesn't have a bus type or parent is
> passed to usb_acpi_find_device() for inspection.
> 
> What USB actually needs, though, is to call usb_acpi_find_device()
> for USB ports that don't have a bus type defined, but have
> usb_port_device_type as their device type, as well as for USB
> devices.
> 
> To fix that replace the struct bus_type pointer in struct
> acpi_bus_type used for matching devices to specific subsystems
> with a .match() callback to be used for this purpose and update
> the users of struct acpi_bus_type, including USB, accordingly.
> Define the .match() callback routine for USB, usb_acpi_bus_match(),
> in such a way that it will cover both USB devices and USB ports
> and remove the now redundant .find_bridge() callback pointer from
> usb_acpi_bus.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
