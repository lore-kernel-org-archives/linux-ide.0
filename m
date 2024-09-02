Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568F111AD
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725235247; cv=none; b=Xlhjs8EYvT0SshLkpaDRMkaYWQrfVX5Iwl/Sf0hXc++94DjYDVaUkL2xcWYXqN4KY//58352CGFvk1T8QvFoTDKBrnFqDqItJcgV4x2kqRrWamM/IGQbbACxkDffDVT/CQfTDH0IGFCFRt6Qy47d1Lb79zdL55dfmz7OOKjDrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725235247; c=relaxed/simple;
	bh=UArPnVyQXV1t9yx+xV0aYt75Pi0mNwujWBdUOEJ21Mo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2uaTE6aHddvB4jdj/XcRR6ddiPUU++F9ckED/miP4Oa9ZtmXRFC5ELWATVtZXAtwBW6C8CbExciRyiQY4xh/tT/c6vr808LE7jqdgvVtzFhxVURvlKea3h/519H8XxjYu73yERszVJEcyaTmxZx19QBJqBP0k2WrV5hwNYvKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsQK+Vop; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsQK+Vop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECAAC4CEC8;
	Mon,  2 Sep 2024 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725235246;
	bh=UArPnVyQXV1t9yx+xV0aYt75Pi0mNwujWBdUOEJ21Mo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hsQK+Vop+01uL89Rb89HYZuU9KuLxLkLL9V7KMsMj7AQVk+5vlQc/rTkRksXg9vfp
	 J4kHih77fmdHb9Tr3/+gevpS2q/A/mbv9x3EUTWtbKFtqT09sogrtn3xIs2I+tt5+G
	 YCIT8Ry9L8LKXHoNR1Umrlkj/zMIveYjHmTunrnkPjNE6iCClhd9m9LTmiCiILltNF
	 BUZLNEhhv1C15uNdVQa0apXGqeWG9gYv95Hj0k2KvTZmkJ9pZUZMViR2V8q0L/nGw+
	 eLpVit334eHa16bvONjR1DbdoTIpMvwmOTRf4hYmig9RnmFYcegi8dsww6VhlZv3j/
	 YKu77PNcPAXNQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/7] ata: libata: Cleanup libata-transport
Date: Mon,  2 Sep 2024 09:00:37 +0900
Message-ID: <20240902000043.155495-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902000043.155495-1-dlemoal@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the transport link device related functions after the device
transport related functions to avoid the need for forward declaring
ata_tdev_add() and ata_tdev_delete().

And while at it, improve the kdoc comments for ata_tdev_free() and
ata_tdev_delete().

No functional changes are introduced.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-transport.c | 281 ++++++++++++++++-----------------
 1 file changed, 137 insertions(+), 144 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 48800cd0e75d..2a5025b2f28b 100644
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
@@ -660,14 +525,14 @@ static int ata_tdev_match(struct attribute_container *cont,
 }
 
 /**
- * ata_tdev_free  --  free a ATA LINK
- * @dev:	ATA PHY to free
+ * ata_tdev_free  --  free a transport ATA device structure
+ * @dev:	target ATA device
  *
- * Frees the specified ATA PHY.
+ * Free the transport ATA device structure for the specified ATA device.
  *
  * Note:
- *   This function must only be called on a PHY that has not
- *   successfully been added using ata_tdev_add().
+ *   This function must only be called on a device that has not successfully
+ *   been added using ata_tdev_add().
  */
 static void ata_tdev_free(struct ata_device *dev)
 {
@@ -676,10 +541,10 @@ static void ata_tdev_free(struct ata_device *dev)
 }
 
 /**
- * ata_tdev_delete  --  remove ATA device
- * @ata_dev:	ATA device to remove
+ * ata_tdev_delete  --  remove an ATA device sysfs entry
+ * @ata_dev:	target ATA device
  *
- * Removes the specified ATA device.
+ * Removes the transport sysfs entry for the specified ATA device.
  */
 static void ata_tdev_delete(struct ata_device *ata_dev)
 {
@@ -690,7 +555,6 @@ static void ata_tdev_delete(struct ata_device *ata_dev)
 	ata_tdev_free(ata_dev);
 }
 
-
 /**
  * ata_tdev_add  --  initialize a transport ATA device structure.
  * @ata_dev:	ata_dev structure.
@@ -734,6 +598,135 @@ static int ata_tdev_add(struct ata_device *ata_dev)
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
+ *	%1 if the device represents a ATA link, %0 else
+ */
+static int ata_is_link(const struct device *dev)
+{
+	return dev->release == ata_tlink_release;
+}
+
+static int ata_tlink_match(struct attribute_container *cont,
+			   struct device *dev)
+{
+	struct ata_internal *i = to_ata_internal(ata_scsi_transport_template);
+
+	if (!ata_is_link(dev))
+		return 0;
+	return &i->link_attr_cont.ac == cont;
+}
+
+/**
+ * ata_tlink_delete  --  remove ATA LINK
+ * @link:	ATA LINK to remove
+ *
+ * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
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
+ * ata_tlink_add  --  initialize a transport ATA link structure
+ * @link:	allocated ata_link structure.
+ *
+ * Initialize an ATA LINK structure for sysfs.  It will be added in the
+ * device tree below the ATA PORT it belongs to.
+ *
+ * Returns %0 on success
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

