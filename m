Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3132C923
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044664; cv=none; b=toa41ax6ngo9kinr6uERCgBid9b6uqusFoqRPcr+aSTCULCXJ/Fl9n1MvLIbkz7xgVjAP34x8SrjkVoW/tYpdHYD/xn99r9rBa/piQbLxYobw6z0ijSRCfBhV5J95oMxqT9J0YfMBMh2uVHAPuiiEBJ6Zwy7r+ULsdIc4CSPUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044664; c=relaxed/simple;
	bh=fE5c3+/skAwxD9/gR53haylNmIGow9J+a3lcL1I4iR8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uneXPbroxpxfP3EFzhMbqc6kqUxCOWGJzITkYADn7piZ6V5tJfiCkMjfCEFIUAfPfl7CHfJa+fnVqPjgsFqYes6J2FTVrAGgNZCYsfAg4oHkEeQmKHF2/KsfflF3woA6jLSOWDZERTuvLq+veVodquw3W9s2C8B8k3pu3jPY1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNYef8KM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNYef8KM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b4121c40aso1666984f8f.0
        for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774044661; x=1774649461; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAzGxBeMO+qIXxLIxEyEaOgD0jS5g6/6jF384S72iTE=;
        b=JNYef8KMDyiHbgbF3Zx4g0lkdEUO0wr7Q3d/QR+633IzeoR8rmA6sN4yWOtkxPn+l/
         eVcKjacDXY9yhUnHo8Qp5YRH9hP9gkZUsYKdm6GUjHehQgZFe1/YCAVPvzXinRSHM0nK
         HR05vQ0gGuDQqfiy8clMYbswuk2+0dma7FOfpcH86NNVi/8mueIbxJUBualZnZKLAH21
         rzQlcpsJnlIMXJ3zqE0K4ENka6DAgcy6aNCgvGx2f3cvRngkEpx9z8qxhfEpuuoiD5a8
         W/iTbkXYnUCWbemCAubLoE4RJcVrni1YAY+cr7s+XIr6C+nagTTeUszZvPQgHTsZDfPo
         /HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774044661; x=1774649461;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAzGxBeMO+qIXxLIxEyEaOgD0jS5g6/6jF384S72iTE=;
        b=D3nTsR4iRUytil9DvEhfXPq3uUUKn2p6NVGaBodfky/A3GnvmJcfoSsmIvqH3fG78i
         pSZEvuxn67/4t7fN9glbbS+lzuObxOfB/wNOLZQdrbqRQDqPTgZOm6VSS8IMtXPl9ty/
         zkgIWgIYw+Ncg+eTe+ST/9ztCNMcXjnUyIdvrRFkGMMer5USix8eDSuRbVdqo5kOO0KP
         jn758gqYS/xBLeaqfv65RjFVAWGotwonk7ZJiXRhv3CC6j0Ihe9Cswcg5pB2Ppa0o2k0
         6VeS5Jf9YOEdqOn+XLf1Mti5FrNb4Yizk9LKoH1zaV8vhLS1Y1hqlntiCyf+uHEsj7lm
         Gb7g==
X-Gm-Message-State: AOJu0YxHnxOM4/sv/k1LIT4MpNsc9t6XPPeRR9UvEMhcRzYM6JrqBH/o
	Inm01BhrSU5gB49Hq5WeTNCH6eSRTjeVQ36/NSsqWLc1h1lbnl1o8P4Dp1D9ng==
X-Gm-Gg: ATEYQzwCH6wprQp4LOT0L+abbrEKO9fWsX3xpYNY5CILFPf2BNbVOXsR2iqI9fn1oTR
	3t8YVYc0aAVgq5jZZCxjW8vq/n1vceB7inMoQNmSX3OrLseEnw2emzbfLbvkM7Aw+pLWtrgy6j1
	LixOUAlBDDRIebEQc7QboUDd2zucZR6lB7R29BZNMvp+D9XoaBccjXeRU3Yf6eZxedbptZPbX8z
	GFDiE7cun+6S0c88nTrMoeAxa7fjYOQplCL6mcmKRMVjq+tpKTMvLWwzTJnpC4iYbTR+HrIp9VZ
	C9dPEBACdj9EZ4N5cIuQtrNPRYRKb0tVv0zaCayX+Q4h7+YJUDdZLSu8O+ETKRsgx0Rk5IIbHTO
	PjPmLY4nM1FNf8hXGGrzZF1JJ/cLoWVw5Uaf/7lvIEaORm0KC6A8dY9kJJe3u+REdxXYXRE6QEi
	cpnUu11P4z9Lga/THdjGQlkCHr7K3n2PdtoHXIOq5m4SMHhUVtFeUdoqQGx9s3/Ps6VkIca12Rz
	mlNqbXEMMFG7Auaa6f/DNZa6g4oDtcacNv/Rp8eodDeoxoPildAgL9b5NAPj/w=
