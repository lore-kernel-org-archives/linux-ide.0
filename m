From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix for IDE CF card ejection with devfs
Date: Mon, 19 Apr 2004 00:13:50 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0404182344470.5575@portland.hansa.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_f7zLm74uQi30fqQYnhSfDQ)"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cmail.srv.hcvlny.cv.net ([167.206.112.40]:4501 "EHLO
	cmail.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264290AbUDSEPA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Apr 2004 00:15:00 -0400
Received: from portland.hansa.lan
 (ool-435328fe.dyn.optonline.net [67.83.40.254]) by cmail.srv.hcvlny.cv.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HWE00L59H350T@cmail.srv.hcvlny.cv.net> for
 linux-ide@vger.kernel.org; Mon, 19 Apr 2004 00:13:53 -0400 (EDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_f7zLm74uQi30fqQYnhSfDQ)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hello!

If I eject and IDE CompactFlash card, I get a stack dump from
devfs_remove() because ide/host2/bus0/target0/lun0 doesn't exist.  It's
not a panic, and everything works, but I want to fix it anyway.  I'm using
Linux 2.6.6-rc1 with devfs enabled.

What happens is ide_release() in drivers/ide/legacy/ide-cs.c calls
ide_unregister() in drivers/ide/ide.c.  This function calls
DRIVER(drive)->cleanup for every drive.  Later is goes through the driver
list again and unregisters with devfs every drive->devfs_name (which
happens to be ide/host2/bus0/target0/lun0 in my case).

DRIVER(drive)->cleanup is idedisk_cleanup() from drivers/ide/ide-disk.c
for disks, and the CompactFlash card is treated like a disk.
idedisk_cleanup() calls del_gendisk() from fs/partitions/check.c, which
removes ide/host2/bus0/target0/lun0.  This explains why it fails to be
removed later in ide_unregister().

Please note that del_gendisk() removes the path from disk->devfs_name.
It is equal (by value, not by pointer) drive->devfs_name for IDE disks,
but not for some other devices.  For instance, IDE CD appends "/cd" to the
end of disk->devfs_name.

Since the equality of drive->devfs_name and disk->devfs_name is specific
to IDE disks, it's ide-disk.c that should be fixed.  After del_gendisk()
is called from idedisk_cleanup() drive->devfs_name refers to a
non-existent directory and should be erased, so that ide_unregister()
doesn't try to remove that directory again.

ide_unregister() only checks for drive->devfs_name[0] being 0, so I
changed idedisk_cleanup() to set drive->devfs_name[0] to 0.

This fixes the stack dump on CompactFlash card ejection.  The patch is
attached.

An alternative solution would be to append "/disc" to disk->devfs_name for
disks.  It's potentially a more intrusive change, but if the IDE
developers prefer it, I'm ready to make another patch.

-- 
Regards,
Pavel Roskin

--Boundary_(ID_f7zLm74uQi30fqQYnhSfDQ)
Content-id: <Pine.LNX.4.58.0404190013500.5575@portland.hansa.lan>
Content-type: TEXT/plain; charset=US-ASCII; name=ide-disk-devfs.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=ide-disk-devfs.diff
Content-description: 

--- linux.orig/drivers/ide/ide-disk.c
+++ linux/drivers/ide/ide-disk.c
@@ -1695,6 +1695,7 @@ static int idedisk_cleanup (ide_drive_t 
 	if (ide_unregister_subdriver(drive))
 		return 1;
 	del_gendisk(g);
+	drive->devfs_name[0] = '\0';
 	g->fops = ide_fops;
 	return 0;
 }

--Boundary_(ID_f7zLm74uQi30fqQYnhSfDQ)--
