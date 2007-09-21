From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Fri, 21 Sep 2007 10:17:03 +0800
Message-ID: <1190341023.16930.5.camel@sli10-conroe.sh.intel.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
	 <46F2ED71.3070603@pobox.com>
	 <1190337402.16463.3.camel@sli10-conroe.sh.intel.com>
	 <46F32A81.8030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46F32A81.8030508@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Fri, 2007-09-21 at 11:20 +0900, Tejun Heo wrote:
> Hello,
> 
> Shaohua Li wrote:
> > +	/* channel first and then drives for power on and verse versa for power off */
> > +	if (state.event == PM_EVENT_ON)
> > +		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D0);
> > +
> > +	if (ap->flags & ATA_FLAG_SLAVE_POSS)
> > +		max_devices++;
> 
> ata_port_max_devices()?
ok, fixed.
> 
> > Index: linux/drivers/ata/libata-eh.c
> > ===================================================================
> > --- linux.orig/drivers/ata/libata-eh.c	2007-09-14 10:28:25.000000000 +0800
> > +++ linux/drivers/ata/libata-eh.c	2007-09-21 08:56:40.000000000 +0800
> > @@ -2349,6 +2349,7 @@ static void ata_eh_handle_port_suspend(s
> >  	if (ap->ops->port_suspend)
> >  		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
> >  
> > +	ata_acpi_set_state(ap, PMSG_SUSPEND);
> >   out:
> >  	/* report result */
> >  	spin_lock_irqsave(ap->lock, flags);
> > @@ -2394,6 +2395,8 @@ static void ata_eh_handle_port_resume(st
> >  
> >  	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
> >  
> > +	ata_acpi_set_state(ap, PMSG_ON);
> > +
> >  	if (ap->ops->port_resume)
> >  		rc = ap->ops->port_resume(ap);
> 
> Can these be moved into ata_acpi_on_suspend() and ata_acpi_on_resume()?
>  Or do they have to be placed on the other side of ->port_suspend/resume
> callbacks?
I suppose _PSx will shutdown ports. So I want to do PS3 as later as
possible in suspend, and vice versa in resume.

Thanks,
Shaohua


---
 drivers/ata/libata-acpi.c |   34 ++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |    3 +++
 drivers/ata/libata.h      |    2 ++
 3 files changed, 39 insertions(+)

Index: linux/drivers/ata/libata-acpi.c
===================================================================
--- linux.orig/drivers/ata/libata-acpi.c	2007-09-21 09:23:13.000000000 +0800
+++ linux/drivers/ata/libata-acpi.c	2007-09-21 10:13:32.000000000 +0800
@@ -523,6 +523,39 @@ void ata_acpi_on_resume(struct ata_port 
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
+	max_devices = ata_port_max_devices(ap);
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
--- linux.orig/drivers/ata/libata-eh.c	2007-09-21 09:23:13.000000000 +0800
+++ linux/drivers/ata/libata-eh.c	2007-09-21 10:09:10.000000000 +0800
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
--- linux.orig/drivers/ata/libata.h	2007-09-21 09:23:13.000000000 +0800
+++ linux/drivers/ata/libata.h	2007-09-21 10:09:10.000000000 +0800
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
