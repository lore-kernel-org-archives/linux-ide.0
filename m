From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] Fix for IDE CF card ejection with devfs
Date: Tue, 20 Apr 2004 00:41:52 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404200041.52443.bzolnier@elka.pw.edu.pl>
References: <Pine.LNX.4.58.0404182344470.5575@portland.hansa.lan> <200404192235.04300.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.58.0404191823370.22550@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63151 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261181AbUDSWmS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Apr 2004 18:42:18 -0400
In-Reply-To: <Pine.LNX.4.58.0404191823370.22550@marabou.research.att.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-ide@vger.kernel.org

On Tuesday 20 of April 2004 00:30, Pavel Roskin wrote:
> On Mon, 19 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> > > DRIVER(drive)->cleanup is idedisk_cleanup() from drivers/ide/ide-disk.c
> > > for disks, and the CompactFlash card is treated like a disk.
> > > idedisk_cleanup() calls del_gendisk() from fs/partitions/check.c, which
> > > removes ide/host2/bus0/target0/lun0.  This explains why it fails to be
> > > removed later in ide_unregister().
> > >
> > > Please note that del_gendisk() removes the path from disk->devfs_name.
> > > It is equal (by value, not by pointer) drive->devfs_name for IDE disks,
> > > but not for some other devices.  For instance, IDE CD appends "/cd" to
> > > the end of disk->devfs_name.
> >
> > From what I see it shouldn't matter, you should also get it for ide-cd.
>
> [snip]
>
> > I think that correct fix is to remove devfs_remove() from
> > ide_unregister().
>
> I thought of it, but it won't work with IDE CD.  If I remove
> devfs_remove() from ide_unregister() and make ide-cd a module,
> /dev/ide/host0/bus1/target0/lun0/cd disappears on ide-cd unload, but
> /dev/ide/host0/bus1/target0/lun0/ stays.
>
> That's because disk->devfs_name was ide/host0/bus1/target0/lun0/cd whereas
> drive->devfs_name was ide/host0/bus1/target0/lun0.  devfs_remove_disk()
> would remove the former but not the later.

Can you point me to a place where drive->devfs_name is registered?

Bartlomiej