X-Received: by 2002:a05:600c:468b:b0:485:5812:bb9e with SMTP id 5b1f17b1804b1-486feb5a4d0mr73353215e9.0.1774044660856;
        Fri, 20 Mar 2026 15:11:00 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f29:d400:b9fc:ed59:ddcc:137? (p200300ea8f29d400b9fced59ddcc0137.dip0.t-ipconnect.de. [2003:ea:8f29:d400:b9fc:ed59:ddcc:137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1dd9f1sm39941755e9.8.2026.03.20.15.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 15:11:00 -0700 (PDT)
Message-ID: <44265829-58c8-41ad-b202-e5488892af26@gmail.com>
Date: Fri, 20 Mar 2026 23:10:59 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] ata: libata-transport: remove redundant dynamic sysfs
 attributes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use the static sysfs attributes directly, this allows to significantly
simplify the code. See attribute_container_add_attrs() for why member
grp can be used instead of attrs.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-transport.c | 113 ++++++++++++---------------------
 1 file changed, 42 insertions(+), 71 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 2099d94c4..7ad180265 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -37,34 +37,17 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_PORT_ATTRS		3
-#define ATA_LINK_ATTRS		3
-#define ATA_DEV_ATTRS		9
-
 struct scsi_transport_template;
 struct scsi_transport_template *ata_scsi_transport_template;
 
 struct ata_internal {
 	struct scsi_transport_template t;
 
-	struct device_attribute private_port_attrs[ATA_PORT_ATTRS];
-	struct device_attribute private_link_attrs[ATA_LINK_ATTRS];
-	struct device_attribute private_dev_attrs[ATA_DEV_ATTRS];
-
 	struct transport_container link_attr_cont;
 	struct transport_container dev_attr_cont;
-
-	/*
-	 * The array of null terminated pointers to attributes
-	 * needed by scsi_sysfs.c
-	 */
-	struct device_attribute *link_attrs[ATA_LINK_ATTRS + 1];
-	struct device_attribute *port_attrs[ATA_PORT_ATTRS + 1];
-	struct device_attribute *dev_attrs[ATA_DEV_ATTRS + 1];
 };
 #define to_ata_internal(tmpl)	container_of(tmpl, struct ata_internal, t)
 
-
 #define tdev_to_device(d)					\
 	container_of((d), struct ata_device, tdev)
 #define transport_class_to_dev(dev)				\
@@ -80,13 +63,6 @@ struct ata_internal {
 #define transport_class_to_port(dev)				\
 	tdev_to_port((dev)->parent)
 
-/*
- * Hack to allow attributes of the same name in different objects.
- */
-#define ATA_DEVICE_ATTR(_prefix,_name,_mode,_show,_store) \
-	struct device_attribute device_attr_##_prefix##_##_name = \
-	__ATTR(_name,_mode,_show,_store)
-
 #define ata_bitfield_name_match(title, table)			\
 static ssize_t							\
 get_ata_##title##_names(u32 table_key, char *buf)		\
@@ -214,6 +190,17 @@ ata_port_simple_attr(stats.idle_irq, idle_irq, "%ld\n", unsigned long);
 /* We want the port_no sysfs attibute to start at 1 (ap->port_no starts at 0) */
 ata_port_simple_attr(port_no + 1, port_no, "%u\n", unsigned int);
 
+static const struct attribute *const ata_port_attr_attrs[] = {
+	&dev_attr_nr_pmp_links.attr,
+	&dev_attr_idle_irq.attr,
+	&dev_attr_port_no.attr,
+	NULL
+};
+
+static const struct attribute_group ata_port_attr_group = {
+	.attrs_const = ata_port_attr_attrs,
+};
+
 static DECLARE_TRANSPORT_CLASS(ata_port_class,
 			       "ata_port", NULL, NULL, NULL);
 
@@ -496,6 +483,23 @@ show_ata_dev_trim(struct device *dev,
 
 static DEVICE_ATTR(trim, S_IRUGO, show_ata_dev_trim, NULL);
 
+static const struct attribute *const ata_device_attr_attrs[] = {
+	&dev_attr_class.attr,
+	&dev_attr_pio_mode.attr,
+	&dev_attr_dma_mode.attr,
+	&dev_attr_xfer_mode.attr,
+	&dev_attr_spdn_cnt.attr,
+	&dev_attr_ering.attr,
+	&dev_attr_id.attr,
+	&dev_attr_gscr.attr,
+	&dev_attr_trim.attr,
+	NULL
+};
+
+static const struct attribute_group ata_device_attr_group = {
+	.attrs_const = ata_device_attr_attrs,
+};
+
 static DECLARE_TRANSPORT_CLASS(ata_dev_class,
 			       "ata_device", NULL, NULL, NULL);
 
@@ -626,6 +630,17 @@ ata_link_linkspeed_attr(hw_sata_spd_limit, fls);
 ata_link_linkspeed_attr(sata_spd_limit, fls);
 ata_link_linkspeed_attr(sata_spd, noop);
 
+static const struct attribute *const ata_link_attr_attrs[] = {
+	&dev_attr_hw_sata_spd_limit.attr,
+	&dev_attr_sata_spd_limit.attr,
+	&dev_attr_sata_spd.attr,
+	NULL
+};
+
+static const struct attribute_group ata_link_attr_group = {
+	.attrs_const = ata_link_attr_attrs,
+};
+
 static DECLARE_TRANSPORT_CLASS(ata_link_class,
 		"ata_link", NULL, NULL, NULL);
 
@@ -734,29 +749,12 @@ int ata_tlink_add(struct ata_link *link)
  * Setup / Teardown code
  */
 
-#define SETUP_TEMPLATE(attrb, field, perm, test)			\
-	i->private_##attrb[count] = dev_attr_##field;			\
-	i->private_##attrb[count].attr.mode = perm;			\
-	i->attrb[count] = &i->private_##attrb[count];			\
-	if (test)							\
-		count++
-
-#define SETUP_LINK_ATTRIBUTE(field)					\
-	SETUP_TEMPLATE(link_attrs, field, S_IRUGO, 1)
-
-#define SETUP_PORT_ATTRIBUTE(field)					\
-	SETUP_TEMPLATE(port_attrs, field, S_IRUGO, 1)
-
-#define SETUP_DEV_ATTRIBUTE(field)					\
-	SETUP_TEMPLATE(dev_attrs, field, S_IRUGO, 1)
-
 /**
  * ata_attach_transport  --  instantiate ATA transport template
  */
 struct scsi_transport_template *ata_attach_transport(void)
 {
 	struct ata_internal *i;
-	int count;
 
 	i = kzalloc_obj(struct ata_internal);
 	if (!i)
@@ -765,48 +763,21 @@ struct scsi_transport_template *ata_attach_transport(void)
 	i->t.eh_strategy_handler	= ata_scsi_error;
 	i->t.user_scan			= ata_scsi_user_scan;
 
-	i->t.host_attrs.ac.attrs = &i->port_attrs[0];
 	i->t.host_attrs.ac.class = &ata_port_class.class;
+	i->t.host_attrs.ac.grp   = &ata_port_attr_group;
 	i->t.host_attrs.ac.match = ata_tport_match;
 	transport_container_register(&i->t.host_attrs);
 
 	i->link_attr_cont.ac.class = &ata_link_class.class;
-	i->link_attr_cont.ac.attrs = &i->link_attrs[0];
+	i->link_attr_cont.ac.grp   = &ata_link_attr_group;
 	i->link_attr_cont.ac.match = ata_tlink_match;
 	transport_container_register(&i->link_attr_cont);
 
 	i->dev_attr_cont.ac.class = &ata_dev_class.class;
-	i->dev_attr_cont.ac.attrs = &i->dev_attrs[0];
+	i->dev_attr_cont.ac.grp   = &ata_device_attr_group;
 	i->dev_attr_cont.ac.match = ata_tdev_match;
 	transport_container_register(&i->dev_attr_cont);
 
-	count = 0;
-	SETUP_PORT_ATTRIBUTE(nr_pmp_links);
-	SETUP_PORT_ATTRIBUTE(idle_irq);
-	SETUP_PORT_ATTRIBUTE(port_no);
-	BUG_ON(count > ATA_PORT_ATTRS);
-	i->port_attrs[count] = NULL;
-
-	count = 0;
-	SETUP_LINK_ATTRIBUTE(hw_sata_spd_limit);
-	SETUP_LINK_ATTRIBUTE(sata_spd_limit);
-	SETUP_LINK_ATTRIBUTE(sata_spd);
-	BUG_ON(count > ATA_LINK_ATTRS);
-	i->link_attrs[count] = NULL;
-
-	count = 0;
-	SETUP_DEV_ATTRIBUTE(class);
-	SETUP_DEV_ATTRIBUTE(pio_mode);
-	SETUP_DEV_ATTRIBUTE(dma_mode);
-	SETUP_DEV_ATTRIBUTE(xfer_mode);
-	SETUP_DEV_ATTRIBUTE(spdn_cnt);
-	SETUP_DEV_ATTRIBUTE(ering);
-	SETUP_DEV_ATTRIBUTE(id);
-	SETUP_DEV_ATTRIBUTE(gscr);
-	SETUP_DEV_ATTRIBUTE(trim);
-	BUG_ON(count > ATA_DEV_ATTRS);
-	i->dev_attrs[count] = NULL;
-
 	return &i->t;
 }
 
-- 
2.53.0

