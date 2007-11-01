From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Thu, 01 Nov 2007 10:50:29 +0800
Message-ID: <1193885429.6872.2.camel@sli10-conroe.sh.intel.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
	 <1190341023.16930.5.camel@sli10-conroe.sh.intel.com>
	 <200710302227.40310.lenb@kernel.org>  <200710311426.25099.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43747 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbXKACx0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Oct 2007 22:53:26 -0400
In-Reply-To: <200710311426.25099.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 2007-10-31 at 14:26 +0100, Rafael J. Wysocki wrote:
> On Wednesday, 31 October 2007 03:27, Len Brown wrote:
> > It would be interseting if any of the folks having power consumption
> > problems when suspended see an improvement with this patch.
> > 
> > Are there plans to refresh this patch and get it upstream?
> > 
> > Acked-by: Len Brown <len.brown@intel.com>
> 
> There was a discussion regarding this patch, IIRC, and it was argued that
> _PSx are only applicable to IDE/PATA devices.
> 
> I wonder if this has been addressed.
Sure, there is a check for PATA. I refreshed the patch to against latest
git tree.

ACPI spec (ver 3.0a, p289) requires IDE power on/off executes ACPI _PSx
methods. As recently most PATA drivers use libata, this patch adds _PSx
method support in libata. ACPI spec doesn't mention if SATA requires the
same _PSx method.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 drivers/ata/libata-acpi.c |   33 +++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |    3 +++
 drivers/ata/libata.h      |    2 ++
 3 files changed, 38 insertions(+)

Index: linux/drivers/ata/libata-acpi.c
===================================================================
--- linux.orig/drivers/ata/libata-acpi.c	2007-10-26 08:49:07.000000000 +0800
+++ linux/drivers/ata/libata-acpi.c	2007-11-01 09:17:12.000000000 +0800
@@ -652,6 +652,39 @@ void ata_acpi_on_resume(struct ata_port 
 }
 
 /**
+ * ata_acpi_set_state - set the port power state
+ * @ap: target ATA port
+ * @state: state, on/off
+ *
+ * This function executes the _PS0/_PS3 ACPI method to set the power state.
+ * ACPI spec requires _PS0 when IDE power on and _PS3 when power off
+ */
+void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
+{
+	int max_devices, i;
+
+	if (!ap->acpi_handle || (ap->flags & ATA_FLAG_ACPI_SATA))
+		return;
+
+	/* channel first and then drives for power on and verse versa for power off */
+	if (state.event == PM_EVENT_ON)
+		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D0);
+
+	max_devices = ata_link_max_devices(&ap->link);
+
+	for (i = 0; i < max_devices; ++i) {
+		struct ata_device *dev = &ap->link.device[i];
+
+		if (dev->acpi_handle)
+			acpi_bus_set_power(dev->acpi_handle,
+				state.event == PM_EVENT_ON ?
+				ACPI_STATE_D0: ACPI_STATE_D3);
+	}
+	if (state.event != PM_EVENT_ON)
+		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D3);
+}
+
+/**
  * ata_acpi_on_devcfg - ATA ACPI hook called on device donfiguration
  * @dev: target ATA device
  *
Index: linux/drivers/ata/libata-eh.c
===================================================================
--- linux.orig/drivers/ata/libata-eh.c	2007-10-31 09:14:06.000000000 +0800
+++ linux/drivers/ata/libata-eh.c	2007-11-01 08:55:05.000000000 +0800
@@ -2796,6 +2796,7 @@ static void ata_eh_handle_port_suspend(s
 	if (ap->ops->port_suspend)
 		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
 
+	ata_acpi_set_state(ap, PMSG_SUSPEND);
  out:
 	/* report result */
 	spin_lock_irqsave(ap->lock, flags);
@@ -2841,6 +2842,8 @@ static void ata_eh_handle_port_resume(st
 
 	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
 
+	ata_acpi_set_state(ap, PMSG_ON);
+
 	if (ap->ops->port_resume)
 		rc = ap->ops->port_resume(ap);
 
Index: linux/drivers/ata/libata.h
===================================================================
--- linux.orig/drivers/ata/libata.h	2007-10-30 14:17:14.000000000 +0800
+++ linux/drivers/ata/libata.h	2007-11-01 08:55:05.000000000 +0800
@@ -111,12 +111,14 @@ extern void ata_acpi_associate(struct at
 extern int ata_acpi_on_suspend(struct ata_port *ap);
 extern void ata_acpi_on_resume(struct ata_port *ap);
 extern int ata_acpi_on_devcfg(struct ata_device *adev);
+extern void ata_acpi_set_state(struct ata_port *ap, pm_message_t state);
 #else
 static inline void ata_acpi_associate_sata_port(struct ata_port *ap) { }
 static inline void ata_acpi_associate(struct ata_host *host) { }
 static inline int ata_acpi_on_suspend(struct ata_port *ap) { return 0; }
 static inline void ata_acpi_on_resume(struct ata_port *ap) { }
 static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
+static inline void ata_acpi_set_state(struct ata_port *ap, pm_message_t state) { }
 #endif
 
 /* libata-scsi.c */
