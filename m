Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6013C918
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318438; cv=none; b=EIjDt65PhHypmU/qb1zQdbZieKhVjFA27SgSO9aBRs9EJ2pvG0mROF/6q6bykiQj0WkaENddvAnkjDiP7tiYGkA0vjyLwT7ZBXUBl3OiaCuuC2a6gFY6TidpRV0RPuNibM9zIKExl/iB8jgM9OPcMuGSIrO1eSwM6viduerri+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318438; c=relaxed/simple;
	bh=tqy3kszxP8WQrTVMWB28CdB055vb8QNB+4ApL2hh/iI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7Waj1gkMJzgMAlmfcaOkEWUVa1yJpXSHI6LEfrGKOEG+75qrbzIu0KvenvfSXvZlWsGmsfGeMz2FJq7numYZfATMhNPUbl+S2/AReNAS9ol3UhWdO2vCtRHshi8A7m1XPMImChMLkfRa0MiXvhhEvLZPeDge3P6kxmS4EpLCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkJqMKGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkJqMKGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF98C4CEC6;
	Mon,  2 Sep 2024 23:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725318437;
	bh=tqy3kszxP8WQrTVMWB28CdB055vb8QNB+4ApL2hh/iI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RkJqMKGzGQDKk8eWsQfswNtWT9c1MTlSv7h+I7wspSsGlyXRRHadbXDYjD2kpMsTP
	 G2Wrh23EOj5fYI9Kw3f+yPRZqKn1kaV8S2gUSavheCFgtcWLbhYH/dBOnuYwr3Dyfb
	 gA1hR1KV8OXI80oY6Y+NEE9V0gzdf9woZpEhCZ++ZRxqWEt7pqc19LhSzl3Vn0ZonO
	 Q6JOecAbNjEP0Ssj7r0amiCXzF5D4GWiW7hoP5tnoz8HAO/JWOnwMQVhLzJlA5tD7v
	 NektchTSATFKBnjeLC1QDscL9MsmVUi849xEl629JXHvbj6v11yvbtI0d4/4LhTBJp
	 90tmqfsqVgyWw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 1/7] ata: libata: Cleanup libata-transport
Date: Tue,  3 Sep 2024 08:07:09 +0900
Message-ID: <20240902230715.176522-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902230715.176522-1-dlemoal@kernel.org>
References: <20240902230715.176522-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the ATA link transport device related functions after the ATA
transport device related functions to avoid the need for forward
declaring ata_tdev_add() and ata_tdev_delete().

And while at it, do the following:
1) Change ata_is_ata_dev() and ata_is_link() to return a boolean
2) Fix a pointer declaration style in ata_is_ata_dev()
3) Improve the kdoc comments for ata_tdev_free(), ata_tdev_delete(),
   ata_tdev_add(), ata_tlink_delete() and ata_tlink_add()

