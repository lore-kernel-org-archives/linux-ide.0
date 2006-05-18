From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata-core: fix current kernel-doc warnings
Date: Thu, 18 May 2006 10:50:18 -0700
Message-ID: <20060518105018.4696f8c5.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:41429 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932075AbWERRrw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 13:47:52 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 10:47:49 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix all current kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/libata-core.c |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2617-rc4g6.orig/drivers/scsi/libata-core.c
+++ linux-2617-rc4g6/drivers/scsi/libata-core.c
@@ -864,6 +864,9 @@ static unsigned int ata_id_xfermask(cons
 /**
  *	ata_port_queue_task - Queue port_task
  *	@ap: The ata_port to queue port_task for
+ *	@fn: workqueue function to be scheduled
+ *	@data: data value to pass to workqueue function
+ *	@delay: delay time for workqueue function
  *
  *	Schedule @fn(@data) for execution after @delay jiffies using
  *	port_task.  There is one port_task per port and it's the
@@ -2739,6 +2742,8 @@ static unsigned int ata_dev_set_xfermode
  *	ata_dev_init_params - Issue INIT DEV PARAMS command
  *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
+ *	@heads: Number of heads (taskfile parameter)
+ *	@sectors: Number of sectors (taskfile parameter)
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -4302,6 +4307,7 @@ int ata_device_resume(struct ata_port *a
  *	ata_device_suspend - prepare a device for suspend
  *	@ap: port the device is connected to
  *	@dev: the device to suspend
+ *	@state: target power management state
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.


---
