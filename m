From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] hook ACPI _PSx method to IDE power on/off
Date: Thu, 02 Aug 2007 14:14:08 +0800
Message-ID: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>
List-Id: linux-ide@vger.kernel.org

ACPI spec defines the sequence of IDE power on/off:
Powering down:
	Call _GTM.
	Power down drive (calls _PS3 method and turns off power planes).
Powering up:
	Power up drive (calls _PS0 method if present and turns on power planes).
	Call _STM passing info from _GTM (possibly modified), with ID data from
	each drive.
	Initialize the channel.
	May modify the results of _GTF.
	For each drive:
		Call _GTF.
		Execute task file (possibly modified).
This patch adds the missed _PS0/_PS3 methods call.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: linux/drivers/ide/ide-acpi.c
===================================================================
--- linux.orig/drivers/ide/ide-acpi.c	2007-08-02 13:34:43.000000000 +0800
+++ linux/drivers/ide/ide-acpi.c	2007-08-02 13:51:21.000000000 +0800
@@ -612,6 +612,46 @@ void ide_acpi_push_timing(ide_hwif_t *hw
 EXPORT_SYMBOL_GPL(ide_acpi_push_timing);
 
 /**
+ * ide_acpi_set_state - set the channel power state
+ * @hwif: target IDE interface
+ * @on: state, on/off
+ *
+ * This function executes the _PS0/_PS3 ACPI method to set the power state.
+ * ACPI spec requires _PS0 when IDE power on and _PS3 when power off
+ */
+void ide_acpi_set_state(ide_hwif_t *hwif, int on)
+{
+	int unit;
+
+	if (ide_noacpi)
+		return;
+
+	DEBPRINT("ENTER:\n");
+
+	if (!hwif->acpidata) {
+		DEBPRINT("no ACPI data for %s\n", hwif->name);
+		return;
+	}
+	/* channel first and then drives for power on and verse versa for power off */
+	if (on)
+		acpi_bus_set_power(hwif->acpidata->obj_handle, ACPI_STATE_D0);
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+		ide_drive_t *drive = &hwif->drives[unit];
+
+		if (!drive->acpidata->obj_handle)
+			drive->acpidata->obj_handle = ide_acpi_drive_get_handle(drive);
+
+		if (drive->acpidata->obj_handle && drive->present) {
+			acpi_bus_set_power(drive->acpidata->obj_handle,
+				on? ACPI_STATE_D0: ACPI_STATE_D3);
+		}
+	}
+	if (!on)
+		acpi_bus_set_power(hwif->acpidata->obj_handle, ACPI_STATE_D3);
+}
+EXPORT_SYMBOL_GPL(ide_acpi_set_state);
+
+/**
  * ide_acpi_init - initialize the ACPI link for an IDE interface
  * @hwif: target IDE interface (channel)
  *
@@ -679,6 +719,8 @@ void ide_acpi_init(ide_hwif_t *hwif)
 		return;
 	}
 
+	/* ACPI _PS0 before _STM */
+	ide_acpi_set_state(hwif, 1);
 	/*
 	 * ACPI requires us to call _STM on startup
 	 */
Index: linux/drivers/ide/ide.c
===================================================================
--- linux.orig/drivers/ide/ide.c	2007-08-02 13:34:43.000000000 +0800
+++ linux/drivers/ide/ide.c	2007-08-02 13:35:28.000000000 +0800
@@ -914,6 +914,7 @@ static int generic_ide_suspend(struct de
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
+	int ret;
 
 	/* Call ACPI _GTM only once */
 	if (!(drive->dn % 2))
@@ -930,7 +931,14 @@ static int generic_ide_suspend(struct de
 		mesg.event = PM_EVENT_FREEZE;
 	rqpm.pm_state = mesg.event;
 
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	ret = ide_do_drive_cmd(drive, &rq, ide_wait);
+	/* only call ACPI _PS3 after both drivers are suspended */
+	if (!ret && (((drive->dn % 2) && hwif->drives[0].present
+		 && hwif->drives[1].present)
+		 || !hwif->drives[0].present
+		 || !hwif->drives[1].present))
+		ide_acpi_set_state(hwif, 0);
+	return ret;
 }
 
 static int generic_ide_resume(struct device *dev)
@@ -943,8 +951,10 @@ static int generic_ide_resume(struct dev
 	int err;
 
 	/* Call ACPI _STM only once */
-	if (!(drive->dn % 2))
+	if (!(drive->dn % 2)) {
+		ide_acpi_set_state(hwif, 1);
 		ide_acpi_push_timing(hwif);
+	}
 
 	ide_acpi_exec_tfs(drive);
 
Index: linux/include/linux/ide.h
===================================================================
--- linux.orig/include/linux/ide.h	2007-08-02 13:34:43.000000000 +0800
+++ linux/include/linux/ide.h	2007-08-02 13:35:28.000000000 +0800
@@ -1337,11 +1337,13 @@ extern int ide_acpi_exec_tfs(ide_drive_t
 extern void ide_acpi_get_timing(ide_hwif_t *hwif);
 extern void ide_acpi_push_timing(ide_hwif_t *hwif);
 extern void ide_acpi_init(ide_hwif_t *hwif);
+extern void ide_acpi_set_state(ide_hwif_t *hwif, int on);
 #else
 static inline int ide_acpi_exec_tfs(ide_drive_t *drive) { return 0; }
 static inline void ide_acpi_get_timing(ide_hwif_t *hwif) { ; }
 static inline void ide_acpi_push_timing(ide_hwif_t *hwif) { ; }
 static inline void ide_acpi_init(ide_hwif_t *hwif) { ; }
+static inline void ide_acpi_set_state(ide_hwif_t *hwif, int on) {}
 #endif
 
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c	2007-08-02 13:35:06.000000000 +0800
+++ linux/drivers/acpi/bus.c	2007-08-02 13:56:56.000000000 +0800
@@ -262,10 +262,12 @@ int acpi_bus_set_power(acpi_handle handl
 		printk(KERN_WARNING PREFIX
 			      "Transitioning device [%s] to D%d\n",
 			      device->pnp.bus_id, state);
-	else
+	else {
+		device->power.state = state;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device [%s] transitioned to D%d\n",
 				  device->pnp.bus_id, state));
+	}
 
 	return result;
 }
