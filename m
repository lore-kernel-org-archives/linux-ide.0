From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: laptop reboots right after hibernation
Date: Sun, 18 Nov 2007 21:16:35 +0100
Message-ID: <47409DA3.7070909@dbservice.com>
References: <473730F6.2010900@dbservice.com> <20071118105214.GB7299@ucw.cz> <4740692E.7010801@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753709AbXKRUQ7@vger.kernel.org>
In-Reply-To: <4740692E.7010801@dbservice.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Since this is becoming more an IDE/ATA issue, I added
linux-ide@vger.kernel.org to CC. I hope that's the right mailinglist.

Tomas Carnecky wrote:
> (3) Once the notebook was in the docking station (whether I boot it
> while in the dock or boot it outside and then put it into the dock) and
> I take it out (press the 'undock' button on the dock, wait for the green
> led, then take out the notebook) things get interesting:
> 
> (a) I initiate STR, notebook correctly goes to sleep, but it only wakes
> up if I have it in the docking station. If I try to wake it up outside
> of the docking station it will fail.

  Magic number: 0:971:888
  hash matches drivers/base/power/main.c:82
  hash matches device ptyuf
  hash matches device 0000:00:1f.1

00:1f.1 IDE interface: Intel Corporation Mobile IDE Controller (rev 03)

> (5) If the notebook is in the dock, I press the undock button and wait
> for the green led then initiate STR, I can take the notebook out but
> resuming doesn't work - unless I resume it while the notebook is back in
> the docking station (see point 3a)

  Magic number: 0:648:888
  hash matches drivers/base/power/main.c:103
  hash matches device ptyuf
  hash matches device 0000:00:1f.1

00:1f.1 IDE interface: Intel Corporation Mobile IDE Controller (rev 03)


I kindof had suspected that. The docking station has an ultrabay slot
where I currently have a cdrom drive (since the notebook itself doesn't
have any cdrom drive. Once I took the cdrom drive out, I was able to
successfully perform what I wanted to do in points 3a and 5!

The 'undock' button probably doesn't tell the kernel that it should
unload the cdrom driver. Even though after pressing the undock button
the drive becomes unusable (the green led that is on the side of the
ultrabay disables and it's impossible to open the tray). Though pressing
the undock button causes the usb ports to be removed from the kernel, at
least that's what dmesg suggests (I put the notebook into the dock,
waited a bit and then pressed the undock button):

usb 1-4: new high speed USB device using ehci_hcd and address 11
usb 1-4: configuration #1 chosen from 1 choice
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
ACPI: \_SB_.GDCK - docking
ACPI: \_SB_.GDCK - undocking
usb 1-4: USB disconnect, address 11

The notebook+dock+STR works as long as the notebook doesn't know about
the ultrabay device. That can be because the notebook was started
outside of the docking station, or inside the docking station but with
the ultrabay removed. But once the notebook sees the ultrabay device
it's over. As little as one suspend/resume cycle inside the docking
station and with a ultrabay device plugged in is enough to make the
kernel (partially) recognize the device - the kernel doesn't recognize
the device as a cdrom drive, but only as an UDMA/33 device. After one
suspend/resume cycle I see this in dmesg:

ata4.00: ACPI cmd ef/03:45:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)
ata4: failed to recover some devices, retrying in 5 secs
Coming out of suspend...
[... snip ...]
ata4.00: ACPI cmd ef/03:45:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)
ata4.00: ACPI on devcfg failed the second time, disabling (errno=-5)
ata4.00: revalidation failed (errno=1)
ata4: failed to recover some devices, retrying in 5 secs
ata4.00: configured for UDMA/33

And after that I can't resume outside of the docking station. So the
description of point 3 was incomplete, sorry about that.

At least the two failures 3a and 5 can be explained...

tom
