From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH #upstream] libata: export local port number through /sys
Date: Tue, 5 Mar 2013 17:04:30 -0600
Message-ID: <20130305230430.GA14118@dhcp-10-15-1-70.hsv.redhat.com>
References: <1359049929-17069-1-git-send-email-dmilburn@redhat.com> <512BD1DA.80305@redhat.com> <CAPXgP13Q3TyWPwE3CqhiqouLQH-oyr8EC=wHChy50he74qokug@mail.gmail.com> <513613D0.9090904@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104Ab3CEW6c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Mar 2013 17:58:32 -0500
Content-Disposition: inline
In-Reply-To: <513613D0.9090904@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, kay@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com, dmilburn@redhat.com

On Tue, Mar 05, 2013 at 04:48:32PM +0100, Hannes Reinecke wrote:
> On 02/26/2013 04:26 PM, Kay Sievers wrote:
> >On Mon, Feb 25, 2013 at 10:04 PM, David Milburn <dmilburn@redhat.com> 
> >wrote:
> >>David Milburn wrote:
> >>>
> >>>Export <global port>.<local port> format through /sys
> >>>
> >>>./pci0000:00/0000:00:1f.2/ata1.1
> >>>./pci0000:00/0000:00:1f.2/ata1.1/link1.1/dev1.1.0/ata_device
> >>>./pci0000:00/0000:00:1f.2/ata1.1/link1.1/ata_link
> >>>./pci0000:00/0000:00:1f.2/ata1.1/ata_port
> >>>./pci0000:00/0000:00:1f.2/ata1.1/ata_port/ata1.1
> >>>./pci0000:00/0000:00:1f.2/ata2.2
> >>>./pci0000:00/0000:00:1f.2/ata2.2/link2.2/dev2.2.0/ata_device
> >>>./pci0000:00/0000:00:1f.2/ata2.2/link2.2/ata_link
> >>>./pci0000:00/0000:00:1f.2/ata2.2/ata_port
> >>>./pci0000:00/0000:00:1f.2/ata2.2/ata_port/ata2.2
> >>>./pci0000:00/0000:00:1f.2/ata3.3
> >>>./pci0000:00/0000:00:1f.2/ata3.3/link3.3/dev3.3.0/ata_device
> >>>./pci0000:00/0000:00:1f.2/ata3.3/link3.3/ata_link
> >>>./pci0000:00/0000:00:1f.2/ata3.3/ata_port
> >>>./pci0000:00/0000:00:1f.2/ata3.3/ata_port/ata3.3
> >>>./pci0000:00/0000:00:1f.2/ata4.4
> >>>./pci0000:00/0000:00:1f.2/ata4.4/link4.4/dev4.4.0/ata_device
> >>>./pci0000:00/0000:00:1f.2/ata4.4/link4.4/ata_link
> >>>./pci0000:00/0000:00:1f.2/ata4.4/ata_port
> >>>./pci0000:00/0000:00:1f.2/ata4.4/ata_port/ata4.4
> >>>./pci0000:00/0000:00:1f.2/ata5.5
> >>>./pci0000:00/0000:00:1f.2/ata5.5/link5.5/dev5.5.0/ata_device
> >>>./pci0000:00/0000:00:1f.2/ata5.5/link5.5/ata_link
> >>>./pci0000:00/0000:00:1f.2/ata5.5/ata_port
> >>>./pci0000:00/0000:00:1f.2/ata5.5/ata_port/ata5.5
> >>>./pci0000:00/0000:00:1f.2/ata6.6
> >>>./pci0000:00/0000:00:1f.2/ata6.6/link6.6/dev6.6.0/ata_device
> >>>./pci0000:00/0000:00:1f.2/ata6.6/link6.6/ata_link
> >>>./pci0000:00/0000:00:1f.2/ata6.6/ata_port
> >>>./pci0000:00/0000:00:1f.2/ata6.6/ata_port/ata6.6
> >>>
> Hmm.
> 
> Can't say I like the 'global port' notation.
> Personally I would prefer to have a sysfs attribute for the local 
> port number, and have path_id get it from there.
> 
> For 95% of all cases the above is just an information duplication 
> (ie it'll only provide a real value for udev, but not for the user).
> 
> So, please, use a sysfs attribute for the local port and keep the 
> numbering as it is.

Hi Hannes,

Thanks for your feedback.

Would this patch be acceptable to everyone?

Thanks,
David

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
index c04d393..e3808b9 100644
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
+ata_port_simple_attr(local_port_no, local_port_no, "%u\n", unsigned int);
 
 static DECLARE_TRANSPORT_CLASS(ata_port_class,
 			       "ata_port", NULL, NULL, NULL);
@@ -709,6 +710,7 @@ struct scsi_transport_template *ata_attach_transport(void)
 	count = 0;
 	SETUP_PORT_ATTRIBUTE(nr_pmp_links);
 	SETUP_PORT_ATTRIBUTE(idle_irq);
+	SETUP_PORT_ATTRIBUTE(local_port_no);
 	BUG_ON(count > ATA_PORT_ATTRS);
 	i->port_attrs[count] = NULL;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 91c9d10..5bcbbc5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -745,6 +745,7 @@ struct ata_port {
 	/* Flags that change dynamically, protected by ap->lock */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		print_id; /* user visible unique port ID */
+	unsigned int            local_port_no; /* user visible host local port ID */ 
 	unsigned int		port_no; /* 0 based port no. inside the host */
 
 #ifdef CONFIG_ATA_SFF

