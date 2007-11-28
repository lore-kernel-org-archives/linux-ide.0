From: Tejun Heo <htejun@gmail.com>
Subject: Re: laptop reboots right after hibernation
Date: Wed, 28 Nov 2007 17:06:18 +0900
Message-ID: <474D217A.6040705@gmail.com>
References: <473730F6.2010900@dbservice.com> <20071118105214.GB7299@ucw.cz> <4740692E.7010801@dbservice.com> <47409DA3.7070909@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.183]:53275 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757371AbXK1IGZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 03:06:25 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2362069roc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 00:06:25 -0800 (PST)
In-Reply-To: <47409DA3.7070909@dbservice.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Tomas Carnecky wrote:
> I kindof had suspected that. The docking station has an ultrabay slot
> where I currently have a cdrom drive (since the notebook itself doesn't
> have any cdrom drive. Once I took the cdrom drive out, I was able to
> successfully perform what I wanted to do in points 3a and 5!
> 
> The 'undock' button probably doesn't tell the kernel that it should
> unload the cdrom driver. Even though after pressing the undock button
> the drive becomes unusable (the green led that is on the side of the
> ultrabay disables and it's impossible to open the tray). Though pressing
> the undock button causes the usb ports to be removed from the kernel, at
> least that's what dmesg suggests (I put the notebook into the dock,
> waited a bit and then pressed the undock button):

That undock button generate an ACPI event, right?  You probably need
to hook that ACPI event such that something like the following gets
executed.

echo 1 > /sys/device/pci0000:00/0000:00:1f.1/host?/target?:?:?:?/?:?:?:?/delete"

> usb 1-4: new high speed USB device using ehci_hcd and address 11
> usb 1-4: configuration #1 chosen from 1 choice
> hub 1-4:1.0: USB hub found
> hub 1-4:1.0: 4 ports detected
> ACPI: \_SB_.GDCK - docking
> ACPI: \_SB_.GDCK - undocking
> usb 1-4: USB disconnect, address 11

USB is capable of detecting hotplug event by itself.  Unfortunately,
ata_piix can't and in your case accessing non existent device is
resulting machine reset.  I don't know why tho.  It usually just
causes a bunch of timeouts before libata EH gives up on the device.

> The notebook+dock+STR works as long as the notebook doesn't know about
> the ultrabay device. That can be because the notebook was started
> outside of the docking station, or inside the docking station but with
> the ultrabay removed. But once the notebook sees the ultrabay device
> it's over. As little as one suspend/resume cycle inside the docking
> station and with a ultrabay device plugged in is enough to make the
> kernel (partially) recognize the device - the kernel doesn't recognize
> the device as a cdrom drive, but only as an UDMA/33 device. After one
> suspend/resume cycle I see this in dmesg:

Do you have sr_mod loaded?

> ata4.00: ACPI cmd ef/03:45:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)
> ata4: failed to recover some devices, retrying in 5 secs
> Coming out of suspend...
> [... snip ...]
> ata4.00: ACPI cmd ef/03:45:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)

That's your BIOS trying to set UDMA UDMA5 on the drive and the drive
not liking it for some reason.

> ata4.00: ACPI on devcfg failed the second time, disabling (errno=-5)
> ata4.00: revalidation failed (errno=1)

After two tries, libata thinks BIOS is no good and decides to turn off
ACPI.

> ata4: failed to recover some devices, retrying in 5 secs
> ata4.00: configured for UDMA/33

Which results in successful configuration, yay.

> And after that I can't resume outside of the docking station. So the
> description of point 3 was incomplete, sorry about that.

Can you please post...

* full boot log with the ultra bay occupied.

* the result of "hdparm -I /dev/sr0" with the ultra bay occupied.

* the result of "lspci -nnvvv" with the ultra bay occupied.

* full boot log without docking station.

* the result of "lspci -nnvvv" without docking station.

Thanks.

-- 
tejun
