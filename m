From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH #upstream] libata: export ata_port port_no attribute via /sys
Date: Wed,  6 Mar 2013 13:00:12 -0600
Message-ID: <1362596412-17314-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65019 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab3CFSzD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Mar 2013 13:55:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com, hare@suse.de

While registering host controller track port number based upon number
of ports available on the controller, export port_no attribute through
/sys.

# pwd
/sys/devices/pci0000:00/0000:00:1f.2/ata8/ata_port/ata8
# ll
total 0
lrwxrwxrwx. 1 root root    0 Mar  6 12:43 device -> ../../../ata8
-r--r--r--. 1 root root 4096 Mar  6 12:43 idle_irq
-r--r--r--. 1 root root 4096 Mar  6 12:43 nr_pmp_links
-r--r--r--. 1 root root 4096 Mar  6 12:43 port_no
drwxr-xr-x. 2 root root    0 Mar  6 12:42 power
lrwxrwxrwx. 1 root root    0 Mar  6 12:41 subsystem -> ../../../../../../class/ata_port
-rw-r--r--. 1 root root 4096 Mar  6 12:40 uevent
# cat port_no
1

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c      |    6 ++++--
 drivers/ata/libata-transport.c |    4 +++-
 include/linux/libata.h         |    1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 497adea..82135b1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5632,6 +5632,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->pflags |= ATA_PFLAG_INITIALIZING | ATA_PFLAG_FROZEN;
 	ap->lock = &host->lock;
 	ap->print_id = -1;
+	ap->local_port_no = -1;
 	ap->host = host;
 	ap->dev = host->dev;
 
@@ -6122,9 +6123,10 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		kfree(host->ports[i]);
 
 	/* give ports names and add SCSI hosts */
-	for (i = 0; i < host->n_ports; i++)
+	for (i = 0; i < host->n_ports; i++) {
 		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
-
+		host->ports[i]->local_port_no = i + 1;
+	}
 
 	/* Create associated sysfs transport objects  */
 	for (i = 0; i < host->n_ports; i++) {
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index c04d393..077a856 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -37,7 +37,7 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_PORT_ATTRS		2
+#define ATA_PORT_ATTRS		3
 #define ATA_LINK_ATTRS		3
 #define ATA_DEV_ATTRS		9
 
@@ -216,6 +216,7 @@ static DEVICE_ATTR(name, S_IRUGO, show_ata_port_##name, NULL)
 
 ata_port_simple_attr(nr_pmp_links, nr_pmp_links, "%d\n", int);
 ata_port_simple_attr(stats.idle_irq, idle_irq, "%ld\n", unsigned long);
+ata_port_simple_attr(local_port_no, port_no, "%u\n", unsigned int);
 
 static DECLARE_TRANSPORT_CLASS(ata_port_class,
 			       "ata_port", NULL, NULL, NULL);
@@ -709,6 +710,7 @@ struct scsi_transport_template *ata_attach_transport(void)
 	count = 0;
 	SETUP_PORT_ATTRIBUTE(nr_pmp_links);
 	SETUP_PORT_ATTRIBUTE(idle_irq);
+	SETUP_PORT_ATTRIBUTE(port_no);
 	BUG_ON(count > ATA_PORT_ATTRS);
 	i->port_attrs[count] = NULL;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 91c9d10..6eece8b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -745,6 +745,7 @@ struct ata_port {
 	/* Flags that change dynamically, protected by ap->lock */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		print_id; /* user visible unique port ID */
+	unsigned int            local_port_no; /* host local port num */
 	unsigned int		port_no; /* 0 based port no. inside the host */
 
 #ifdef CONFIG_ATA_SFF
