From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Thu, 17 Jan 2013 12:22:39 -0600
Message-ID: <20130117182239.GA31009@dhcp-10-15-1-70.hsv.redhat.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com> <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com> <50F71AE5.6050906@redhat.com> <CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55139 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064Ab3AQSQO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Jan 2013 13:16:14 -0500
Content-Disposition: inline
In-Reply-To: <CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On Wed, Jan 16, 2013 at 11:56:13PM +0100, Kay Sievers wrote:
> On Wed, Jan 16, 2013 at 10:25 PM, David Milburn <dmilburn@redhat.com> wrote:
> 
> > So, if we eliminated the global ata_print_id counter, then we would
> > need to check all the places ap->print_id is used and consider the host
> > controller and a local_print_id. So, if the above changed to 2.1, we
> > would expect ata2.1 to show up in dmesg during error recovery
> > instead of ata7, right?
> >
> > There are other places (non-printk stuff) in libata that check the global
> > counter that would need to change, and libsas increments the global
> > counter when a SATA drive is present on a SAS controller.
> 
> Well, we just need a way to get some "stable" numbers out of /sys when
> we start at the block device and walk up the chain of parent devices
> and see the ata directory. It does not necessarily need to be the name
> of the top ata%d directory, it could be a sysfs attribute somewhere
> too, if that's easier.
> 
> If we we are going to support port by-path/ strings for block devices
> connected through a port multiplier chain, I guess we will need an
> arbitrary length string representing the concatenated chain of local
> port numbers, containing stable port identifier numbers of every
> device involved. None of the numbers it contains can therefore depend
> on enumeration or loading order.
> 
> The "stable chain of port numbers" do not necessarily need to share
> anything with the current global numbers to make the device name
> unique. It would be easier to understand, but it's not a requirement.

Ahh, OK.

Please test this patch.

The port multiplier extends the ATA port with up to 15 additional ports (links),
so with this patch 

./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/dev1.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/dev1.0.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/dev1.1.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/ata_link

ata<localport>/link<localport>.<unique port mult port>/dev<localport>.<port mult port>.0/ata_device

Previously, local port would have been global port.

Thanks,
David

 drivers/ata/libata-core.c      |    6 ++++--
 drivers/ata/libata-transport.c |   10 +++++-----
 include/linux/libata.h         |    1 +
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9e8b99a..b225b87 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5604,6 +5604,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->pflags |= ATA_PFLAG_INITIALIZING | ATA_PFLAG_FROZEN;
 	ap->lock = &host->lock;
 	ap->print_id = -1;
+	ap->local_print_id = -1;
 	ap->host = host;
 	ap->dev = host->dev;
 
@@ -6094,9 +6095,10 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
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
index c04d393..7f6feaf 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,
 
 	dev->parent = get_device(parent);
 	dev->release = ata_tport_release;
-	dev_set_name(dev, "ata%d", ap->print_id);
+	dev_set_name(dev, "ata%d", ap->local_print_id);
 	transport_setup_device(dev);
 	error = device_add(dev);
 	if (error) {
@@ -410,9 +410,9 @@ int ata_tlink_add(struct ata_link *link)
 	dev->parent = get_device(&ap->tdev);
 	dev->release = ata_tlink_release;
 	if (ata_is_host_link(link))
-		dev_set_name(dev, "link%d", ap->print_id);
+		dev_set_name(dev, "link%d", ap->local_print_id);
         else
-		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
+		dev_set_name(dev, "link%d.%d", ap->local_print_id, link->pmp);
 
 	transport_setup_device(dev);
 
@@ -638,9 +638,9 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	dev->parent = get_device(&link->tdev);
 	dev->release = ata_tdev_release;
 	if (ata_is_host_link(link))
-		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
+		dev_set_name(dev, "dev%d.%d", ap->local_print_id,ata_dev->devno);
         else
-		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
+		dev_set_name(dev, "dev%d.%d.0", ap->local_print_id, link->pmp);
 
 	transport_setup_device(dev);
 	error = device_add(dev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 83ba0ab..5208532 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -742,6 +742,7 @@ struct ata_port {
 	/* Flags that change dynamically, protected by ap->lock */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		print_id; /* user visible unique port ID */
+	unsigned int		local_print_id; /* host local port ID */
 	unsigned int		port_no; /* 0 based port no. inside the host */
 
 #ifdef CONFIG_ATA_SFF

> 
> Kay
> 
> Kay
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
