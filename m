From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/2] ata: acpi: make ata_ap_acpi_handle not block
Date: Sat, 27 Apr 2013 09:33:07 +0800
Message-ID: <517B2AD3.6010305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21954 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab3D0Bbg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Apr 2013 21:31:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, kenzopl@o2.pl, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Since commit 30dcf76acc, ata_ap_acpi_handle will always do a namespace
walk, which requires acquiring an acpi namespace mutex. This made it
impossible to be used when calling path has held a spinlock.

For example, it can occur in the following code path for pata_acpi:
ata_scsi_queuecmd (ap->lock is acquired)
  __ata_scsi_queuecmd
    ata_scsi_translate
      ata_qc_issue
        pacpi_qc_issue
          ata_acpi_stm
            ata_ap_acpi_handle
              acpi_get_child
                acpi_walk_namespace
                  acpi_ut_acquire_mutex (acquire mutex while holding lock)
This caused scheduling while atomic bug, as reported in bug #56781.

Actually, ata_ap_acpi_handle doesn't have to walk the namespace every
time it is called, it can simply return the bound acpi handle on the
corresponding SCSI host. The reason previously it is not done this way
is, ata_ap_acpi_handle is used in the binding function
ata_acpi_bind_host by ata_acpi_gtm when the handle is not bound to the
SCSI host yet. Since we already have the ATA port's handle in its
binding function, we can simply use it instead of calling
ata_ap_acpi_handle there. So introduce a new function __ata_acpi_gtm,
where it will receive an acpi handle param in addition to the ATA port
which is solely used for debug statement. With this change, we can make
ata_ap_acpi_handle simply return the bound handle for SCSI host instead
of walking the acpi namespace now.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=56781
Reported-and-tested-by: <kenzopl@o2.pl>
Cc: <stable@vger.kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 1c33f78..f6d80e3 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -60,7 +60,8 @@ acpi_handle ata_ap_acpi_handle(struct ata_port *ap)
 	if (ap->flags & ATA_FLAG_ACPI_SATA)
 		return NULL;

-	return acpi_get_child(DEVICE_ACPI_HANDLE(ap->host->dev), ap->port_no);
+	return ap->scsi_host ?
+		DEVICE_ACPI_HANDLE(&ap->scsi_host->shost_gendev) : NULL;
 }
 EXPORT_SYMBOL(ata_ap_acpi_handle);

@@ -239,28 +240,15 @@ void ata_acpi_dissociate(struct ata_host *host)
 	}
 }

-/**
- * ata_acpi_gtm - execute _GTM
- * @ap: target ATA port
- * @gtm: out parameter for _GTM result
- *
- * Evaluate _GTM and store the result in @gtm.
- *
- * LOCKING:
- * EH context.
- *
- * RETURNS:
- * 0 on success, -ENOENT if _GTM doesn't exist, -errno on failure.
- */
-int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *gtm)
+static int __ata_acpi_gtm(struct ata_port *ap, acpi_handle handle,
+			  struct ata_acpi_gtm *gtm)
 {
 	struct acpi_buffer output = { .length = ACPI_ALLOCATE_BUFFER };
 	union acpi_object *out_obj;
 	acpi_status status;
 	int rc = 0;

-	status = acpi_evaluate_object(ata_ap_acpi_handle(ap), "_GTM", NULL,
-				      &output);
+	status = acpi_evaluate_object(handle, "_GTM", NULL, &output);

 	rc = -ENOENT;
 	if (status == AE_NOT_FOUND)
@@ -294,6 +282,27 @@ int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *gtm)
 	return rc;
 }

+/**
+ * ata_acpi_gtm - execute _GTM
+ * @ap: target ATA port
+ * @gtm: out parameter for _GTM result
+ *
+ * Evaluate _GTM and store the result in @gtm.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -ENOENT if _GTM doesn't exist, -errno on failure.
+ */
+int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *gtm)
+{
+	if (ata_ap_acpi_handle(ap))
+		return __ata_acpi_gtm(ap, ata_ap_acpi_handle(ap), gtm);
+	else
+		return -EINVAL;
+}
+
 EXPORT_SYMBOL_GPL(ata_acpi_gtm);

 /**
@@ -1047,7 +1056,7 @@ static int ata_acpi_bind_host(struct ata_port *ap, acpi_handle *handle)
 	if (!*handle)
 		return -ENODEV;

-	if (ata_acpi_gtm(ap, &ap->__acpi_init_gtm) == 0)
+	if (__ata_acpi_gtm(ap, *handle, &ap->__acpi_init_gtm) == 0)
 		ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;

 	return 0;
-- 
1.8.2.1.94.g173f9a7

