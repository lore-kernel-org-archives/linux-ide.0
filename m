From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] Fix for IDE CF card ejection with devfs
Date: Mon, 19 Apr 2004 22:35:04 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404192235.04300.bzolnier@elka.pw.edu.pl>
References: <Pine.LNX.4.58.0404182344470.5575@portland.hansa.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38806 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261996AbUDSUfi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Apr 2004 16:35:38 -0400
In-Reply-To: <Pine.LNX.4.58.0404182344470.5575@portland.hansa.lan>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-ide@vger.kernel.org

On Monday 19 of April 2004 06:13, Pavel Roskin wrote:
> Hello!

Hi,

> If I eject and IDE CompactFlash card, I get a stack dump from
> devfs_remove() because ide/host2/bus0/target0/lun0 doesn't exist.  It's
> not a panic, and everything works, but I want to fix it anyway.  I'm using
> Linux 2.6.6-rc1 with devfs enabled.
>
> What happens is ide_release() in drivers/ide/legacy/ide-cs.c calls
> ide_unregister() in drivers/ide/ide.c.  This function calls
> DRIVER(drive)->cleanup for every drive.  Later is goes through the driver
> list again and unregisters with devfs every drive->devfs_name (which
> happens to be ide/host2/bus0/target0/lun0 in my case).

Yep.

> DRIVER(drive)->cleanup is idedisk_cleanup() from drivers/ide/ide-disk.c
> for disks, and the CompactFlash card is treated like a disk.
> idedisk_cleanup() calls del_gendisk() from fs/partitions/check.c, which
> removes ide/host2/bus0/target0/lun0.  This explains why it fails to be
> removed later in ide_unregister().
>
> Please note that del_gendisk() removes the path from disk->devfs_name.
> It is equal (by value, not by pointer) drive->devfs_name for IDE disks,
> but not for some other devices.  For instance, IDE CD appends "/cd" to the
> end of disk->devfs_name.

>From what I see it shouldn't matter, you should also get it for ide-cd.

> Since the equality of drive->devfs_name and disk->devfs_name is specific
> to IDE disks, it's ide-disk.c that should be fixed.  After del_gendisk()

also ide-floppy.c

> is called from idedisk_cleanup() drive->devfs_name refers to a
> non-existent directory and should be erased, so that ide_unregister()
> doesn't try to remove that directory again.
>
> ide_unregister() only checks for drive->devfs_name[0] being 0, so I
> changed idedisk_cleanup() to set drive->devfs_name[0] to 0.
>
> This fixes the stack dump on CompactFlash card ejection.  The patch is
> attached.
>
> An alternative solution would be to append "/disc" to disk->devfs_name for
> disks.  It's potentially a more intrusive change, but if the IDE
> developers prefer it, I'm ready to make another patch.

I can't see how appending "/disc" to disk->devfs_name can help here.
You will also get a warning but for drive->devfs_name (without "/disc").

I think that correct fix is to remove devfs_remove() from ide_unregister().

Regards,
Bartlomiej

