From: Greg KH <greg@kroah.com>
Subject: Re: Intel ICH9M bug : sata unusable with usbserial
Date: Tue, 1 Mar 2011 09:16:27 -0500
Message-ID: <20110301141627.GB12881@kroah.com>
References: <20110228140149.GA18189@frolo.macqel>
 <20110228150553.66d02bc7@lxorguk.ukuu.org.uk>
 <20110228151618.GA16322@htj.dyndns.org>
 <20110228170556.GA29545@frolo.macqel>
 <20110228173634.GA23008@htj.dyndns.org>
 <20110228192700.GA3305@kroah.com>
 <20110301123452.GA1954@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58130 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234Ab1CAOWj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Mar 2011 09:22:39 -0500
Content-Disposition: inline
In-Reply-To: <20110301123452.GA1954@frolo.macqel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
Cc: Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On Tue, Mar 01, 2011 at 01:34:52PM +0100, Philippe De Muyter wrote:
> previously we had all but one usb interrupts on the same line as ata_piix :
>   5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
> while now they are spread on different lines : 16, 18, 19, 21 and 22
> 
> So I wonder if there is still a bug, but that it is not triggered anymore.
> 
> Is there a way to tell which interrupt line the USB GPS receiver is connected
> to ?

See which USB bus the device is on, using lsusb.  It should match up
with the usbX number in the above list.

Glad enabling APIC in your BIOS fixed this.

thanks,

greg k-h
