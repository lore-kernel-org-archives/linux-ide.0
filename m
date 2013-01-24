From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH #upstream] revert libata: export host controller number thru /sys
Date: Thu, 24 Jan 2013 10:33:09 -0600
Message-ID: <1359045189-16813-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42736 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474Ab3AXQ0h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2013 11:26:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

    Revert "libata: export host controller number thru /sys"
    
    This reverts commit 1757d902b029a29dfcef63609964385cf8865b5a.

    Solution still uses global counter for ata port.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c      |    4 ----
 drivers/ata/libata-transport.c |    2 +-
 include/linux/libata.h         |    1 -
 3 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b7eed82..4b6fb48 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -99,7 +99,6 @@ static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 atomic_t ata_print_id = ATOMIC_INIT(0);
-atomic_t host_print_id = ATOMIC_INIT(0);
 
 struct ata_force_param {
 	const char	*name;
@@ -6119,9 +6118,6 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	for (i = host->n_ports; host->ports[i]; i++)
 		kfree(host->ports[i]);
 
-	/* track host controller */
-	host->host_id = atomic_inc_return(&host_print_id);
-
 	/* give ports names and add SCSI hosts */
 	for (i = 0; i < host->n_ports; i++)
 		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 61dca7a..c04d393 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,
 
 	dev->parent = get_device(parent);
 	dev->release = ata_tport_release;
-	dev_set_name(dev, "ata%d.%d", ap->host->host_id, ap->print_id);
+	dev_set_name(dev, "ata%d", ap->print_id);
 	transport_setup_device(dev);
 	error = device_add(dev);
 	if (error) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 65ff67e..91c9d10 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -546,7 +546,6 @@ struct ata_host {
 	void			*private_data;
 	struct ata_port_operations *ops;
 	unsigned long		flags;
-	unsigned int            host_id; /* user visible host ID */
 
 	struct mutex		eh_mutex;
 	struct task_struct	*eh_owner;
