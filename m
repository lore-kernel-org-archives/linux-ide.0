From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [git patch] atang tree: make SATA Asynchronous Notification work
Date: Sun, 28 Feb 2010 11:52:23 -0600
Message-ID: <51f3faa71002280952p479dd795ue6a4e4a06b67e6f8@mail.gmail.com>
References: <201002281531.45149.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:49535 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab0B1RwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2010 12:52:24 -0500
In-Reply-To: <201002281531.45149.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 28, 2010 at 8:31 AM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> DISCLAIMER: the fact of getting patches merged into atang tree means
> that from now on they will be getting updates for changes happening
> in atang tree and it should not be treated as an indication regarding
> decisions taken by 'upstream' kernel trees
>
>
> Fix Asynchronous Notification (AN) support for SATA ATAPI devices
> (drives which support this feature will send a notification when new
> media is inserted and removed, preventing the need for user space to
> poll for new media needlessly consuming energy and CPU resources).
>
> Originally AN support was added to kernel in 2007, unfortunately some
> relevant bits were lost in the merge process and the feature remains
> non-functional in modern Linux distributions. =A0Lets fix it by addin=
g
> kernel patch by Robert Hancock (from Oct 2009) addressing the issue.
>
> User-space part (HAL daemon in particular) still won't automatically
> disable media polling but it can be done manually by executing:
>
> =A0hal-disable-polling --device /dev/sr0
>
> command as root.
>
> [ To check if your ATAPI device supports AN:
> =A0# hdparm -I /dev/sr0|grep "Asynchronous notification"
>
> =A0To check if it is properly recognized by kernel & user-space:
> =A0$ lshal|grep support_async_notification ]
>
>
> PS1 if you have PLDS DS-8A3S drive in your laptop (like me) you may
> need to update the drive's firmware to the one containing AN support
> (HA28 for Asus' OEM drives and HD52 for Dell's ones)
>
> PS2 I will be rebasing atang on top of 2.6.33 in the near future
>
>
> The following changes since commit cad2f21db052f21beafd44d3396a565d9a=
485073:
> =A0Bartlomiej Zolnierkiewicz (1):
> =A0 =A0 =A0 =A0block: fix SSD performance regression
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/bart/misc.git atang-=
v4.9
>
> Robert Hancock (1):
> =A0 =A0 =A0scsi: properly export media change notification capability=
 in block device flags
>
> =A0drivers/scsi/sd.c | =A0 =A02 ++
> =A0drivers/scsi/sr.c | =A0 =A02 ++
> =A02 files changed, 4 insertions(+), 0 deletions(-)

I think that patch is still applicable, but as you noted it doesn't
really have much effect on HAL by itself other than reporting the
"supports asynchronous notification" flag, there's nothing in HAL that
automatically stops polling when that's detected (at least last I
checked).

As I recall the new HAL replacement (DeviceKit-disks I believe)
doesn't depend on that particular flag to detect AN support.
