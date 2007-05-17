From: chrisw@sous-sol.org
Subject: patch sata_via-add-missing-pm-hooks.patch queued to 2.6.21-stable tree
Date: Wed, 16 May 2007 18:52:20 -0700
Message-ID: <200705170152.l4H1qKWh028403@sous-sol.org>
References: <463B357A.4090703@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:48355 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757272AbXEQByE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 21:54:04 -0400
In-Reply-To: <463B357A.4090703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, chrisw@sous-sol.org, jeff@garzik.org, jeroen.janssen@gmail.com, linux-ide@vger.kernel.org
Cc: stable@kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: sata_via: add missing PM hooks

to the 2.6.21-stable tree.  Its filename is

     sata_via-add-missing-pm-hooks.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From stable-bounces@linux.kernel.org  Fri May  4 06:32:42 2007
Message-ID: <463B357A.4090703@gmail.com>
Date: Fri, 04 May 2007 15:30:34 +0200
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org
Cc: Jeroen Janssen <jeroen.janssen@gmail.com>
Subject: sata_via: add missing PM hooks

For some reason, sata_via is missing PM hooks.  Add them.  Spotted by
Jeroen Janssen <jeroen.janssen@gmail.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jeroen Janssen <jeroen.janssen@gmail.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/ata/sata_via.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.21.1.orig/drivers/ata/sata_via.c
+++ linux-2.6.21.1/drivers/ata/sata_via.c
@@ -97,6 +97,10 @@ static struct pci_driver svia_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= svia_pci_tbl,
 	.probe			= svia_init_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+#endif
 	.remove			= ata_pci_remove_one,
 };
 
@@ -116,6 +120,10 @@ static struct scsi_host_template svia_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations vt6420_sata_ops = {


Patches currently in stable-queue which might be from htejun@gmail.com are

queue-2.6.21/driver-core-don-t-free-devt_attr-till-the-device-is-released.patch
queue-2.6.21/libata-sff-undo-bug-introduced-with-pci_iomap-changes.patch
queue-2.6.21/pci-quirks-disable-msi-on-rs400-200-and-rs480.patch
queue-2.6.21/sata_via-add-missing-pm-hooks.patch
