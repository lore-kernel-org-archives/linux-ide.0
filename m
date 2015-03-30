From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [V8 PATCH 2/3] ACPI / scan: Add support for ACPI _CLS device matching
Date: Mon, 30 Mar 2015 16:56:18 -0500
Message-ID: <1427752579-19234-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1427752579-19234-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0119.outbound.protection.outlook.com ([207.46.100.119]:6009
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753477AbbC3V4e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Mar 2015 17:56:34 -0400
In-Reply-To: <1427752579-19234-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, robert.moore@intel.com, lv.zheng@intel.com, hanjun.guo@linaro.org
Cc: lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Device drivers typically use ACPI _HIDs/_CIDs listed in struct device_driver
acpi_match_table to match devices. However, for generic drivers, we do not
want to list _HID for all supported devices. Also, certain classes of devices
do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS,
which specifies PCI-defined class code (i.e. base-class, subclass and
programming interface). This patch adds support for matching ACPI devices using
the _CLS method.

To support loadable module, current design uses _HID or _CID to match device's
modalias. With the new way of matching with _CLS this would requires modification
to the current ACPI modalias key to include _CLS. This patch appends PCI-defined
class-code to the existing ACPI modalias as following.

    acpi:<HID>:<CID1>:<CID2>:..:<CIDn>:<bbsspp>:
E.g:
    # cat /sys/devices/platform/AMDI0600:00/modalias
    acpi:AMDI0600:010601:

where bb is th base-class code, ss is te sub-class code, and pp is the
programming interface code

Since there would not be _HID/_CID in the ACPI matching table of the driver,
this patch adds a field to acpi_device_id to specify the matching _CLS.

    static const struct acpi_device_id ahci_acpi_match[] = {
        { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
        {},
    };

In this case, the corresponded entry in modules.alias file would be:

    alias acpi*:010601:* ahci_platform

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/acpi/scan.c               | 36 ++++++++++++++++++++++++++++++++----
 include/acpi/acnames.h            |  1 +
 include/acpi/actypes.h            |  4 +++-
 include/linux/acpi.h              | 14 ++++++++++++++
 include/linux/mod_devicetable.h   |  2 ++
 scripts/mod/devicetable-offsets.c |  2 ++
 scripts/mod/file2alias.c          | 32 ++++++++++++++++++++++++++++++--
 7 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c03cadb..d8551cd 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -900,6 +900,29 @@ static void acpi_device_remove_files(struct acpi_device *dev)
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
 
+static bool __acpi_match_device_cls(const struct acpi_device_id *id,
+				    struct acpi_hardware_id *hwid)
+{
+	int i, msk, byte_shift;
+	char buf[3];
+
+	if (!id->cls)
+		return false;
+
+	/* Apply class-code bitmask, before checking each class-code byte */
+	for (i = 1; i <= 3; i++) {
+		byte_shift = 8 * (3 - i);
+		msk = (id->cls_msk >> byte_shift) & 0xFF;
+		if (!msk)
+			continue;
+
+		sprintf(buf, "%02x", (id->cls >> byte_shift) & msk);
+		if (strncmp(buf, &hwid->id[(i - 1) * 2], 2))
+			return false;
+	}
+	return true;
+}
+
 static const struct acpi_device_id *__acpi_match_device(
 	struct acpi_device *device, const struct acpi_device_id *ids)
 {
@@ -913,11 +936,14 @@ static const struct acpi_device_id *__acpi_match_device(
 	if (!device->status.present)
 		return NULL;
 
-	for (id = ids; id->id[0]; id++)
-		list_for_each_entry(hwid, &device->pnp.ids, list)
-			if (!strcmp((char *) id->id, hwid->id))
+	for (id = ids; id->id[0] || id->cls; id++) {
+		list_for_each_entry(hwid, &device->pnp.ids, list) {
+			if (id->id[0] && !strcmp((char *) id->id, hwid->id))
 				return id;
-
+			else if (__acpi_match_device_cls(id, hwid))
+				return id;
+		}
+	}
 	return NULL;
 }
 
@@ -2032,6 +2058,8 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 		if (info->valid & ACPI_VALID_UID)
 			pnp->unique_id = kstrdup(info->unique_id.string,
 							GFP_KERNEL);
+		if (info->valid & ACPI_VALID_CLS)
+			acpi_add_id(pnp, info->cls.string);
 
 		kfree(info);
 
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 273de70..b52c0dc 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -51,6 +51,7 @@
 #define METHOD_NAME__BBN        "_BBN"
 #define METHOD_NAME__CBA        "_CBA"
 #define METHOD_NAME__CID        "_CID"
+#define METHOD_NAME__CLS        "_CLS"
 #define METHOD_NAME__CRS        "_CRS"
 #define METHOD_NAME__DDN        "_DDN"
 #define METHOD_NAME__HID        "_HID"
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index b034f10..ab3dac8 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1148,7 +1148,7 @@ struct acpi_device_info {
 	u32 name;		/* ACPI object Name */
 	acpi_object_type type;	/* ACPI object Type */
 	u8 param_count;		/* If a method, required parameter count */
-	u8 valid;		/* Indicates which optional fields are valid */
+	u16 valid;		/* Indicates which optional fields are valid */
 	u8 flags;		/* Miscellaneous info */
 	u8 highest_dstates[4];	/* _sx_d values: 0xFF indicates not valid */
 	u8 lowest_dstates[5];	/* _sx_w values: 0xFF indicates not valid */
@@ -1157,6 +1157,7 @@ struct acpi_device_info {
 	struct acpi_pnp_device_id hardware_id;	/* _HID value */
 	struct acpi_pnp_device_id unique_id;	/* _UID value */
 	struct acpi_pnp_device_id subsystem_id;	/* _SUB value */
+	struct acpi_pnp_device_id cls;		/* _CLS value */
 	struct acpi_pnp_device_id_list compatible_id_list;	/* _CID list <must be last> */
 };
 
@@ -1174,6 +1175,7 @@ struct acpi_device_info {
 #define ACPI_VALID_CID                  0x20
 #define ACPI_VALID_SXDS                 0x40
 #define ACPI_VALID_SXWS                 0x80
+#define ACPI_VALID_CLS                  0x100
 
 /* Flags for _STA return value (current_status above) */
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index de4e86f..3d1e5dd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -57,6 +57,19 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 #define ACPI_COMPANION_SET(dev, adev)	ACPI_COMPANION(dev) = (adev)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
+/**
+ * ACPI_DEVICE_CLASS - macro used to describe an ACPI device with
+ * the PCI-defined class-code information
+ *
+ * @_cls : the class, subclass, prog-if triple for this device
+ * @_msk : the class mask for this device
+ *
+ * This macro is used to create a struct acpi_device_id that matches a
+ * specific PCI class. The .id and .driver_data fields will be left
+ * initialized with the default value.
+ */
+#define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (_cls), .cls_msk = (_msk),
+
 static inline void acpi_preset_companion(struct device *dev,
 					 struct acpi_device *parent, u64 addr)
 {
@@ -459,6 +472,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *);
 #define ACPI_COMPANION(dev)		(NULL)
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
+#define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (0), .cls_msk = (0),
 
 struct fwnode_handle;
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index e530533..2ed31b8 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -189,6 +189,8 @@ struct css_device_id {
 struct acpi_device_id {
 	__u8 id[ACPI_ID_LEN];
 	kernel_ulong_t driver_data;
+	__u32 cls;
+	__u32 cls_msk;
 };
 
 #define PNP_ID_LEN	8
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index f282516..8987160 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -63,6 +63,8 @@ int main(void)
 
 	DEVID(acpi_device_id);
 	DEVID_FIELD(acpi_device_id, id);
+	DEVID_FIELD(acpi_device_id, cls);
+	DEVID_FIELD(acpi_device_id, cls_msk);
 
 	DEVID(pnp_device_id);
 	DEVID_FIELD(pnp_device_id, id);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e614ef6..704d597 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -511,12 +511,40 @@ static int do_serio_entry(const char *filename,
 }
 ADD_TO_DEVTABLE("serio", serio_device_id, do_serio_entry);
 
-/* looks like: "acpi:ACPI0003 or acpi:PNP0C0B" or "acpi:LNXVIDEO" */
+/* looks like: "acpi:ACPI0003" or "acpi:PNP0C0B" or "acpi:LNXVIDEO" or
+ *             "acpi:bbsspp" (bb=base-class, ss=sub-class, pp=prog-if)
+ *
+ * NOTE: Each driver should use one of the following : _HID, _CIDs
+ *       or _CLS. Also, bb, ss, and pp can be substituted with ??
+ *       as don't care byte.
+ */
 static int do_acpi_entry(const char *filename,
 			void *symval, char *alias)
 {
 	DEF_FIELD_ADDR(symval, acpi_device_id, id);
-	sprintf(alias, "acpi*:%s:*", *id);
+	DEF_FIELD_ADDR(symval, acpi_device_id, cls);
+	DEF_FIELD_ADDR(symval, acpi_device_id, cls_msk);
+
+	if (id && strlen((const char *)*id))
+		sprintf(alias, "acpi*:%s:*", *id);
+	else if (cls) {
+		int i, byte_shift, cnt = 0;
+		unsigned int msk;
+
+		sprintf(&alias[cnt], "acpi*:");
+		cnt = 6;
+		for (i = 1; i <= 3; i++) {
+			byte_shift = 8 * (3-i);
+			msk = (*cls_msk >> byte_shift) & 0xFF;
+			if (msk)
+				sprintf(&alias[cnt], "%02x",
+					(*cls >> byte_shift) & 0xFF);
+			else
+				sprintf(&alias[cnt], "??");
+			cnt += 2;
+		}
+		sprintf(&alias[cnt], ":*");
+	}
 	return 1;
 }
 ADD_TO_DEVTABLE("acpi", acpi_device_id, do_acpi_entry);
-- 
2.1.0