No functional changes are introduced by this cleanup.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-transport.c | 299 ++++++++++++++++-----------------
 1 file changed, 147 insertions(+), 152 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 48800cd0e75d..d9a1888eac34 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -80,12 +80,6 @@ struct ata_internal {
 #define transport_class_to_port(dev)				\
 	tdev_to_port((dev)->parent)
 
-
-/* Device objects are always created whit link objects */
-static int ata_tdev_add(struct ata_device *dev);
-static void ata_tdev_delete(struct ata_device *dev);
-
-
 /*
  * Hack to allow attributes of the same name in different objects.
  */
@@ -364,135 +358,6 @@ unsigned int ata_port_classify(struct ata_port *ap,
 }
 EXPORT_SYMBOL_GPL(ata_port_classify);
 
-/*
- * ATA link attributes
- */
-static int noop(int x) { return x; }
-
-#define ata_link_show_linkspeed(field, format)				\
-static ssize_t								\
-show_ata_link_##field(struct device *dev,				\
-		      struct device_attribute *attr, char *buf)		\
-{									\
-	struct ata_link *link = transport_class_to_link(dev);		\
-									\
-	return sprintf(buf, "%s\n", sata_spd_string(format(link->field))); \
-}
-
-#define ata_link_linkspeed_attr(field, format)				\
-	ata_link_show_linkspeed(field, format)				\
-static DEVICE_ATTR(field, S_IRUGO, show_ata_link_##field, NULL)
-
-ata_link_linkspeed_attr(hw_sata_spd_limit, fls);
-ata_link_linkspeed_attr(sata_spd_limit, fls);
-ata_link_linkspeed_attr(sata_spd, noop);
-
-
-static DECLARE_TRANSPORT_CLASS(ata_link_class,
-		"ata_link", NULL, NULL, NULL);
-
-static void ata_tlink_release(struct device *dev)
-{
-}
-
-/**
- * ata_is_link --  check if a struct device represents a ATA link
- * @dev:	device to check
- *
- * Returns:
- *	%1 if the device represents a ATA link, %0 else
- */
-static int ata_is_link(const struct device *dev)
-{
-	return dev->release == ata_tlink_release;
-}
-
-static int ata_tlink_match(struct attribute_container *cont,
-			   struct device *dev)
-{
-	struct ata_internal* i = to_ata_internal(ata_scsi_transport_template);
-	if (!ata_is_link(dev))
-		return 0;
-	return &i->link_attr_cont.ac == cont;
-}
-
-/**
- * ata_tlink_delete  --  remove ATA LINK
- * @link:	ATA LINK to remove
- *
- * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
- */
-void ata_tlink_delete(struct ata_link *link)
-{
-	struct device *dev = &link->tdev;
-	struct ata_device *ata_dev;
-
-	ata_for_each_dev(ata_dev, link, ALL) {
-		ata_tdev_delete(ata_dev);
-	}
-
-	transport_remove_device(dev);
-	device_del(dev);
-	transport_destroy_device(dev);
-	put_device(dev);
-}
-
-/**
- * ata_tlink_add  --  initialize a transport ATA link structure
- * @link:	allocated ata_link structure.
- *
- * Initialize an ATA LINK structure for sysfs.  It will be added in the
- * device tree below the ATA PORT it belongs to.
- *
- * Returns %0 on success
- */
-int ata_tlink_add(struct ata_link *link)
-{
-	struct device *dev = &link->tdev;
-	struct ata_port *ap = link->ap;
-	struct ata_device *ata_dev;
-	int error;
-
-	device_initialize(dev);
-	dev->parent = &ap->tdev;
-	dev->release = ata_tlink_release;
-	if (ata_is_host_link(link))
-		dev_set_name(dev, "link%d", ap->print_id);
-	else
-		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
-
-	transport_setup_device(dev);
-
-	error = device_add(dev);
-	if (error) {
-		goto tlink_err;
-	}
-
-	error = transport_add_device(dev);
-	if (error)
-		goto tlink_transport_err;
-	transport_configure_device(dev);
-
-	ata_for_each_dev(ata_dev, link, ALL) {
-		error = ata_tdev_add(ata_dev);
-		if (error) {
-			goto tlink_dev_err;
-		}
-	}
-	return 0;
-  tlink_dev_err:
-	while (--ata_dev >= link->device) {
-		ata_tdev_delete(ata_dev);
-	}
-	transport_remove_device(dev);
-  tlink_transport_err:
-	device_del(dev);
-  tlink_err:
-	transport_destroy_device(dev);
-	put_device(dev);
-	return error;
-}
-
 /*
  * ATA device attributes
  */
@@ -643,9 +508,9 @@ static void ata_tdev_release(struct device *dev)
  * @dev:	device to check
  *
  * Returns:
- *	%1 if the device represents a ATA device, %0 else
+ *	true if the device represents a ATA device, false otherwise
  */
-static int ata_is_ata_dev(const struct device *dev)
+static bool ata_is_ata_dev(const struct device *dev)
 {
 	return dev->release == ata_tdev_release;
 }
@@ -653,21 +518,22 @@ static int ata_is_ata_dev(const struct device *dev)
 static int ata_tdev_match(struct attribute_container *cont,
 			  struct device *dev)
 {
-	struct ata_internal* i = to_ata_internal(ata_scsi_transport_template);
+	struct ata_internal *i = to_ata_internal(ata_scsi_transport_template);
+
 	if (!ata_is_ata_dev(dev))
 		return 0;
 	return &i->dev_attr_cont.ac == cont;
 }
 
 /**
- * ata_tdev_free  --  free a ATA LINK
- * @dev:	ATA PHY to free
+ * ata_tdev_free  --  free an ATA transport device
+ * @dev:	struct ata_device owning the transport device to free
  *
- * Frees the specified ATA PHY.
+ * Free the ATA transport device for the specified ATA device.
  *
  * Note:
- *   This function must only be called on a PHY that has not
- *   successfully been added using ata_tdev_add().
+ *   This function must only be called for a ATA transport device that has not
+ *   yet successfully been added using ata_tdev_add().
  */
 static void ata_tdev_free(struct ata_device *dev)
 {
@@ -676,10 +542,10 @@ static void ata_tdev_free(struct ata_device *dev)
 }
 
 /**
- * ata_tdev_delete  --  remove ATA device
- * @ata_dev:	ATA device to remove
+ * ata_tdev_delete  --  remove an ATA transport device
+ * @ata_dev:	struct ata_device owning the transport device to delete
  *
- * Removes the specified ATA device.
+ * Removes the ATA transport device for the specified ATA device.
  */
 static void ata_tdev_delete(struct ata_device *ata_dev)
 {
@@ -690,15 +556,14 @@ static void ata_tdev_delete(struct ata_device *ata_dev)
 	ata_tdev_free(ata_dev);
 }
 
-
 /**
- * ata_tdev_add  --  initialize a transport ATA device structure.
- * @ata_dev:	ata_dev structure.
+ * ata_tdev_add  --  initialize an ATA transport device
+ * @ata_dev:	struct ata_device owning the transport device to add
  *
- * Initialize an ATA device structure for sysfs.  It will be added in the
- * device tree below the ATA LINK device it belongs to.
+ * Initialize an ATA transport device for sysfs.  It will be added in the
+ * device tree below the ATA link device it belongs to.
  *
- * Returns %0 on success
+ * Returns %0 on success and a negative error code on error.
  */
 static int ata_tdev_add(struct ata_device *ata_dev)
 {
@@ -734,6 +599,136 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	return 0;
 }
 
+/*
+ * ATA link attributes
+ */
+static int noop(int x)
+{
+	return x;
+}
+
+#define ata_link_show_linkspeed(field, format)			\
+static ssize_t							\
+show_ata_link_##field(struct device *dev,			\
+		      struct device_attribute *attr, char *buf)	\
+{								\
+	struct ata_link *link = transport_class_to_link(dev);	\
+								\
+	return sprintf(buf, "%s\n",				\
+		       sata_spd_string(format(link->field)));	\
+}
+
+#define ata_link_linkspeed_attr(field, format)			\
+	ata_link_show_linkspeed(field, format)			\
+static DEVICE_ATTR(field, 0444, show_ata_link_##field, NULL)
+
+ata_link_linkspeed_attr(hw_sata_spd_limit, fls);
+ata_link_linkspeed_attr(sata_spd_limit, fls);
+ata_link_linkspeed_attr(sata_spd, noop);
+
+static DECLARE_TRANSPORT_CLASS(ata_link_class,
+		"ata_link", NULL, NULL, NULL);
+
+static void ata_tlink_release(struct device *dev)
+{
+}
+
+/**
+ * ata_is_link --  check if a struct device represents a ATA link
+ * @dev:	device to check
+ *
+ * Returns:
+ *	true if the device represents a ATA link, false otherwise
+ */
+static bool ata_is_link(const struct device *dev)
+{
+	return dev->release == ata_tlink_release;
+}
+
+static int ata_tlink_match(struct attribute_container *cont,
+			    struct device *dev)
+{
+	struct ata_internal *i = to_ata_internal(ata_scsi_transport_template);
+
+	if (!ata_is_link(dev))
+		return 0;
+	return &i->link_attr_cont.ac == cont;
+}
+
+/**
+ * ata_tlink_delete  --  remove an ATA link transport device
+ * @link:	struct ata_link owning the link transport device to remove
+ *
+ * Removes the link transport device of the specified ATA link. This also
+ * removes the ATA device(s) associated with the link as well.
+ */
+void ata_tlink_delete(struct ata_link *link)
+{
+	struct device *dev = &link->tdev;
+	struct ata_device *ata_dev;
+
+	ata_for_each_dev(ata_dev, link, ALL) {
+		ata_tdev_delete(ata_dev);
+	}
+
+	transport_remove_device(dev);
+	device_del(dev);
+	transport_destroy_device(dev);
+	put_device(dev);
+}
+
+/**
+ * ata_tlink_add  --  initialize an ATA link transport device
+ * @ata_link:	struct ata_link owning the link transport device to initialize
+ *
+ * Initialize an ATA link transport device for sysfs. It will be added in the
+ * device tree below the ATA port it belongs to.
+ *
+ * Returns %0 on success and a negative error code on error.
+ */
+int ata_tlink_add(struct ata_link *link)
+{
+	struct device *dev = &link->tdev;
+	struct ata_port *ap = link->ap;
+	struct ata_device *ata_dev;
+	int error;
+
+	device_initialize(dev);
+	dev->parent = &ap->tdev;
+	dev->release = ata_tlink_release;
+	if (ata_is_host_link(link))
+		dev_set_name(dev, "link%d", ap->print_id);
+	else
+		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
+
+	transport_setup_device(dev);
+
+	error = device_add(dev);
+	if (error)
+		goto tlink_err;
+
+	error = transport_add_device(dev);
+	if (error)
+		goto tlink_transport_err;
+	transport_configure_device(dev);
+
+	ata_for_each_dev(ata_dev, link, ALL) {
+		error = ata_tdev_add(ata_dev);
+		if (error)
+			goto tlink_dev_err;
+	}
+	return 0;
+ tlink_dev_err:
+	while (--ata_dev >= link->device)
+		ata_tdev_delete(ata_dev);
+	transport_remove_device(dev);
+ tlink_transport_err:
+	device_del(dev);
+ tlink_err:
+	transport_destroy_device(dev);
+	put_device(dev);
+	return error;
+}
 
 /*
  * Setup / Teardown code
-- 
2.46.0

