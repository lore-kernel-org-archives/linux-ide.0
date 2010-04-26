From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [RFC] add port information for ATA devices in sysfs
Date: Mon, 26 Apr 2010 18:29:04 +0200
Message-ID: <201004261829.04687.nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:53782 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab0DZQ3P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Apr 2010 12:29:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Greg Kroah-Hartman <greg@kroah.com>, Maxime Bizon <mbizon@freebox.fr>


Hi,

Currently, it is  not possible to know on what  particular port an ata
device is located  with sysfs.  the current scheme  creates an host<x>
directory directly under  the sata host device node  like this (with a
sata_mv driver, having two sata ports):

/sys/platform/sata_mv.0/host<x>
/sys/platform/sata_mv.0/host<y>

If the  system probes successfully  other scsi devices  before probing
the sata bus, we have no guarantees that the same numbers will be used
all the  time, and if we  rmmod/modprobe sata_mv the  host numbers are
not persistent accross module insertion.

The  inlined patch  fixes  this by  adding  a port<x>  device that  is
parented to the sata controller device  and uses this device as a base
to create the scsi hosts for the devices behind a given sata port. <x>
is set to be the value of the port_no field in struct ata_port.

the  naming then looks  like this  (assuming two  sata ports  behind a
sata_mv driver):

/sys/platform/sata_mv.0/port0/host<x>
/sys/platform/sata_mv.0/port1/host<y>

My  patch adds a  struct device  inside struct  ata_port for  the sole
purpose of having this port0,port1,... directory under sata_mv.

This patch also moves the  assignation of port_no to ata_port_alloc to
ease the initialisation of the device structure embedded in sata_port.
this most  likely messes up  the ata_sas_port_alloc code  which always
sets port_no to 0 and will make device_add complain loudly in dmesg if
this function  is called more than  once. Unfortunately I  do not have
any SAS devices at hand to fix this.

I do  not know yet  how this would  behave with sata devices  behind a
SATA port multiplier but I would  guess that no new scsi host would be
created in this  case and that the other  fields of target<host>:x:y:z
would be used by the scsi subsystem.

This is not a very polished patch  and it is aimed to know whether the
approach  used  is correct  and  I would  like  to  have your  advices
regarding this.

Regards,

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

-- 
Nicolas Schichan

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 91fed3c..179abad 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5660,6 +5660,10 @@ int sata_link_init_spd(struct ata_link *link)
 	return 0;
 }
 
+static void ata_port_dev_release(struct device *dev)
+{
+}
+
 /**
  *	ata_port_alloc - allocate and initialize basic ATA port resources
  *	@host: ATA host this allocated port belongs to
@@ -5672,7 +5676,7 @@ int sata_link_init_spd(struct ata_link *link)
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  */
-struct ata_port *ata_port_alloc(struct ata_host *host)
+struct ata_port *ata_port_alloc(struct ata_host *host, int port_no)
 {
 	struct ata_port *ap;
 
@@ -5690,6 +5694,20 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->host = host;
 	ap->dev = host->dev;
 	ap->last_ctl = 0xFF;
+	ap->port_no = port_no;
+
+	/*
+	 * register device used to add the scsi host behind this
+	 * port. make it a parent of the struct device of the host.
+	 */
+	ap->ata_port_device.release = ata_port_dev_release;
+	dev_set_name(&ap->ata_port_device, "port%i", ap->port_no);
+	ap->ata_port_device.parent = ap->dev;
+	if (device_register(&ap->ata_port_device) < 0) {
+		kfree(ap);
+		return NULL;
+	}
+
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
@@ -5739,6 +5757,9 @@ static void ata_host_release(struct device *gendev, void *res)
 		if (ap->scsi_host)
 			scsi_host_put(ap->scsi_host);
 
+
+		device_unregister(&ap->ata_port_device);
+
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
 		kfree(ap);
@@ -5797,11 +5818,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	for (i = 0; i < max_ports; i++) {
 		struct ata_port *ap;
 
-		ap = ata_port_alloc(host);
+		ap = ata_port_alloc(host, i);
 		if (!ap)
 			goto err_out;
 
-		ap->port_no = i;
 		host->ports[i] = ap;
 	}
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b4ee28d..1cbda75 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3210,7 +3210,7 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 		 */
 		shost->max_host_blocked = 1;
 
-		rc = scsi_add_host(ap->scsi_host, ap->host->dev);
+		rc = scsi_add_host(ap->scsi_host, &ap->ata_port_device);
 		if (rc)
 			goto err_add;
 	}
@@ -3593,11 +3593,10 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
 {
 	struct ata_port *ap;
 
-	ap = ata_port_alloc(host);
+	ap = ata_port_alloc(host, 0);
 	if (!ap)
 		return NULL;
 
-	ap->port_no = 0;
 	ap->lock = shost->host_lock;
 	ap->pio_mask = port_info->pio_mask;
 	ap->mwdma_mask = port_info->mwdma_mask;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 823e630..cd44e9e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -112,7 +112,7 @@ extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
 extern int sata_link_init_spd(struct ata_link *link);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
-extern struct ata_port *ata_port_alloc(struct ata_host *host);
+extern struct ata_port *ata_port_alloc(struct ata_host *host, int port_no);
 extern void ata_dev_enable_pm(struct ata_device *dev, enum link_pm policy);
 extern void ata_lpm_schedule(struct ata_port *ap, enum link_pm);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b0f6d97..64d94d9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -749,6 +749,9 @@ struct ata_port {
 	struct ata_host		*host;
 	struct device 		*dev;
 
+	/* used as base to create scsi host behind the port.*/
+	struct device		ata_port_device;
+
 	void			*port_task_data;
 	struct delayed_work	port_task;
 	struct delayed_work	hotplug_task;
