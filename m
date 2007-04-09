From: <gregkh@suse.de>
Subject: patch ide-proc-remove-rwsem.patch added to gregkh-2.6 tree
Date: Mon, 09 Apr 2007 14:13:05 -0700
Message-ID: <20070409211347.CAFA2C822B6@imap.suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43521 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965851AbXDIVNu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Apr 2007 17:13:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: greg@kroah.com, bzolnier@gmail.com, gregkh@suse.de, linux-ide@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: IDE: remove rwsem use from ide-proc core

to my gregkh-2.6 tree.  Its filename is

     ide-proc-remove-rwsem.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From foo@baz Tue Apr  9 12:12:43 2002
Date: Mon, 9 Apr 2007 11:52:31 -0400 (EDT)
To: Greg KH <greg@kroah.com>
From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: IDE: remove rwsem use from ide-proc core

The subsystem rwsem is not used by the driver core at all, so the use of
it in the ide-proc code of it doesn't make any sense.  Perhaps a local
lock might be needed, but I do not really think so.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux ide <linux-ide@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ide/ide-proc.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -310,14 +310,12 @@ static int proc_ide_read_driver
 	ide_driver_t	*ide_drv;
 	int		len;
 
-	down_read(&dev->bus->subsys.rwsem);
 	if (dev->driver) {
 		ide_drv = container_of(dev->driver, ide_driver_t, gen_driver);
 		len = sprintf(page, "%s version %s\n",
 				dev->driver->name, ide_drv->version);
 	} else
 		len = sprintf(page, "ide-default version 0.9.newide\n");
-	up_read(&dev->bus->subsys.rwsem);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
@@ -327,7 +325,6 @@ static int ide_replace_subdriver(ide_dri
 	int ret = 1;
 	int err;
 
-	down_write(&dev->bus->subsys.rwsem);
 	device_release_driver(dev);
 	/* FIXME: device can still be in use by previous driver */
 	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
@@ -345,7 +342,6 @@ static int ide_replace_subdriver(ide_dri
 	}
 	if (dev->driver && !strcmp(dev->driver->name, driver))
 		ret = 0;
-	up_write(&dev->bus->subsys.rwsem);
 
 	return ret;
 }


Patches currently in gregkh-2.6 which might be from greg@kroah.com are

