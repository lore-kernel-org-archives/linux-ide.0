From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] libata: pm: differentiate system and runtime pm for ata port
Date: Tue, 28 Aug 2012 16:49:51 +0800
Message-ID: <1346143791-2995-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:20066 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2H1IuS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Aug 2012 04:50:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lu@intel.com>

For sata port, only runtime pm needs to be taken care of;
For IDE port, only system pm needs to be taken care of.
Currently, we use PMSG_SUSPEND for both system suspend and runtime
suspend and PMSG_ON for both system resume and runtime resume.

Change this by using PMSG_AUTO_SUSPEND for runtime suspend and
PMSG_AUTO_RESUME for runtime resume.

The ata_acpi_set_state is modified accordingly. And the sata case and
pata case is seperated for easy understanding.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 83 ++++++++++++++++++++++++++++++++---------------
 drivers/ata/libata-core.c | 22 +++++++++----
 drivers/ata/libata-eh.c   |  9 ++---
 3 files changed, 78 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index fd9ecf7..b67b565 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -832,50 +832,81 @@ void ata_acpi_on_resume(struct ata_port *ap)
 	}
 }
 
-/**
- * ata_acpi_set_state - set the port power state
- * @ap: target ATA port
- * @state: state, on/off
- *
- * This function executes the _PS0/_PS3 ACPI method to set the power state.
- * ACPI spec requires _PS0 when IDE power on and _PS3 when power off
- */
-void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
+static void sata_acpi_set_state(struct ata_port *ap, pm_message_t state)
 {
-	struct ata_device *dev;
-	acpi_handle handle;
 	int acpi_state;
+	acpi_handle handle;
+	struct ata_device *dev;
 
-	/* channel first and then drives for power on and vica versa
-	   for power off */
-	handle = ata_ap_acpi_handle(ap);
-	if (handle && state.event == PM_EVENT_ON)
-		acpi_bus_set_power(handle, ACPI_STATE_D0);
+	if (!PMSG_IS_AUTO(state))
+		return;
 
 	ata_for_each_dev(dev, &ap->link, ENABLED) {
 		handle = ata_dev_acpi_handle(dev);
 		if (!handle)
 			continue;
 
-		if (state.event != PM_EVENT_ON) {
+		if (state.event == PM_EVENT_AUTO_SUSPEND) {
 			acpi_state = acpi_pm_device_sleep_state(
 				&dev->sdev->sdev_gendev, NULL, ACPI_STATE_D3);
 			if (acpi_state > 0)
 				acpi_bus_set_power(handle, acpi_state);
-			/* TBD: need to check if it's runtime pm request */
-			acpi_pm_device_run_wake(
-				&dev->sdev->sdev_gendev, true);
+			acpi_pm_device_run_wake(&dev->sdev->sdev_gendev, true);
 		} else {
-			/* Ditto */
-			acpi_pm_device_run_wake(
-				&dev->sdev->sdev_gendev, false);
+			acpi_pm_device_run_wake(&dev->sdev->sdev_gendev, false);
 			acpi_bus_set_power(handle, ACPI_STATE_D0);
 		}
 	}
+}
+
+/**
+ * pata_acpi_set_state - set the port power state
+ * @ap: target ATA port
+ * @state: state, on/off
+ *
+ * This function executes the _PS0/_PS3 ACPI method to set the power state.
+ * ACPI spec requires _PS0 when IDE power on and _PS3 when power off
+ */
+static void pata_acpi_set_state(struct ata_port *ap, pm_message_t state)
+{
+	struct ata_device *dev;
+
+	if (!ata_ap_acpi_handle(ap))
+		return;
+
+	/*
+	 * Channel first and then drives for power on and
+	 * vica versa for power off
+	 */
+	if (state.event == PM_EVENT_ON)
+		acpi_bus_set_power(ata_ap_acpi_handle(ap), ACPI_STATE_D0);
+
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
+		if (ata_dev_acpi_handle(dev))
+			acpi_bus_set_power(ata_dev_acpi_handle(dev),
+					state.event == PM_EVENT_ON ?
+					ACPI_STATE_D0 : ACPI_STATE_D3);
+
+	}
 
-	handle = ata_ap_acpi_handle(ap);
-	if (handle && state.event != PM_EVENT_ON)
-		acpi_bus_set_power(handle, ACPI_STATE_D3);
+	if (state.event != PM_EVENT_ON)
+		acpi_bus_set_power(ata_ap_acpi_handle(ap), ACPI_STATE_D3);
+}
+
+/**
+ * ata_acpi_set_state - set the port power state
+ * @ap: target ATA port
+ * @state: state, on/off
+ *
+ * Depends on whether the port is a PATA port or a SATA port,
+ * this function calls into different functions.
+ */
+void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
+{
+	if (ap->flags & ATA_FLAG_ACPI_SATA)
+		sata_acpi_set_state(ap, state);
+	else
+		pata_acpi_set_state(ap, state);
 }
 
 /**
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8e1039c..8fdc8e3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5309,7 +5309,7 @@ static int ata_port_suspend_common(struct device *dev, pm_message_t mesg)
 	 *
 	 * http://thread.gmane.org/gmane.linux.ide/46764
 	 */
