From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata: fix kernel-doc warnings
Date: Fri, 10 Feb 2006 21:58:32 -0800
Message-ID: <20060210215832.58107a0f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:47524 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751218AbWBKF5t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 00:57:49 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 21:57:48 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>, akpm <akpm@osdl.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warnings in libata drivers.
One of them was in the wrong place.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/ata_piix.c    |    3 ++-
 drivers/scsi/libata-core.c |   30 +++++++++++++++++-------------
 drivers/scsi/libata-scsi.c |    3 ++-
 3 files changed, 21 insertions(+), 15 deletions(-)

--- linux-2616-rc2g9.orig/drivers/scsi/ata_piix.c
+++ linux-2616-rc2g9/drivers/scsi/ata_piix.c
@@ -627,9 +627,10 @@ static int piix_disable_ahci(struct pci_
 
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
+ *	@ata_dev: the PCI device to check
  *	
  *	Check for the present of 450NX errata #19 and errata #25. If
- *	they are found return an error code so we can turn off DMA
+ *	they are found return an error code so we can turn off DMA.
  */
 
 static int __devinit piix_check_450nx_errata(struct pci_dev *ata_dev)
--- linux-2616-rc2g9.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc2g9/drivers/scsi/libata-core.c
@@ -4212,19 +4212,6 @@ err_out:
 }
 
 
-/**
- *	ata_port_start - Set port up for dma.
- *	@ap: Port to initialize
- *
- *	Called just after data structures for each port are
- *	initialized.  Allocates space for PRD table.
- *
- *	May be used as the port_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
  * without filling any other registers
@@ -4276,6 +4263,8 @@ static int ata_start_drive(struct ata_po
 
 /**
  *	ata_device_resume - wakeup a previously suspended devices
+ *	@ap: target ata_port
+ *	@dev: target ata_device
  *
  *	Kick the drive back into action, by sending it an idle immediate
  *	command and making sure its transfer mode matches between drive
@@ -4298,6 +4287,8 @@ int ata_device_resume(struct ata_port *a
 
 /**
  *	ata_device_suspend - prepare a device for suspend
+ *	@ap: target ata_port
+ *	@dev: target ata_device
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
@@ -4315,6 +4306,19 @@ int ata_device_suspend(struct ata_port *
 	return 0;
 }
 
+/**
+ *	ata_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
--- linux-2616-rc2g9.orig/drivers/scsi/libata-scsi.c
+++ linux-2616-rc2g9/drivers/scsi/libata-scsi.c
@@ -2517,7 +2517,8 @@ out_unlock:
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@id: current IDENTIFY data for target device.
+ *	@ap: target ata_port
+ *	@dev: target ata_device
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *


---
