From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata-core cleanups (updated)
Date: Fri, 28 Oct 2005 20:37:23 -0700
Message-ID: <20051028203723.46b55450.rdunlap@xenotime.net>
References: <20051008121700.698e7092.rdunlap@xenotime.net>
	<43628B75.1090308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:38549 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751121AbVJ2Dh1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2005 23:37:27 -0400
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2005 20:37:27 -0700
In-Reply-To: <43628B75.1090308@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

libata-core cleanups:
- use kzalloc() instead of kmalloc() + memset();
- use one exit path in ata_device_add();

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/scsi/libata-core.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -Naurp linux-2614-work/drivers/scsi/libata-core.c~libata_clean linux-2614-work/drivers/scsi/libata-core.c
--- linux-2614-work/drivers/scsi/libata-core.c~libata_clean	2005-10-27 17:02:08.000000000 -0700
+++ linux-2614-work/drivers/scsi/libata-core.c	2005-10-28 19:31:52.000000000 -0700
@@ -4021,11 +4021,10 @@ int ata_device_add(struct ata_probe_ent 
 
 	DPRINTK("ENTER\n");
 	/* alloc a container for our list of ATA ports (buses) */
-	host_set = kmalloc(sizeof(struct ata_host_set) +
+	host_set = kzalloc(sizeof(struct ata_host_set) +
 			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
 	if (!host_set)
 		return 0;
-	memset(host_set, 0, sizeof(struct ata_host_set) + (ent->n_ports * sizeof(void *)));
 	spin_lock_init(&host_set->lock);
 
 	host_set->dev = dev;
@@ -4065,10 +4064,8 @@ int ata_device_add(struct ata_probe_ent 
 		count++;
 	}
 
-	if (!count) {
-		kfree(host_set);
-		return 0;
-	}
+	if (!count)
+		goto err_free_ret;
 
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
@@ -4126,6 +4123,7 @@ err_out:
 		ata_host_remove(host_set->ports[i], 1);
 		scsi_host_put(host_set->ports[i]->host);
 	}
+err_free_ret:
 	kfree(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
@@ -4236,15 +4234,13 @@ ata_probe_ent_alloc(struct device *dev, 
 {
 	struct ata_probe_ent *probe_ent;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       kobject_name(&(dev->kobj)));
 		return NULL;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
-
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->dev = dev;
 


---
