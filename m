Return-Path: <SRS0=dVMU=AU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D84C433DF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Jul 2020 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A5220672
	for <linux-ide@archiver.kernel.org>; Thu,  9 Jul 2020 21:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmLb01zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGIVS7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:18:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726228AbgGIVS6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jul 2020 17:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594329536;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eonmXdxYXzd+8vB1PEXCzmQGsPTS498EIb1d9PeXCww=;
        b=ZmLb01zdmGCzKMDL4TUiO7IKMbabiGNLZ6ASFkK7auMFHxvYCosDbJWWxaoa5oWaBni0bW
        8pvBYHfxu3s0SfOIem7TYop6uVFGpkK1M27a4+vl2Cy5LyVjeVZ9bEYrTOYib7/nw9OKKN
        2N9+O+C0V5txnxsEnZ/87XoM4Qkmgnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-JTOcr4AQPWOpMCwOHRUJbg-1; Thu, 09 Jul 2020 17:18:52 -0400
X-MC-Unique: JTOcr4AQPWOpMCwOHRUJbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99CAAE918;
        Thu,  9 Jul 2020 21:18:51 +0000 (UTC)
Received: from [10.3.128.21] (unknown [10.3.128.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2ABB19D61;
        Thu,  9 Jul 2020 21:18:50 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [RFC PATCH v3 5/8] ata_dev_printk: Use dev_printk
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org
References: <20200623191749.115200-1-tasleson@redhat.com>
 <20200623191749.115200-6-tasleson@redhat.com>
 <CGME20200624103532eucas1p2c0988207e4dfc2f992d309b75deac3ee@eucas1p2.samsung.com>
 <d817c9dd-6852-9233-5f61-1c0bc0f65ca4@samsung.com>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <7ed08b94-755f-baab-0555-b4e454405729@redhat.com>
Date:   Thu, 9 Jul 2020 16:18:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d817c9dd-6852-9233-5f61-1c0bc0f65ca4@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Bartlomiej,

On 6/24/20 5:35 AM, Bartlomiej Zolnierkiewicz wrote:
> The root source of problem is that libata transport uses different
> naming scheme for ->tdev devices (please see dev_set_name() in
> ata_t{dev,link,port}_add()) than libata core for its logging
> functionality (ata_{dev,link,port}_printk()).
> 
> Since libata transport is part of sysfs ABI we should be careful
> to not break it so one idea for solving the issue is to convert
> ata_t{dev,link,port}_add() to use libata logging naming scheme and
> at the same time add sysfs symlinks for the old libata transport
> naming scheme.

I tried doing as you suggested.  I've included what I've done so far.  I
haven't been able to get all the needed parts for the symlinks to
maintain compatibility.

The /sys/class/.. seems OK, eg.

$  ls -x -w 70 /sys/class/ata_[dl]*
/sys/class/ata_device:
ata1.00  ata2.00  ata3.00  ata4.00  ata5.00  ata6.00  ata7.00
ata7.01  ata8.00  ata8.01  dev1.0   dev2.0   dev3.0   dev4.0
dev5.0   dev6.0   dev7.0   dev7.1   dev8.0   dev8.1

/sys/class/ata_link:
ata1   ata2   ata3   ata4   ata5   ata6   ata7  ata8  link1  link2
link3  link4  link5  link6  link7  link8

but the implementation is a hack, see device.h, core.c changes.  There
must be a better way?

Also I'm missing part of the full path, eg.

/sys/devices/pci0000:00/0000:00:01.1/ata7/link7/dev7.0/ata_device/dev7.0/gscr

becomes

/sys/devices/pci0000:00/0000:00:01.1/ata7/ata7/ata7.01/ata_device/ata7.01/gscr

but the compatibility symlinks added only get me to

/sys/devices/pci0000:00/0000:00:01.1/ata7/link7/dev7.0/ata_device/

I haven't found the right spot to get the last symlink included.

If you or anyone else has suggestions to correct the incomplete symlink
and/or correct the implementation to set the
/sys/class/ata_device it would be greatly appreciated.

Thanks,
-Tony

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beca5f91bb4c..2aa230ad813e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6444,7 +6444,7 @@ void ata_port_printk(const struct ata_port *ap,
const char *level,
        vaf.fmt = fmt;
        vaf.va = &args;

-       printk("%sata%u: %pV", level, ap->print_id, &vaf);
+       dev_printk(level, &ap->tdev, "%pV", &vaf);

        va_end(args);
 }
@@ -6461,12 +6461,7 @@ void ata_link_printk(const struct ata_link *link,
const char *level,
        vaf.fmt = fmt;
        vaf.va = &args;

-       if (sata_pmp_attached(link->ap) || link->ap->slave_link)
-               printk("%sata%u.%02u: %pV",
-                      level, link->ap->print_id, link->pmp, &vaf);
-       else
-               printk("%sata%u: %pV",
-                      level, link->ap->print_id, &vaf);
+       dev_printk(level, &link->tdev, "%pV", &vaf);

        va_end(args);
 }
@@ -6483,9 +6478,7 @@ void ata_dev_printk(const struct ata_device *dev,
const char *level,
        vaf.fmt = fmt;
        vaf.va = &args;

-       printk("%sata%u.%02u: %pV",
-              level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
-              &vaf);
+       dev_printk(level, &dev->tdev,"%pV", &vaf);

        va_end(args);
 }
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 6a40e3c6cf49..e5870f9b2b21 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -288,7 +288,7 @@ int ata_tport_add(struct device *parent,
        dev->parent = parent;
        ata_host_get(ap->host);
        dev->release = ata_tport_release;
-       dev_set_name(dev, "ata%d", ap->print_id);
+       dev_set_name(dev, "ata%u", ap->print_id);
        transport_setup_device(dev);
        ata_acpi_bind_port(ap);
        error = device_add(dev);
@@ -374,6 +374,46 @@ static int ata_tlink_match(struct
attribute_container *cont,
        return &i->link_attr_cont.ac == cont;
 }

+static struct device* tlink_to_symlink(struct device *dev) {
+       struct ata_internal* i =
to_ata_internal(ata_scsi_transport_template);
+       return
attribute_container_find_class_device(&i->link_attr_cont.ac, dev);
+}
+
+void ata_tlink_symlink_add_del(struct ata_link *link, int add) {
+       struct device *dev = &link->tdev;
+       struct ata_port *ap = link->ap;
+       char lname[64];
+       struct device *devp = tlink_to_symlink(dev);
+
+       if (ata_is_host_link(link)) {
+               snprintf(lname, sizeof(lname),
+                       "link%d", ap->print_id);
+       } else {
+               snprintf(lname, sizeof(lname),
+                       "link%d.%d", ap->print_id, link->pmp);
+       }
+
+       if (add) {
+               int e;
+
+               e = device_add_class_symlinks_additional(devp, lname);
+               if (e) {
+                        dev_warn(devp, "Error %d tlink symlink
class\n", e);
+               }
+
+               e = sysfs_create_link(&dev->parent->kobj, &dev->kobj,
lname);
+               if (e) {
+                        dev_warn(dev, "Error %d tlink symlink\n", e);
+               }
+       } else {
+               sysfs_delete_link(&dev->parent->kobj, &dev->kobj, lname);
+               device_delete_class_symlinks_additional(devp, lname);
+       }
+}
+
+#define ata_tlink_symlink_add(x) ata_tlink_symlink_add_del(x, 1)
+#define ata_tlink_symlink_del(x) ata_tlink_symlink_add_del(x, 0)
+
 /**
  * ata_tlink_delete  --  remove ATA LINK
  * @port:      ATA LINK to remove
@@ -389,6 +429,7 @@ void ata_tlink_delete(struct ata_link *link)
                ata_tdev_delete(ata_dev);
        }

+       ata_tlink_symlink_del(link);
        transport_remove_device(dev);
        device_del(dev);
        transport_destroy_device(dev);
@@ -415,9 +456,9 @@ int ata_tlink_add(struct ata_link *link)
        dev->parent = &ap->tdev;
        dev->release = ata_tlink_release;
        if (ata_is_host_link(link))
-               dev_set_name(dev, "link%d", ap->print_id);
-        else
-               dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
+               dev_set_name(dev, "ata%u", ap->print_id);
+       else
+               dev_set_name(dev, "ata%u.%02u", ap->print_id, link->pmp);

        transport_setup_device(dev);

@@ -429,6 +470,8 @@ int ata_tlink_add(struct ata_link *link)
        transport_add_device(dev);
        transport_configure_device(dev);

+       ata_tlink_symlink_add(link);
+
        ata_for_each_dev(ata_dev, link, ALL) {
                error = ata_tdev_add(ata_dev);
                if (error) {
@@ -440,6 +483,7 @@ int ata_tlink_add(struct ata_link *link)
        while (--ata_dev >= link->device) {
                ata_tdev_delete(ata_dev);
        }
+       ata_tlink_symlink_del(link);
        transport_remove_device(dev);
        device_del(dev);
   tlink_err:
@@ -630,6 +674,44 @@ static void ata_tdev_free(struct ata_device *dev)
        put_device(&dev->tdev);
 }

+static struct device* tdev_to_symlink(struct device *dev) {
+       struct ata_internal* i =
to_ata_internal(ata_scsi_transport_template);
+       return
attribute_container_find_class_device(&i->dev_attr_cont.ac, dev);
+}
+
+void ata_tdev_symlink_add_del(struct ata_device *ata_dev, int add) {
+       struct device *dev = &ata_dev->tdev;
+       struct ata_link *link = ata_dev->link;
+       struct ata_port *ap = link->ap;
+       char dname[64];
+
+       struct device *devp = tdev_to_symlink(dev);
+
+       if (ata_is_host_link(link))
+               snprintf(dname, sizeof(dname), "dev%d.%d",
ap->print_id,ata_dev->devno);
+       else
+               snprintf(dname, sizeof(dname), "dev%d.%d.0",
ap->print_id, link->pmp);
+
+       if (add) {
+               int e;
+               e = device_add_class_symlinks_additional(devp, dname);
+               if (e) {
+                        dev_warn(devp, "Error %d tdev symlink class\n", e);
+               }
+
+               e = sysfs_create_link(&dev->parent->kobj, &dev->kobj,
dname);
+               if (e) {
+                        dev_warn(dev, "Error %d tdev symlink\n", e);
+               }
+       } else {
+               sysfs_delete_link(&dev->parent->kobj, &dev->kobj, dname);
+               device_delete_class_symlinks_additional(devp, dname);
+       }
+}
+
+#define ata_tdev_symlink_add(x) ata_tdev_symlink_add_del(x, 1)
+#define ata_tdev_symlink_del(x) ata_tdev_symlink_add_del(x, 0)
+
 /**
  * ata_tdev_delete  --  remove ATA device
  * @port:      ATA PORT to remove
@@ -640,6 +722,7 @@ static void ata_tdev_delete(struct ata_device *ata_dev)
 {
        struct device *dev = &ata_dev->tdev;

+       ata_tdev_symlink_del(ata_dev);
        transport_remove_device(dev);
        device_del(dev);
        ata_tdev_free(ata_dev);
@@ -665,10 +748,8 @@ static int ata_tdev_add(struct ata_device *ata_dev)
        device_initialize(dev);
        dev->parent = &link->tdev;
        dev->release = ata_tdev_release;
-       if (ata_is_host_link(link))
-               dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
-        else
-               dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
+
+       dev_set_name(dev, "ata%u.%02u", ap->print_id, link->pmp +
ata_dev->devno);

        transport_setup_device(dev);
        ata_acpi_bind_dev(ata_dev);
@@ -680,6 +761,8 @@ static int ata_tdev_add(struct ata_device *ata_dev)

        transport_add_device(dev);
        transport_configure_device(dev);
+
+       ata_tdev_symlink_add(ata_dev);
        return 0;
 }

diff --git a/drivers/base/core.c b/drivers/base/core.c
index c2439d12608d..bc060000837c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2269,6 +2269,16 @@ static int device_add_class_symlinks(struct
device *dev)
        return error;
 }

+int device_add_class_symlinks_additional(struct device *dev, char *name) {
+       return sysfs_create_link(&dev->class->p->subsys.kobj,
&dev->kobj, name);
+}
+EXPORT_SYMBOL_GPL(device_add_class_symlinks_additional);
+
+void device_delete_class_symlinks_additional(struct device *dev, char
*name) {
+       sysfs_delete_link(&dev->class->p->subsys.kobj, &dev->kobj, name);
+}
+EXPORT_SYMBOL_GPL(device_delete_class_symlinks_additional);
+
 static void device_remove_class_symlinks(struct device *dev)
 {
        if (dev_of_node(dev))
diff --git a/include/linux/device.h b/include/linux/device.h
index 281755404c21..4827d86116ab 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -656,6 +656,10 @@ static inline const char *dev_name(const struct
device *dev)
 extern __printf(2, 3)
 int dev_set_name(struct device *dev, const char *name, ...);

+
+int device_add_class_symlinks_additional(struct device *dev, char *name);
+void device_delete_class_symlinks_additional(struct device *dev, char
*name);
+
 int dev_durable_name(const struct device *d, char *buffer, size_t len);

 #ifdef CONFIG_NUMA

