From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patch] atang tree: make SATA Asynchronous Notification work
Date: Sun, 28 Feb 2010 15:31:45 +0100
Message-ID: <201002281531.45149.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:40696 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968176Ab0B1Ocq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2010 09:32:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>

DISCLAIMER: the fact of getting patches merged into atang tree means
that from now on they will be getting updates for changes happening
in atang tree and it should not be treated as an indication regarding
decisions taken by 'upstream' kernel trees


Fix Asynchronous Notification (AN) support for SATA ATAPI devices
(drives which support this feature will send a notification when new
media is inserted and removed, preventing the need for user space to
poll for new media needlessly consuming energy and CPU resources).

Originally AN support was added to kernel in 2007, unfortunately some
relevant bits were lost in the merge process and the feature remains
non-functional in modern Linux distributions.  Lets fix it by adding
kernel patch by Robert Hancock (from Oct 2009) addressing the issue.

User-space part (HAL daemon in particular) still won't automatically
disable media polling but it can be done manually by executing:

  hal-disable-polling --device /dev/sr0

command as root.

[ To check if your ATAPI device supports AN:
  # hdparm -I /dev/sr0|grep "Asynchronous notification"

  To check if it is properly recognized by kernel & user-space:
  $ lshal|grep support_async_notification ]


PS1 if you have PLDS DS-8A3S drive in your laptop (like me) you may
need to update the drive's firmware to the one containing AN support
(HA28 for Asus' OEM drives and HD52 for Dell's ones)

PS2 I will be rebasing atang on top of 2.6.33 in the near future


The following changes since commit cad2f21db052f21beafd44d3396a565d9a485073:
  Bartlomiej Zolnierkiewicz (1):
        block: fix SSD performance regression

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bart/misc.git atang-v4.9

Robert Hancock (1):
      scsi: properly export media change notification capability in block device flags

 drivers/scsi/sd.c |    2 ++
 drivers/scsi/sr.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)
