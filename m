From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fixups to ATA ACPI hotplug
Date: Tue, 20 May 2008 15:00:59 +0100
Message-ID: <20080520140059.GA6471@srcf.ucam.org>
References: <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506092653.GB4378@homac> <20080506093628.GA12469@srcf.ucam.org> <20080519162934.GA15623@srcf.ucam.org> <20080520074442.GA14417@homac> <20080520102038.GA2441@srcf.ucam.org> <20080520131831.GA568@homac> <20080520132217.GA5633@srcf.ucam.org> <20080520135828.GA3167@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080520135828.GA3167@homac>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 20, 2008 at 03:58:30PM +0200, Holger Macht wrote:

> Handle bay devices in dock stations
> 
> * Differentiate between bay devices in dock stations and others:
> 
>  - When an ACPI_NOTIFY_EJECT_REQUEST appears, just signal uevent to
>    userspace (that is when the optional eject button on a bay device is
>    pressed/pulled) giving the possibility to unmount file systems and to
>    clean up. Also, only send uevent in case we get an EJECT_REQUEST
>    without doing anything else. In other cases, you'll get an add/remove
>    event because libata attaches/detaches the device.
> 
>  - In case of a dock event, which in turn signals an
>    ACPI_NOTIFY_EJECT_REQUEST, immediately detach the device, because it
>    may already have been gone
> 
> * In case of an ACPI_NOTIFY_DEVICE/BUS_CHECK, evaluate _STA to check if
>   the device has been plugged or unplugged. If plugged, hotplug it, if
>   unplugged, just signal event to userspace
>   (initial patch by Matthew Garrett <mjg59@srcf.ucam.org>)
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>

As long as this fixes the hang on dock removal, this looks good to me.

Acked-by: Matthew Garrett <mjg@redhat.com>
-- 
Matthew Garrett | mjg59@srcf.ucam.org
