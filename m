From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICH9M bug : sata unusable with usbserial
Date: Mon, 28 Feb 2011 11:27:01 -0800
Message-ID: <20110228192700.GA3305@kroah.com>
References: <20110228140149.GA18189@frolo.macqel>
 <20110228150553.66d02bc7@lxorguk.ukuu.org.uk>
 <20110228151618.GA16322@htj.dyndns.org>
 <20110228170556.GA29545@frolo.macqel>
 <20110228173634.GA23008@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110228173634.GA23008-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 28, 2011 at 06:36:34PM +0100, Tejun Heo wrote:
> On Mon, Feb 28, 2011 at 06:05:56PM +0100, Philippe De Muyter wrote:
> >   5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
> 
> So, usb7 and ata_piix share the same IRQ line.
> 
> > [    1.517781] usb 7-1: New USB device found, idVendor=067b, idProduct=2303
> > [    1.517837] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > [    1.517883] usb 7-1: Product: USB-Serial Controller
> > [    1.517928] usb 7-1: Manufacturer: Prolific Technology Inc.
> ...
> > [    4.327431] usbcore: registered new interface driver usbserial
> > [    4.327585] USB Serial support registered for generic
> > [    4.327747] usbcore: registered new interface driver usbserial_generic
> > [    4.327774] usbserial: USB Serial Driver core
> ...
> > [    4.419657] USB Serial support registered for pl2303
> ...
> > [    4.431805] usb 7-1: pl2303 converter now attached to ttyUSB0
> > [    4.431846] usbcore: registered new interface driver pl2303
> > [    4.431875] pl2303: Prolific PL2303 USB to serial adaptor driver
> 
> I believe this is the GPS thingie?
> 
> ...
> > [  175.706014] ata1: lost interrupt (Status 0x50)
> > [  175.706040] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> > [  175.706050] ata1.00: failed command: READ DMA
> > [  175.706062] ata1.00: cmd c8/00:08:28:41:01/00:00:00:00:00/e1 tag 0 dma 4096 in
> > [  175.706064]          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> > [  175.706079] ata1.00: status: { DRDY }
> 
> There was no screaming IRQ but it definitely looks like IRQ delivery
> is gone at this point.
> 
> > [  175.706091] ata1: hard resetting link
> > [  176.162049] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > [  181.165024] ata1.00: qc timeout (cmd 0x27)
> > [  181.165034] ata1.00: failed to read native max address (err_mask=0x4)
> > [  181.165043] ata1.00: revalidation failed (errno=-5)
> 
> Hardreset and IDENTIFY are executed by polling on ata_piix and
> READ_NATIVE_MAX is the first command executed using IRQ and that's the
> first thing in the recovery sequence which fails.
> 
> > [  181.165054] ata1: hard resetting link
> > [  181.621053] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > [  191.624025] ata1.00: qc timeout (cmd 0x27)
> > [  191.624036] ata1.00: failed to read native max address (err_mask=0x4)
> > [  191.624045] ata1.00: revalidation failed (errno=-5)
> > [  191.624053] ata1: limiting SATA link speed to 1.5 Gbps
> > [  191.624065] ata1: hard resetting link
> > [  192.080046] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> > [  202.083023] ata1.00: qc timeout (cmd 0x27)
> > [  202.083033] ata1.00: failed to read native max address (err_mask=0x4)
> > [  202.083042] ata1.00: revalidation failed (errno=-5)
> > [  202.083049] ata1.00: disabled
> > [  202.083066] ata1: hard resetting link
> 
> And it never comes back.  Specifying kernel parameter 'irqpoll' might
> help but it looks like somehow the GPS thingie kills the IRQ line
> completely.
> 
> cc'ing Greg and linux-usb.  Hey, USB folks, it seems accessing a USB
> GPS device kills IRQ delivery to ata_piix sharing the same IRQ line as
> the USB host.  Any ideas on what's going on?  The original messages
> can be read from...
> 
>   http://www.spinics.net/lists/linux-ide/msg40425.html
>   http://www.spinics.net/lists/linux-ide/msg40428.html

That really sounds like an interrupt issue that is higher up than the
USB host driver, or the ata drivers.

ACPI perhaps?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
