From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: pci_get_device_reverse(), why does Calgary need this?
Date: Wed, 13 Feb 2008 13:34:12 +0100
Message-ID: <200802131334.12351.bzolnier@gmail.com>
References: <20080213001506.GA13933@kroah.com> <20080213021737.72b9815d@core> <20080213044536.GC10101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:37264 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbYBMMUb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 07:20:31 -0500
Received: by rn-out-0910.google.com with SMTP id i24so7779976rng.19
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 04:20:28 -0800 (PST)
In-Reply-To: <20080213044536.GC10101@kroah.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Wednesday 13 February 2008, Greg KH wrote:
> On Wed, Feb 13, 2008 at 02:17:37AM +0000, Alan Cox wrote:
> > > Why does the calgary driver need this?  Can we just use pci_get_device()
> > > instead?  Why do you need to walk the device list backwards?  Do you get
> > > false positives going forward?
> > 
> > It doesn't look to be performance critical so the driver can
> > pci_get_device until the end and use the final hit anyway.
> 
> That would make more sense.
> 
> > IDE reverse is more problematic but nobody seems to use it.
> 
> I've seen two posters say they use it.  I'm wondering what it is really
> solving if they use it, and why if it's really needed, scsi never had to
> implement such a hack...

It is no longer solving anything, just adds more pain. ;)

[ The option comes from 2.2.x (so long before LABEL=/ and /dev/disk/by-id/
  became popular).  Some "off-board" controllers integrated on motherboards
  used to appear before "on-board" IDE on PCI bus so this option was meant
  to preserve the legacy ordering. ]

Since it is valid only when "Probe IDE PCI devices in the PCI bus order
(DEPRECATED)" config option is used it is already on its way out (though
marking it as obsoleted would make it more explicit).

I think that removing "ide=reverse" in 2.6.26 would be OK...

Thanks,
Bart
