From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Problem with IDE driver not claiming the disk
Date: Tue, 6 Dec 2005 01:34:18 +0100
Message-ID: <58cb370e0512051634l323e922cxabb713a96ec72cab@mail.gmail.com>
References: <1133826994.8181.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.202]:1886 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751524AbVLFAeV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:21 -0500
Received: by nproxy.gmail.com with SMTP id m18so70383nfc
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2005 16:34:19 -0800 (PST)
In-Reply-To: <1133826994.8181.68.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott James Remnant <scott@ubuntu.com>
Cc: linux-ide@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net

On 12/6/05, Scott James Remnant <scott@ubuntu.com> wrote:
> Hi there,
>
> We've been having some IDE problems at Ubuntu Towers and can't seem to
> figure out what's up, and I was hoping you guys might instantly spot
> what we're doing wrong ...
>
> In order to get the root filesystem mounted (we're in initramfs at this
> point), we do the following steps:
>
> 1) Run udevd.
>
>    This has rules configured to load the ide-cd, ide-disk, ide-floppy or
>    ide-tape modules when a device matching SUBSYSYTEM=="ide" is added.
>    We decide which module to load by looking at /proc/ide/ide*/*/media
>    (after waiting for that to turn up)
>
>    This also has the standard rules to modprobe $MODALIAS, should that
>    be set.
>
> 2) Look in /sys/bus/pci/devices for those with a class of 0x01* (storage
>    devices), and write to the uevent file of each.
>
>
> This results in ide-core being loaded, along with the appropriate driver
> for the IDE controller and the "generic" module.  On my laptop (an HP
> nc4010) I get the alim15x3 driver, on a colleague's (Acer 1520 AMD64) he
> gets the via82cxxx driver.
>
> At this point, there is nothing in /proc/ide other than an empty
> "drivers" file, and nothing in /sys/bus/ide/devices -- though this
> directory does now exist.
>
> In particular there are also no events for any devices on the bus...
>
>
> In order to get those events, and find out what's on the bus, we
> explicitly load the "ide-generic" driver.  This spawns a whole number of
> events, creating a whole array of devices -- /dev/hda* and friends.

This sounds very, very wrong.  Devices should be probed and
registered by alim15x3/via82cxxx and not ide-generic driver.

> The ide-disk module is loaded as a result of these events.
>
>
> On my laptop with the alim15x3 driver, the disks appear to be bound to
> this driver; in particular the following is true:
>
>         # readlink /sys/bus/ide/devices/0.0
>         ../../../devices/pci0000:00/0000:00:10.0/ide0/0.0
>
>         # readlink /sys/devices/pci0000:00/0000:00:10.0/driver
>         ../../../bus/pci/drivers/ALI15x3_IDE
>
> However on the via82cxx laptop we see:
>
>         # readlink /sys/bus/ide/devices/0.0
>         ../../../devices/pci0000:00/0000:00:11.1/ide0/0.0
>
>         # readlink /sys/devices/pci0000:00/0000:00:11.1/driver
>         ../../../bus/pci/drivers/PCI_IDE
>
> It looks like the device is being claimed by the ide-generic driver, and
> not the VIA one.
>
> Do you concur?  What are we doing wrong, or what is the driver doing
> wrong?

We can only guess without dmesg and lspci -vvv.

You didn't even tell your kernel version and whether this
is vanilla kernel or Ubuntu one (do you have any extra
IDE patches?).

Bartlomiej
