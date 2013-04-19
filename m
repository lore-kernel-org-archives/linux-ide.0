From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [Bug 56781] New: BUG: scheduling while atomic: modprobe/256/0x00000100
Date: Fri, 19 Apr 2013 16:58:48 +0800
Message-ID: <51710748.6070802@intel.com>
References: <bug-56781-12015@https.bugzilla.kernel.org/> <87zjww2w3x.fsf@rustcorp.com.au> <20130418183209.GG9897@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10889 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758248Ab3DSI51 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Apr 2013 04:57:27 -0400
In-Reply-To: <20130418183209.GG9897@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, bugzilla-daemon@bugzilla.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 04/19/2013 02:32 AM, Tejun Heo wrote:
> Hello,
> 
> (cc'ing Jeff, linux-ide and copying the whole message)
> 
> So, the problem seems to be inside pata_acpi driver.  It's calling
> pacpi_set_piomode() from qc_issue path while holding the queue lock.
> pacpi_set_piomode() calls into acpi which may sleep.  It gets blocked
> on a semaphore and triggers the bug.  Maybe some changes between 3.8.6
> and 3.8.8 made it more likely to trigger but fundamentally it's a bug
> in the pata_acpi driver.  It can't directly call into acpi while
> holding queue lock.

The ata acpi code to get port's handle used to not block, but since the
rework to bind ata handle to scsi device tree, it is now.

I didn't check how much work is required to modify the pata acpi driver
to solve the problem, but I have written a patch to make
ata_ap_acpi_handle(which ata_acpi_gtm calls) does not block, and so
should be able to fix this problem. I'll attach that patch to the bug
page too for the reporter to test soon.

Patch here, not tested:

 drivers/ata/libata-acpi.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 1c33f78..0e6cf89 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -60,7 +60,7 @@ acpi_handle ata_ap_acpi_handle(struct ata_port *ap)
 	if (ap->flags & ATA_FLAG_ACPI_SATA)
 		return NULL;
 
-	return acpi_get_child(DEVICE_ACPI_HANDLE(ap->host->dev), ap->port_no);
+	return ACPI_HANDLE(ap->host->dev);
 }
 EXPORT_SYMBOL(ata_ap_acpi_handle);
 
@@ -239,28 +239,15 @@ void ata_acpi_dissociate(struct ata_host *host)
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
@@ -294,6 +281,27 @@ int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *gtm)
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
@@ -1047,7 +1055,7 @@ static int ata_acpi_bind_host(struct ata_port *ap, acpi_handle *handle)
 	if (!*handle)
 		return -ENODEV;
 
-	if (ata_acpi_gtm(ap, &ap->__acpi_init_gtm) == 0)
+	if (__ata_acpi_gtm(ap, *handle, &ap->__acpi_init_gtm) == 0)
 		ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;
 
 	return 0;
-- 
1.8.2.1

Thanks,
Aaron

