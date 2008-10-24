From: "David Ellingsworth" <david@identd.dyndns.org>
Subject: Promise PDC20376
Date: Fri, 24 Oct 2008 10:04:56 -0400
Message-ID: <30353c3d0810240704n7476cc50y28b3eb8a5f326626@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:2000 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbYJXOE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2008 10:04:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so980816fgg.17
        for <linux-ide@vger.kernel.org>; Fri, 24 Oct 2008 07:04:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I recently purchased a Seagate 1.5 TB drive to attach to the Promise
Fasttrak SATA 376 (PDC20376) controller on my Asus A7V8X motherboard.
After installing the drive, I went into the FastTrak setup and
configured a simple array which consisted only of this drive. At this
point I noticed the FastTrak setup could not identify the drive's
size, none the less it reported the array as functional upon reboot
and showed what appeared to be the Cylinder/Sectors/Head count for the
array. Next, I proceeded to install a rather recent copy of Kbuntu
with kernel version 2.6.20. The Kbuntu installer found the array and
installed without incident. However upon trying to boot into the newly
installed copy of Linux, Grub stopped at stage 1.5 with an error code
of 17. I've read that this error code is usually the result of Grub
not being able to identify the type of file system or that Grub's
drive mapping didn't match the one used by the bios. As I only have
the one drive in the system, it seems unlikely that Grub was
misconfigured.

Upon having little success installing Linux, I attempted to install
Windows XP to see if it's boot loader suffered from the same problem.
To my surprise, the Windows boot loader also halted with an error. The
error was "A drive read error has occurred. Please press Ctrl+Alt+Del
to restart." As a result of both Linux and Windows failing to boot, I
believe this problem may be a result of firmware/bios used for the
on-board Promise SATA controller, which unfortunately is embedded in
the system bios.

Asus's technical support indicated that even if this is the case they
will _not_ release an updated bios for this board. In any event, there
are a few things I have yet to try. Like (1) trying the latest kernel
version and sata_promise driver during install, (2) using a newer
version of Grub, and (3) attempting to boot the drive using another
SATA controller. If neither 1 nor 2 correct the issue and the drive
operates fine under 3 then my only option is to update the
firmware/bios for the on-board controller to see if it resolves the
issue.

The current firmware/bios version of the controller as reported by
FastTrak is 1.00.0.21 which is provided with the latest Asus bios
release for this motherboard. After a lot of searching I have been
unable to find a firmware/bios revision newer than the one I currently
have for this chip. However, I did see that Promise has a 1.00.0.37
bios/firmware for their FastTrak S150 TX2plus card. This card uses
their PDC20371 chip and the features it provides seem fairly similar
to those of the PDC20376, but it's unknown if its firmware/bios would
be compatible with the PDC20376.

I'm therefore left wondering what differences exist between these two
chips and whether or not using the firmware/bios for the PDC20371 with
the PDC20376 could cause any major damage. Can anyone familiar with
these chips foresee any issues or problems with doing something like
this?

Regards,

David Ellingsworth
