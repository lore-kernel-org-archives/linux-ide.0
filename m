From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Fri, 21 Sep 2007 09:16:42 +0800
Message-ID: <1190337402.16463.3.camel@sli10-conroe.sh.intel.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
	 <46F2ED71.3070603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46F2ED71.3070603@pobox.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Thu, 2007-09-20 at 18:00 -0400, Jeff Garzik wrote:
> Shaohua Li wrote:
> > ACPI spec (ver 3.0a, p289) requires IDE power on/off executes ACPI _PSx
> > methods. As recently most PATA drivers use libata, this patch adds _PSx
> > method support in libata. ACPI spec doesn't mention if SATA requires the
> > same _PSx method, but executing _PSx for SATA should be ok I think.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> ahci and sata_sil24 directly power off components, so it seems quite 
> unwise for "modern" SATA controllers.
> 
> ISTR Tejun, when he cleaned up libata-acpi, finally figured out a good 
> way to distinguish ACPI's idea of "IDE" -- which sometimes includes the 
> legacy programming mode of SATA controllers, and a controller running a 
> modern programming mode.
> 
> Your best bet is to use a similar test when deciding when to execute 
> _PSx.  Or, you could simply be conservative and only do it for PATA.
> 
> outside of those issues, the rest of the patch looks ok.
Then how about this one? I added a check in ata_acpi_set_state to skip
SATA device, assume this is what you are talking about.

Thanks,
Shaohua

---
 drivers/ata/libata-acpi.c |   34 ++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |    3 +++
 drivers/ata/libata.h      |    2 ++
 3 files changed, 39 insertions(+)

Index: linux/drivers/ata/libata-acpi.c
===================================================================
--- linux.orig/drivers/ata/libata-acpi.c	2007-09-14 10:28:25.000000000 +0800
+++ linux/drivers/ata/libata-acpi.c	2007-09-21 08:58:18.000000000 +0800
@@ -523,6 +523,40 @@ void ata_acpi_on_resume(struct ata_port 
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
+	int max_devices = 1, i;
+
+	if (!ap->acpi_handle || (ap->flags & ATA_FLAG_ACPI_SATA))
+		return;
+
+	/* channel first and then drives for power on and verse versa for power off */
+	if (state.event == PM_EVENT_ON)
+		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D0);
+
+	if (ap->flags & ATA_FLAG_SLAVE_POSS)
+		max_devices++;
+
+	for (i = 0; i < max_devices; ++i) {
+		struct ata_device *dev = &ap->device[i];
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
--- linux.orig/drivers/ata/libata-eh.c	2007-09-14 10:28:25.000000000 +0800
+++ linux/drivers/ata/libata-eh.c	2007-09-21 08:56:40.000000000 +0800
@@ -2349,6 +2349,7 @@ static void ata_eh_handle_port_suspend(s
 	if (ap->ops->port_suspend)
 		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
 
+	ata_acpi_set_state(ap, PMSG_SUSPEND);
  out:
 	/* report result */
 	spin_lock_irqsave(ap->lock, flags);
@@ -2394,6 +2395,8 @@ static void ata_eh_handle_port_resume(st
 
 	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
 
+	ata_acpi_set_state(ap, PMSG_ON);
+
 	if (ap->ops->port_resume)
 		rc = ap->ops->port_resume(ap);
 
Index: linux/drivers/ata/libata.h
===================================================================
--- linux.orig/drivers/ata/libata.h	2007-09-14 10:28:25.000000000 +0800
+++ linux/drivers/ata/libata.h	2007-09-21 08:56:40.000000000 +0800
@@ -102,11 +102,13 @@ extern void ata_acpi_associate(struct at
 extern int ata_acpi_on_suspend(struct ata_port *ap);
 extern void ata_acpi_on_resume(struct ata_port *ap);
 extern int ata_acpi_on_devcfg(struct ata_device *adev);
+extern void ata_acpi_set_state(struct ata_port *ap, pm_message_t state);
 #else
 static inline void ata_acpi_associate(struct ata_host *host) { }
 static inline int ata_acpi_on_suspend(struct ata_port *ap) { return 0; }
 static inline void ata_acpi_on_resume(struct ata_port *ap) { }
 static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
+static inline void ata_acpi_set_state(struct ata_port *ap, pm_message_t state) { }
 #endif
 
 /* libata-scsi.c */
