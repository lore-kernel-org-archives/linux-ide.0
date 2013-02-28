From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] ACPI / glue: Drop .find_bridge() callback from struct acpi_bus_type
Date: Fri, 01 Mar 2013 00:37:51 +0100
Message-ID: <3242723.ZVP4iiJczV@vostro.rjw.lan>
References: <2612891.I2roH54cPk@vostro.rjw.lan> <1995794.TENtrAZA5Q@vostro.rjw.lan> <512FD687.7060904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <512FD687.7060904@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thursday, February 28, 2013 05:13:27 PM Jeff Garzik wrote:
> On 02/28/2013 04:53 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After PCI and USB have stopped using the .find_bridge() callback in
> > struct acpi_bus_type, the only remaining user of it is SATA, but SATA
> > only pretends to be a user, because it points that callback to a stub
> > always returning -ENODEV.
> >
> > For this reason, drop the SATA's dummy .find_bridge() callback and
> > remove .find_bridge(), which is not used any more, from struct
> > acpi_bus_type entirely.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/glue.c       |   26 +-------------------------
> >   drivers/ata/libata-acpi.c |    6 ------
> >   include/acpi/acpi_bus.h   |    3 ---
> >   3 files changed, 1 insertion(+), 34 deletions(-)
> 
> patches 1-2 Acked-by: Jeff Garzik <jgarzik@pobox.com>

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
