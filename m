From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] fix libata kernel-doc warnings
Date: Sun, 30 Apr 2006 20:56:54 -0700
Message-ID: <20060430205654.854d324f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:4242 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750712AbWEADya (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Apr 2006 23:54:30 -0400
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 30 Apr 2006 20:54:28 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warnings in libata-core.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/libata-core.c |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2617-rc3.orig/drivers/scsi/libata-core.c
+++ linux-2617-rc3/drivers/scsi/libata-core.c
@@ -864,6 +864,9 @@ static unsigned int ata_id_xfermask(cons
 /**
  *	ata_port_queue_task - Queue port_task
  *	@ap: The ata_port to queue port_task for
+ *	@fn: workqueue function to call
+ *	@data: workqueue function parameter
+ *	@delay: jiffies to delay before calling @fn
  *
  *	Schedule @fn(@data) for execution after @delay jiffies using
  *	port_task.  There is one port_task per port and it's the
@@ -2739,6 +2742,8 @@ static unsigned int ata_dev_set_xfermode
  *	ata_dev_init_params - Issue INIT DEV PARAMS command
  *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
+ *	@heads: Number of heads
+ *	@sectors: Number of sectors per track
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -4302,6 +4307,7 @@ int ata_device_resume(struct ata_port *a
  *	ata_device_suspend - prepare a device for suspend
  *	@ap: port the device is connected to
  *	@dev: the device to suspend
+ *	@state: target power-management state
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.


---
