From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata: export host controller number thru /sys
Date: Mon, 14 Jan 2013 09:59:30 -0600
Message-ID: <1358179170-19326-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6711 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679Ab3ANPw7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jan 2013 10:52:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com

As low-level drivers register their host controller(s), keep track
of the number of controllers and export thru /sys in a <host.port>
format so that udev can better match up port numbers with a 
specific controller.

# pwd
/sys/devices/pci0000:00
# find . -name 'ata*' -print

(2nd controller with port multiplier attached)

./0000:00:1e.0/0000:05:01.0/ata2.7
./0000:00:1e.0/0000:05:01.0/ata2.7/link7/dev7.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.0/dev7.0.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.0/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.1/dev7.1.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.1/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.2/dev7.2.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.2/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.3/dev7.3.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.3/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.4/dev7.4.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.4/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.5/dev7.5.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.5/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.6/dev7.6.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.6/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.7/dev7.7.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.7/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.8/dev7.8.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.8/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.9/dev7.9.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.9/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/ata_port
./0000:00:1e.0/0000:05:01.0/ata2.7/ata_port/ata2.7
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.10/dev7.10.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.10/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.11/dev7.11.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.11/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.12/dev7.12.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.12/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.13/dev7.13.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.13/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.14/dev7.14.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.7/link7.14/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.8
./0000:00:1e.0/0000:05:01.0/ata2.8/link8/dev8.0/ata_device
./0000:00:1e.0/0000:05:01.0/ata2.8/link8/ata_link
./0000:00:1e.0/0000:05:01.0/ata2.8/ata_port
./0000:00:1e.0/0000:05:01.0/ata2.8/ata_port/ata2.8

(1st controller)

./0000:00:1f.2/ata1.1
./0000:00:1f.2/ata1.1/link1/dev1.0/ata_device
./0000:00:1f.2/ata1.1/link1/ata_link
./0000:00:1f.2/ata1.1/ata_port
./0000:00:1f.2/ata1.1/ata_port/ata1.1
./0000:00:1f.2/ata1.2
./0000:00:1f.2/ata1.2/link2/dev2.0/ata_device
./0000:00:1f.2/ata1.2/link2/ata_link
./0000:00:1f.2/ata1.2/ata_port
./0000:00:1f.2/ata1.2/ata_port/ata1.2
./0000:00:1f.2/ata1.3
./0000:00:1f.2/ata1.3/link3/dev3.0/ata_device
./0000:00:1f.2/ata1.3/link3/ata_link
./0000:00:1f.2/ata1.3/ata_port
./0000:00:1f.2/ata1.3/ata_port/ata1.3
./0000:00:1f.2/ata1.4
./0000:00:1f.2/ata1.4/link4/dev4.0/ata_device
./0000:00:1f.2/ata1.4/link4/ata_link
./0000:00:1f.2/ata1.4/ata_port
./0000:00:1f.2/ata1.4/ata_port/ata1.4
./0000:00:1f.2/ata1.5
./0000:00:1f.2/ata1.5/link5/dev5.0/ata_device
./0000:00:1f.2/ata1.5/link5/ata_link
./0000:00:1f.2/ata1.5/ata_port
./0000:00:1f.2/ata1.5/ata_port/ata1.5
./0000:00:1f.2/ata1.6
./0000:00:1f.2/ata1.6/link6/dev6.0/ata_device
./0000:00:1f.2/ata1.6/link6/ata_link
./0000:00:1f.2/ata1.6/ata_port
./0000:00:1f.2/ata1.6/ata_port/ata1.6

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c      |    4 ++++
 drivers/ata/libata-transport.c |    2 +-
 include/linux/libata.h         |    1 +
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f46fbd3..ab7f376 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -98,6 +98,7 @@ static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 atomic_t ata_print_id = ATOMIC_INIT(0);
+atomic_t host_print_id = ATOMIC_INIT(0);
 
 struct ata_force_param {
 	const char	*name;
@@ -6091,6 +6092,9 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	for (i = host->n_ports; host->ports[i]; i++)
 		kfree(host->ports[i]);
 
+	/* track host controller */
+	host->host_id = atomic_inc_return(&host_print_id);
+
 	/* give ports names and add SCSI hosts */
 	for (i = 0; i < host->n_ports; i++)
 		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index c04d393..61dca7a 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,
 
 	dev->parent = get_device(parent);
 	dev->release = ata_tport_release;
-	dev_set_name(dev, "ata%d", ap->print_id);
+	dev_set_name(dev, "ata%d.%d", ap->host->host_id, ap->print_id);
 	transport_setup_device(dev);
 	error = device_add(dev);
 	if (error) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 77eeeda..a191d1c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -545,6 +545,7 @@ struct ata_host {
 	void			*private_data;
 	struct ata_port_operations *ops;
 	unsigned long		flags;
+	unsigned int            host_id; /* user visible host ID */
 
 	struct mutex		eh_mutex;
 	struct task_struct	*eh_owner;
