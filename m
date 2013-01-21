From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Mon, 21 Jan 2013 09:49:09 -0600
Message-ID: <20130121154909.GA5750@dhcp-10-15-1-70.hsv.redhat.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com> <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com> <50F71AE5.6050906@redhat.com> <CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com> <20130117182239.GA31009@dhcp-10-15-1-70.hsv.redhat.com> <CAPXgP10jOrO4ULwOusf80GiqqCydYykfcWaLjky6_fKFNR1PeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51301 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab3AUPou (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Jan 2013 10:44:50 -0500
Content-Disposition: inline
In-Reply-To: <CAPXgP10jOrO4ULwOusf80GiqqCydYykfcWaLjky6_fKFNR1PeA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On Sun, Jan 20, 2013 at 03:57:16AM +0100, Kay Sievers wrote:
> On Thu, Jan 17, 2013 at 7:22 PM, David Milburn <dmilburn@redhat.com> wrote:
> 
> > The port multiplier extends the ATA port with up to 15 additional ports (links),
> > so with this patch
> >
> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1
> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/dev1.0/ata_device
> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/ata_link
> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/dev1.0.0/ata_device
> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/ata_link
> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/dev1.1.0/ata_device
> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/ata_link
> >
> > ata<localport>/link<localport>.<unique port mult port>/dev<localport>.<port mult port>.0/ata_device
> 
> @@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,
> 
>         dev->parent = get_device(parent);
>         dev->release = ata_tport_release;
> -       dev_set_name(dev, "ata%d", ap->print_id);
> +       dev_set_name(dev, "ata%d", ap->local_print_id);
> 
> > @@ -410,9 +410,9 @@ int ata_tlink_add(struct ata_link *link)
> >         dev->parent = get_device(&ap->tdev);
> >         dev->release = ata_tlink_release;
> >         if (ata_is_host_link(link))
> > -               dev_set_name(dev, "link%d", ap->print_id);
> > +               dev_set_name(dev, "link%d", ap->local_print_id);
> 
> Hmm, multiple controllers will clash with their names here now, right?
> The "ata%d"  and "link%d..." devices all show up in /sys/class/ in the
> same directories and need a unique name there, now that we start at
> every controller with out own counter, right?
> 
> We need to prefix the names with the global counter?

So, would you be OK with this? Every link would be <unique global port>.<unique port
multiplier port> combination with no clashes with above ata<local port>

# find . -name 'ata*' -print
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7/dev7.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.0/dev7.0.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.0/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.1/dev7.1.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.1/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.2/dev7.2.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.2/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.3/dev7.3.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.3/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.4/dev7.4.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.4/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.5/dev7.5.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.5/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.6/dev7.6.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.6/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.7/dev7.7.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.7/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.8/dev7.8.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.8/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.9/dev7.9.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.9/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/ata_port
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.10/dev7.10.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.10/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.11/dev7.11.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.11/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.12/dev7.12.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.12/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.13/dev7.13.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.13/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.14/dev7.14.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.14/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2/link8/dev8.0/ata_device
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2/link8/ata_link
./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2/ata_port
./pci0000:00/0000:00:1f.2/ata1
./pci0000:00/0000:00:1f.2/ata1/link1/dev1.0/ata_device
./pci0000:00/0000:00:1f.2/ata1/link1/ata_link
./pci0000:00/0000:00:1f.2/ata1/ata_port
./pci0000:00/0000:00:1f.2/ata1/ata_port/ata1
./pci0000:00/0000:00:1f.2/ata2
./pci0000:00/0000:00:1f.2/ata2/link2/dev2.0/ata_device
./pci0000:00/0000:00:1f.2/ata2/link2/ata_link
./pci0000:00/0000:00:1f.2/ata2/ata_port
./pci0000:00/0000:00:1f.2/ata2/ata_port/ata2
./pci0000:00/0000:00:1f.2/ata3
./pci0000:00/0000:00:1f.2/ata3/link3/dev3.0/ata_device
./pci0000:00/0000:00:1f.2/ata3/link3/ata_link
./pci0000:00/0000:00:1f.2/ata3/ata_port
./pci0000:00/0000:00:1f.2/ata3/ata_port/ata3
./pci0000:00/0000:00:1f.2/ata4
./pci0000:00/0000:00:1f.2/ata4/link4/dev4.0/ata_device
./pci0000:00/0000:00:1f.2/ata4/link4/ata_link
./pci0000:00/0000:00:1f.2/ata4/ata_port
./pci0000:00/0000:00:1f.2/ata4/ata_port/ata4
./pci0000:00/0000:00:1f.2/ata5
./pci0000:00/0000:00:1f.2/ata5/link5/dev5.0/ata_device
./pci0000:00/0000:00:1f.2/ata5/link5/ata_link
./pci0000:00/0000:00:1f.2/ata5/ata_port
./pci0000:00/0000:00:1f.2/ata5/ata_port/ata5
./pci0000:00/0000:00:1f.2/ata6
./pci0000:00/0000:00:1f.2/ata6/link6/dev6.0/ata_device
./pci0000:00/0000:00:1f.2/ata6/link6/ata_link
./pci0000:00/0000:00:1f.2/ata6/ata_port
./pci0000:00/0000:00:1f.2/ata6/ata_port/ata6

Thanks,
David

 drivers/ata/libata-core.c      |    6 ++++--
 drivers/ata/libata-transport.c |    2 +-
 include/linux/libata.h         |    1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

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
index c04d393..dc5f838 100644
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

