From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH #upstream] libata: export local port number through /sys
Date: Thu, 24 Jan 2013 11:52:09 -0600
Message-ID: <1359049929-17069-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46161 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab3AXRpr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2013 12:45:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

Export <global port>.<local port> format through /sys

./pci0000:00/0000:00:1f.2/ata1.1
./pci0000:00/0000:00:1f.2/ata1.1/link1.1/dev1.1.0/ata_device
./pci0000:00/0000:00:1f.2/ata1.1/link1.1/ata_link
./pci0000:00/0000:00:1f.2/ata1.1/ata_port
./pci0000:00/0000:00:1f.2/ata1.1/ata_port/ata1.1
./pci0000:00/0000:00:1f.2/ata2.2
./pci0000:00/0000:00:1f.2/ata2.2/link2.2/dev2.2.0/ata_device
./pci0000:00/0000:00:1f.2/ata2.2/link2.2/ata_link
./pci0000:00/0000:00:1f.2/ata2.2/ata_port
./pci0000:00/0000:00:1f.2/ata2.2/ata_port/ata2.2
./pci0000:00/0000:00:1f.2/ata3.3
./pci0000:00/0000:00:1f.2/ata3.3/link3.3/dev3.3.0/ata_device
./pci0000:00/0000:00:1f.2/ata3.3/link3.3/ata_link
./pci0000:00/0000:00:1f.2/ata3.3/ata_port
./pci0000:00/0000:00:1f.2/ata3.3/ata_port/ata3.3
./pci0000:00/0000:00:1f.2/ata4.4
./pci0000:00/0000:00:1f.2/ata4.4/link4.4/dev4.4.0/ata_device
./pci0000:00/0000:00:1f.2/ata4.4/link4.4/ata_link
./pci0000:00/0000:00:1f.2/ata4.4/ata_port
./pci0000:00/0000:00:1f.2/ata4.4/ata_port/ata4.4
./pci0000:00/0000:00:1f.2/ata5.5
./pci0000:00/0000:00:1f.2/ata5.5/link5.5/dev5.5.0/ata_device
./pci0000:00/0000:00:1f.2/ata5.5/link5.5/ata_link
./pci0000:00/0000:00:1f.2/ata5.5/ata_port
./pci0000:00/0000:00:1f.2/ata5.5/ata_port/ata5.5
./pci0000:00/0000:00:1f.2/ata6.6
./pci0000:00/0000:00:1f.2/ata6.6/link6.6/dev6.6.0/ata_device
./pci0000:00/0000:00:1f.2/ata6.6/link6.6/ata_link
./pci0000:00/0000:00:1f.2/ata6.6/ata_port
./pci0000:00/0000:00:1f.2/ata6.6/ata_port/ata6.6

(2nd controller with port multiplier)

./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.10/dev7.1.10.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.10/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.11/dev7.1.11.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.11/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.12/dev7.1.12.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.12/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.13/dev7.1.13.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.13/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.14/dev7.1.14.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.14/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1/dev7.1.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.0/dev7.1.0.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.0/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.1/dev7.1.1.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.1/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.2/dev7.1.2.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.2/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.3/dev7.1.3.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.3/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.4/dev7.1.4.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.4/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.5/dev7.1.5.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.5/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.6/dev7.1.6.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.6/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.7/dev7.1.7.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.7/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.8/dev7.1.8.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.8/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.9/dev7.1.9.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/link7.1.9/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/ata_port
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata7.1/ata_port/ata7.1
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata8.2
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata8.2/link8.2/dev8.2.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata8.2/link8.2/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata8.2/ata_port
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata8.2/ata_port/ata8.2

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
This could be modified to fit on top of "Insert ATA transport objects in SCSI
sysfs topology".

 drivers/ata/libata-core.c      |    6 ++++--
 drivers/ata/libata-transport.c |   10 +++++-----
 include/linux/libata.h         |    1 +
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4b6fb48..a796482 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5629,6 +5629,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->pflags |= ATA_PFLAG_INITIALIZING | ATA_PFLAG_FROZEN;
 	ap->lock = &host->lock;
 	ap->print_id = -1;
+	ap->local_print_id = -1;
 	ap->host = host;
 	ap->dev = host->dev;
 
@@ -6119,9 +6120,10 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		kfree(host->ports[i]);
 
 	/* give ports names and add SCSI hosts */
-	for (i = 0; i < host->n_ports; i++)
+	for (i = 0; i < host->n_ports; i++) {
 		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
-
+		host->ports[i]->local_print_id = i + 1;
+	}
 
 	/* Create associated sysfs transport objects  */
 	for (i = 0; i < host->n_ports; i++) {
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index c04d393..176bed8 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,
 
 	dev->parent = get_device(parent);
 	dev->release = ata_tport_release;
-	dev_set_name(dev, "ata%d", ap->print_id);
+	dev_set_name(dev, "ata%d.%d", ap->print_id, ap->local_print_id);
 	transport_setup_device(dev);
 	error = device_add(dev);
 	if (error) {
@@ -410,9 +410,9 @@ int ata_tlink_add(struct ata_link *link)
 	dev->parent = get_device(&ap->tdev);
 	dev->release = ata_tlink_release;
 	if (ata_is_host_link(link))
-		dev_set_name(dev, "link%d", ap->print_id);
+		dev_set_name(dev, "link%d.%d", ap->print_id, ap->local_print_id);
         else
-		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
+		dev_set_name(dev, "link%d.%d.%d", ap->print_id, ap->local_print_id, link->pmp);
 
 	transport_setup_device(dev);
 
@@ -638,9 +638,9 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	dev->parent = get_device(&link->tdev);
 	dev->release = ata_tdev_release;
 	if (ata_is_host_link(link))
-		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
+		dev_set_name(dev, "dev%d.%d.%d", ap->print_id, ap->local_print_id, ata_dev->devno);
         else
-		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
+		dev_set_name(dev, "dev%d.%d.%d.0", ap->print_id, ap->local_print_id, link->pmp);
 
 	transport_setup_device(dev);
 	error = device_add(dev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 91c9d10..62d5c1a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -745,6 +745,7 @@ struct ata_port {
 	/* Flags that change dynamically, protected by ap->lock */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		print_id; /* user visible unique port ID */
+	unsigned int            local_print_id; /* host local port ID */
 	unsigned int		port_no; /* 0 based port no. inside the host */
 
 #ifdef CONFIG_ATA_SFF
