From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 26/46] IDE: remove rwsem use from ide-proc core
Date: Fri, 27 Apr 2007 11:53:40 -0700
Message-ID: <11777001333852-git-send-email-gregkh@suse.de>
References: <20070427185152.GA17121@kroah.com>
 <1177700040520-git-send-email-gregkh@suse.de>
 <11777000433552-git-send-email-gregkh@suse.de>
 <11777000471977-git-send-email-gregkh@suse.de>
 <11777000511784-git-send-email-gregkh@suse.de>
 <11777000552084-git-send-email-gregkh@suse.de>
 <1177700059319-git-send-email-gregkh@suse.de>
 <11777000632194-git-send-email-gregkh@suse.de>
 <11777000663361-git-send-email-gregkh@suse.de>
 <1177700070961-git-send-email-gregkh@suse.de>
 <1177700074272-git-send-email-gregkh@suse.de>
 <11777000773819-git-send-email-gregkh@suse.de>
 <11777000814075-git-send-email-gregkh@suse.de>
 <11777000852694-git-send-email-gregkh@suse.de>
 <11777000881307-git-send-email-gregkh@suse.de>
 <11777000923797-git-send-email-gregkh@suse.de>
 <11777000963332-git-send-email-gregkh@suse.de>
 <11777001002860-git-send-email-gregkh@suse.de>
 <11777001041847-git-send-email-gregkh@suse.de>
 <11777001072576-git-send-email-gregkh@suse.de>
 <11777001102852-git-send-email-gregkh@suse.de>
 <1177700114535-git-send-email-gregkh@suse.de>
 <11777001182501-git-send-email-gregkh@suse.de>
 <11777001222882-git-send-email-gregkh@suse.de>
 <1177700125350-git-send-email-gregkh@suse.de>
 <11777001301175-git-send-email-gregkh@suse.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757040AbXD0S7P@vger.kernel.org>
In-Reply-To: <11777001301175-git-send-email-gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

The subsystem rwsem is not used by the driver core at all, so the use of
it in the ide-proc code of it doesn't make any sense.  Perhaps a local
lock might be needed, but I do not really think so.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux ide <linux-ide@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/ide/ide-proc.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index afb71c6..a9e0b30 100644
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
 
@@ -327,7 +325,6 @@ static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
 	int ret = 1;
 	int err;
 
-	down_write(&dev->bus->subsys.rwsem);
 	device_release_driver(dev);
 	/* FIXME: device can still be in use by previous driver */
 	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
@@ -345,7 +342,6 @@ static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
 	}
 	if (dev->driver && !strcmp(dev->driver->name, driver))
 		ret = 0;
-	up_write(&dev->bus->subsys.rwsem);
 
 	return ret;
 }
-- 
1.5.1.2