-	if (mesg.event == PM_EVENT_SUSPEND)
+	if (mesg.event & PM_EVENT_SUSPEND)
 		ehi_flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_NO_RECOVERY;
 
 	rc = ata_port_request_pm(ap, mesg, 0, ehi_flags, 1);
@@ -5324,6 +5324,11 @@ static int ata_port_suspend(struct device *dev)
 	return ata_port_suspend_common(dev, PMSG_SUSPEND);
 }
 
+static int ata_port_runtime_suspend(struct device *dev)
+{
+	return ata_port_suspend_common(dev, PMSG_AUTO_SUSPEND);
+}
+
 static int ata_port_do_freeze(struct device *dev)
 {
 	if (pm_runtime_suspended(dev))
@@ -5340,12 +5345,12 @@ static int ata_port_poweroff(struct device *dev)
 	return ata_port_suspend_common(dev, PMSG_HIBERNATE);
 }
 
-static int ata_port_resume_common(struct device *dev)
+static int ata_port_resume_common(struct device *dev, pm_message_t mesg)
 {
 	struct ata_port *ap = to_ata_port(dev);
 	int rc;
 
-	rc = ata_port_request_pm(ap, PMSG_ON, ATA_EH_RESET,
+	rc = ata_port_request_pm(ap, mesg, ATA_EH_RESET,
 		ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 1);
 	return rc;
 }
@@ -5354,7 +5359,7 @@ static int ata_port_resume(struct device *dev)
 {
 	int rc;
 
-	rc = ata_port_resume_common(dev);
+	rc = ata_port_resume_common(dev, PMSG_ON);
 	if (!rc) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
@@ -5364,6 +5369,11 @@ static int ata_port_resume(struct device *dev)
 	return rc;
 }
 
+static int ata_port_runtime_resume(struct device *dev)
+{
+	return ata_port_resume_common(dev, PMSG_AUTO_RESUME);
+}
+
 static int ata_port_runtime_idle(struct device *dev)
 {
 	return pm_runtime_suspend(dev);
@@ -5377,8 +5387,8 @@ static const struct dev_pm_ops ata_port_pm_ops = {
 	.poweroff = ata_port_poweroff,
 	.restore = ata_port_resume,
 
-	.runtime_suspend = ata_port_suspend,
-	.runtime_resume = ata_port_resume_common,
+	.runtime_suspend = ata_port_runtime_suspend,
+	.runtime_resume = ata_port_runtime_resume,
 	.runtime_idle = ata_port_runtime_idle,
 };
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7d4535e..f3eced6 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4021,7 +4021,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	/* are we suspending? */
 	spin_lock_irqsave(ap->lock, flags);
 	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
-	    ap->pm_mesg.event == PM_EVENT_ON) {
+	    !(ap->pm_mesg.event & PM_EVENT_SUSPEND)) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return;
 	}
@@ -4040,7 +4040,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	if (ap->ops->port_suspend)
 		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
 
-	ata_acpi_set_state(ap, PMSG_SUSPEND);
+	ata_acpi_set_state(ap, ap->pm_mesg);
  out:
 	/* report result */
 	spin_lock_irqsave(ap->lock, flags);
@@ -4080,7 +4080,8 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	/* are we resuming? */
 	spin_lock_irqsave(ap->lock, flags);
 	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
-	    ap->pm_mesg.event != PM_EVENT_ON) {
+	    (ap->pm_mesg.event != PM_EVENT_ON &&
+	     ap->pm_mesg.event != PM_EVENT_AUTO_RESUME)) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return;
 	}
@@ -4099,7 +4100,7 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 		ata_for_each_dev(dev, link, ALL)
 			ata_ering_clear(&dev->ering);
 
-	ata_acpi_set_state(ap, PMSG_ON);
+	ata_acpi_set_state(ap, ap->pm_mesg);
 
 	if (ap->ops->port_resume)
 		rc = ap->ops->port_resume(ap);
-- 
1.7.11.5

