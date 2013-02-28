From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Resend][PATCH] ACPI / glue: Drop .find_bridge() callback from
 struct acpi_bus_type
Date: Wed, 27 Feb 2013 18:33:13 -0800
Message-ID: <20130228023313.GC4042@kroah.com>
References: <2612891.I2roH54cPk@vostro.rjw.lan>
 <20130227222032.GA28616@kroah.com>
 <1723405.gTrRpVTGu2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1723405.gTrRpVTGu2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Feb 28, 2013 at 02:11:58AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 27, 2013 02:20:32 PM Greg Kroah-Hartman wrote:
> > On Wed, Feb 27, 2013 at 11:06:52PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > After PCI has stopped using the .find_bridge() callback in
> > > struct acpi_bus_type, the only remaining users of it are SATA and
> > > USB.  However, SATA only pretends to be a user, because it points
> > > that callback to a stub always returning -ENODEV, and USB uses it
> > > incorrectly, because as a result of the way it is used by USB every
> > > device in the system that doesn't have a bus type or parent is
> > > passed to usb_acpi_find_device() for inspection.
> > > 
> > > What USB actually needs, though, is to call usb_acpi_find_device()
> > > for USB ports that don't have a bus type defined, but have
> > > usb_port_device_type as their device type.
> > 
> > Ick, that's not good.  Can you have the original creator of that code
> > (someone else from Intel, I can't remember at the moment), fix that up
> > properly and send me patches?
> 
> That won't be necessary afer this patch.  Or do you want to fix up USB
> separately first?

No, sorry, my misunderstanding, I was assuming we still needed to do
other USB work after this.  If not, that's an even better reason to
accept this patch :)

thanks,

greg k-h
