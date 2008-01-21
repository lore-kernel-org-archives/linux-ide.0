From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] libata: add enclosure management support
Date: Mon, 21 Jan 2008 12:12:32 -0600
Message-ID: <1200939152.3157.32.camel@localhost.localdomain>
References: <20080115164417.4a5e2789@appleyard>
	 <1200610243.3255.47.camel@localhost.localdomain>
	 <20080118085227.4b7a379f@appleyard>
	 <1200676281.3111.20.camel@localhost.localdomain>
	 <20080118094116.7ac94f2e@appleyard>
	 <1200701795.3111.89.camel@localhost.localdomain>
	 <20080118165243.412fe397@appleyard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:54175 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404AbYAUSMo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 13:12:44 -0500
In-Reply-To: <20080118165243.412fe397@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 2008-01-18 at 16:52 -0800, Kristen Carlson Accardi wrote:
> On Fri, 18 Jan 2008 18:16:34 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > On Fri, 2008-01-18 at 09:41 -0800, Kristen Carlson Accardi wrote:
> > > On Fri, 18 Jan 2008 11:11:21 -0600
> > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > 
> > > > 
> > > > On Fri, 2008-01-18 at 08:52 -0800, Kristen Carlson Accardi wrote:
> > > > > On Thu, 17 Jan 2008 16:50:42 -0600
> > > > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > > > 
> > > > > > On Tue, 2008-01-15 at 16:44 -0800, Kristen Carlson Accardi
> > > > > > wrote:
> > > > > > > Add Enclosure Management support to libata and ahci.
> > > > > > > 
> > > > > > > This patch adds support for the LED protocol, as defined in
> > > > > > > the AHCI spec. It adds a generic em_message and em_type
> > > > > > > sysfs entry per host.  It also adds a sw_activity field per
> > > > > > > existing drive.
> > > > > > > 
> > > > > > > The em_message field can be used by the driver to take
> > > > > > > enclosure management commands from userspace.  In the case
> > > > > > > of the LED protocol, writes and reads from em_message
> > > > > > > correspond to the LED message format as defined in the AHCI
> > > > > > > spec.
> > > > > > > 
> > > > > > > em_message type is a read only file that displays the
> > > > > > > current enclosure management protocol that is used by the
> > > > > > > driver.
> > > > > > > 
> > > > > > > sw_activity is used by drivers which support software
> > > > > > > controlled activity LEDs. It has the following valid values:
> > > > > > > 
> > > > > > > 0	OFF - the LED is not activated on activity
> > > > > > > 1	BLINK_ON - the LED blinks on every 10ms when
> > > > > > > activity is detected. 2	BLINK_OFF - the LED is on
> > > > > > > when idle, and blinks off every 10ms when activity is
> > > > > > > detected.
> > > > > > > 
> > > > > > > It's important to note that the user must turn sw_activity
> > > > > > > OFF it they wish to control the activity LED via the
> > > > > > > em_message file.
> > > > > > 
> > > > > > One of the things we really need to do is to get some type of
> > > > > > generic enclosure support.  I note that ahci support three
> > > > > > standard eclosure management protocols (SAF-TE, SES-2,
> > > > > > SFF-8485 SGPIO) as well as the one proprietary one you've
> > > > > > chosen to implement.  Is that because no-one in the field has
> > > > > > actually connected AHCI up to anything supporting one of the
> > > > > > standard protocols?
> > > > > > 
> > > > > > I'm looking at this from slightly the other way around:  the
> > > > > > SAS protocol is virtually mandating SFF-8485 as the enclosure
> > > > > > protocol to the point that it's actually built into the sas
> > > > > > management protocol ... I was starting to wonder how we
> > > > > > should be taking advantage of this.
> > > > > > 
> > > > > > The implementation probably should be generic (above SCSI or
> > > > > > IDE or ATA) but it would obviously need to tap into the
> > > > > > subsytem/transport/device specific pieces, so possibly block
> > > > > > looks to be the right place to start?
> > > > > > 
> > > > > > James
> > > > > > 
> > > > > > 
> > > > > 
> > > > > I originally thought to try to make a generic enclosure
> > > > > management framework that we could hook individual EM protocols
> > > > > into.  Then I started to wonder why we needed to add knowledge
> > > > > of these protocols into the kernel.  At least the AHCI hardware
> > > > > which I'm familiar with, has no need to know anything about the
> > > > > protocol.  It abstracts everything into just a message.  So,
> > > > > the design that I did in this patch does the same thing.  You
> > > > > export the type of protocol the driver is configured to accept,
> > > > > then the message buffer and leave it up to user space to
> > > > > understand the individual protocol.  This works for all
> > > > > supported EM protocols.  As far as I can see, most of these
> > > > > management protocols are better suited to being implemented in
> > > > > user space anyway. 
> > > > 
> > > > It's one way to look at it, if we go with SFF-8485 and the AHCI
> > > > specific protocol.  Basically both of them are only about flashing
> > > > LEDs.  The SAF-TE and SES protocols are much more comprehensive
> > > > (and include things like environmental monitors, temperature,
> > > > fans, etc.).
> > > 
> > > Even these though can be boiled down to read a message/write a
> > > message.
> > 
> > That's true of almost every protocol in the end.  I was thinking of
> > the abstraction.  The messages lead to flashing lights in the
> > enclosures. They also have interactive knobs that users twiddle on
> > the other end. We really need a uniform user interface abstraction
> > for enclosures.
> > 
> 
> I guess I'm still not seeing why this abstraction needs to be in the
> kernel.  Why can't it be a user space library with a generic buffer to
> send/receive messages.

OK, code demonstrates better I suppose.  Here's an enclosure abstraction
that manifests correctly in sysfs and should allow us all (AHCI, SGPIO
and SES) to play in the same sandbox.

James

---

>From c4d1deff6105831ec7d71641aeb74b945474fef2 Mon Sep 17 00:00:00 2001
From: James Bottomley <jejb@localhost.localdomain>
Date: Sun, 20 Jan 2008 07:34:58 -0600
Subject: [SCSI] enclosure: add support for enclosure services

The enclosure misc device is really just a library providing sysfs
support for physical enclosure devices and their components.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/misc/Kconfig      |   10 +
 drivers/misc/Makefile     |    1 +
 drivers/misc/enclosure.c  |  409 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/enclosure.h |  116 +++++++++++++
 4 files changed, 536 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/enclosure.c
 create mode 100644 include/linux/enclosure.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b5e67c0..c6e5c09 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -11,6 +11,7 @@ menuconfig MISC_DEVICES
 
 	  If you say N, all options in this submenu will be skipped and disabled.
 
+
 if MISC_DEVICES
 
 config IBM_ASM
@@ -232,4 +233,13 @@ config ATMEL_SSC
 
 	  If unsure, say N.
 
+config ENCLOSURE_SERVICES
+	tristate "Enclosure Services"
+	default n
+	help
+	  Provides support for intelligent enclosures (bays which
+	  contain storage devices).  You also need either a host
+	  driver (SCSI/ATA) which supports enclosures
+	  or a SCSI enclosure device (SES) to use these services.
+
 endif # MISC_DEVICES
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 87f2685..de9f1f5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_FUJITSU_LAPTOP)	+= fujitsu-laptop.o
 obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
+obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
\ No newline at end of file
diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
new file mode 100644
index 0000000..6d4746f
--- /dev/null
+++ b/drivers/misc/enclosure.c
@@ -0,0 +1,409 @@
+/*
+ * Enclosure Services
+ *
+ * Copyright (C) 2008 James Bottomley <James.Bottomley@HansenPartnership.com>
+ *
+**-----------------------------------------------------------------------------
+**
+**  This program is free software; you can redistribute it and/or
+**  modify it under the terms of the GNU General Public License
+**  version 2 as published by the Free Software Foundation.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+*/
+#include <linux/device.h>
+#include <linux/enclosure.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+static LIST_HEAD(container_list);
+static DEFINE_MUTEX(container_list_lock);
+static struct class enclosure_class;
+static struct class enclosure_component_class;
+
+struct enclosure_device *enclosure_find(struct device *dev)
+{
+	struct enclosure_device *edev = NULL;
+
+	mutex_lock(&container_list_lock);
+	list_for_each_entry(edev, &container_list, node) {
+		if (edev->cdev.dev == dev) {
+			mutex_unlock(&container_list_lock);
+			return edev;
+		}
+	}
+	mutex_unlock(&container_list_lock);
+
+	return NULL;
+}
+EXPORT_SYMBOL(enclosure_find);
+
+/**
+ * enclosure_register - register device as an enclosure
+ *
+ * @dev:	device containing the enclosure
+ * @components:	number of components in the enclosure
+ *
+ * This sets up the device for being an enclosure.  Note that @dev does
+ * not have to be a dedicated enclosure device.  It may be some other type
+ * of device that additionally responds to enclosure services
+ */
+struct enclosure_device *
+enclosure_register(struct device *dev, const char *name, int components,
+		   struct enclosure_component_callbacks *cb)
+{
+	struct enclosure_device *edev =
+		kzalloc(sizeof(struct enclosure_device) +
+			sizeof(struct enclosure_component)*components,
+			GFP_KERNEL);
+	int err, i;
+
+	if (!edev)
+		return ERR_PTR(-ENOMEM);
+
+	if (!cb)
+		return ERR_PTR(-EINVAL);
+
+	edev->components = components;
+
+	edev->cdev.class = &enclosure_class;
+	edev->cdev.dev = get_device(dev);
+	edev->cb = cb;
+	snprintf(edev->cdev.class_id, BUS_ID_SIZE, "%s", name);
+	err = class_device_register(&edev->cdev);
+	if (err)
+		goto err;
+
+	for (i = 0; i < components; i++)
+		edev->component[i].number = -1;
+
+	mutex_lock(&container_list_lock);
+	list_add_tail(&edev->node, &container_list);
+	mutex_unlock(&container_list_lock);
+
+	return edev;
+
+ err:
+	put_device(edev->cdev.dev);
+	kfree(edev);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(enclosure_register);
+
+static struct enclosure_component_callbacks enclosure_null_callbacks;
+
+/**
+ * enclosure_unregister - remove an enclosure
+ *
+ * @edev:	the registered enclosure to remove;
+ */
+void enclosure_unregister(struct enclosure_device *edev)
+{
+	int i;
+
+	if (!edev)
+		return;
+
+	mutex_lock(&container_list_lock);
+	list_del(&edev->node);
+	mutex_unlock(&container_list_lock);
+
+	for (i = 0; i < edev->components; i++)
+		if (edev->component[i].number != -1)
+			class_device_unregister(&edev->component[i].cdev);
+
+	class_device_unregister(&edev->cdev);
+	/* prevent any callbacks into service user */
+	edev->cb = &enclosure_null_callbacks;
+}
+EXPORT_SYMBOL_GPL(enclosure_unregister);
+
+static void enclosure_release(struct class_device *cdev)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev);
+
+	put_device(cdev->dev);
+	kfree(edev);
+}
+
+static void enclosure_component_release(struct class_device *cdev)
+{
+	if (cdev->dev)
+		put_device(cdev->dev);
+	class_device_put(cdev->parent);
+}
+
+int enclosure_component_register(struct enclosure_device *edev,
+				 unsigned int number,
+				 enum enclosure_component_type type,
+				 const char *name)
+{
+	struct enclosure_component *ecomp;
+	struct class_device *cdev;
+	int err;
+
+	if (!edev || number >= edev->components)
+		return -EINVAL;
+
+	ecomp = &edev->component[number];
+
+	if (ecomp->number != -1)
+		return -EINVAL;
+
+	ecomp->type = type;
+	ecomp->number = number;
+	cdev = &ecomp->cdev;
+	cdev->parent = class_device_get(&edev->cdev);
+	cdev->class = &enclosure_component_class;
+	if (name)
+		snprintf(cdev->class_id, BUS_ID_SIZE, "%s", name);
+	else
+		snprintf(cdev->class_id, BUS_ID_SIZE, "%d", number);
+
+	err = class_device_register(cdev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(enclosure_component_register);
+
+int enclosure_add_device(struct enclosure_device *edev, int component,
+			 struct device *dev)
+{
+	struct class_device *cdev;
+
+	if (!edev || component >= edev->components)
+		return -EINVAL;
+
+	cdev = &edev->component[component].cdev;
+
+	class_device_del(cdev);
+	if (cdev->dev)
+		put_device(cdev->dev);
+	cdev->dev = get_device(dev);
+	return class_device_add(cdev);
+}
+EXPORT_SYMBOL_GPL(enclosure_add_device);
+
+int enclosure_remove_device(struct enclosure_device *edev, int component)
+{
+	struct class_device *cdev;
+
+	if (!edev || component >= edev->components)
+		return -EINVAL;
+
+	cdev = &edev->component[component].cdev;
+
+	class_device_del(cdev);
+	if (cdev->dev)
+		put_device(cdev->dev);
+	cdev->dev = NULL;
+	return class_device_add(cdev);
+}
+EXPORT_SYMBOL_GPL(enclosure_remove_device);
+
+/*
+ * sysfs pieces below
+ */
+
+static ssize_t enclosure_show_components(struct class_device *cdev, char *buf)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev);
+
+	return snprintf(buf, 40, "%d\n", edev->components);
+}
+
+static struct class_device_attribute enclosure_attrs[] = {
+	__ATTR(components, S_IRUGO, enclosure_show_components, NULL),
+	__ATTR_NULL
+};
+
+static struct class enclosure_class = {
+	.name			= "enclosure",
+	.owner			= THIS_MODULE,
+	.release		= enclosure_release,
+	.class_dev_attrs	= enclosure_attrs,
+};
+
+static char *enclosure_status [] = {
+	[ENCLOSURE_STATUS_UNSUPPORTED] = "unsupported",
+	[ENCLOSURE_STATUS_OK] = "OK",
+	[ENCLOSURE_STATUS_CRITICAL] = "critical",
+	[ENCLOSURE_STATUS_NON_CRITICAL] = "non-critical",
+	[ENCLOSURE_STATUS_UNRECOVERABLE] = "unrecoverable",
+	[ENCLOSURE_STATUS_NOT_INSTALLED] = "not installed",
+	[ENCLOSURE_STATUS_UNKNOWN] = "unknown",
+	[ENCLOSURE_STATUS_UNAVAILABLE] = "unavailable",
+};
+
+static char *enclosure_type [] = {
+	[ENCLOSURE_COMPONENT_DEVICE] = "device",
+	[ENCLOSURE_COMPONENT_ARRAY_DEVICE] = "array device",
+};
+
+static ssize_t get_component_fault(struct class_device *cdev, char *buf)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+
+	if (edev->cb->get_fault)
+		edev->cb->get_fault(edev, ecomp);
+	return snprintf(buf, 40, "%d\n", ecomp->fault);
+}
+
+static ssize_t set_component_fault(struct class_device *cdev, const char *buf,
+				   size_t count)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	int val = simple_strtoul(buf, NULL, 0);
+
+	if (edev->cb->set_fault)
+		edev->cb->set_fault(edev, ecomp, val);
+	return count;
+}
+
+static ssize_t get_component_status(struct class_device *cdev, char *buf)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+
+	if (edev->cb->get_status)
+		edev->cb->get_status(edev, ecomp);
+	return snprintf(buf, 40, "%s\n", enclosure_status[ecomp->status]);
+}
+
+static ssize_t set_component_status(struct class_device *cdev, const char *buf,
+				   size_t count)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	int i;
+
+	for (i = 0; enclosure_status[i]; i++) {
+		if (strncmp(buf, enclosure_status[i],
+			    strlen(enclosure_status[i])) == 0 &&
+		    buf[strlen(enclosure_status[i])] == '\n')
+			break;
+	}
+
+	if (enclosure_status[i] && edev->cb->set_status) {
+		edev->cb->set_status(edev, ecomp, i);
+		return count;
+	} else
+		return -EINVAL;
+}
+
+static ssize_t get_component_active(struct class_device *cdev, char *buf)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+
+	if (edev->cb->get_active)
+		edev->cb->get_active(edev, ecomp);
+	return snprintf(buf, 40, "%d\n", ecomp->active);
+}
+
+static ssize_t set_component_active(struct class_device *cdev, const char *buf,
+				   size_t count)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	int val = simple_strtoul(buf, NULL, 0);
+
+	if (edev->cb->set_active)
+		edev->cb->set_active(edev, ecomp, val);
+	return count;
+}
+
+static ssize_t get_component_locate(struct class_device *cdev, char *buf)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+
+	if (edev->cb->get_locate)
+		edev->cb->get_locate(edev, ecomp);
+	return snprintf(buf, 40, "%d\n", ecomp->locate);
+}
+
+static ssize_t set_component_locate(struct class_device *cdev, const char *buf,
+				   size_t count)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	int val = simple_strtoul(buf, NULL, 0);
+
+	if (edev->cb->set_locate)
+		edev->cb->set_locate(edev, ecomp, val);
+	return count;
+}
+
+static ssize_t get_component_type(struct class_device *cdev, char *buf)
+{
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+
+	return snprintf(buf, 40, "%s\n", enclosure_type[ecomp->type]);
+}
+
+
+static struct class_device_attribute enclosure_component_attrs[] = {
+	__ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
+	       set_component_fault),
+	__ATTR(status, S_IRUGO | S_IWUSR, get_component_status,
+	       set_component_status),
+	__ATTR(active, S_IRUGO | S_IWUSR, get_component_active,
+	       set_component_active),
+	__ATTR(locate, S_IRUGO | S_IWUSR, get_component_locate,
+	       set_component_locate),
+	__ATTR(type, S_IRUGO, get_component_type, NULL),
+	__ATTR_NULL
+};
+
+static struct class enclosure_component_class =  {
+	.name			= "enclosure_component",
+	.owner			= THIS_MODULE,
+	.class_dev_attrs	= enclosure_component_attrs,
+	.release		= enclosure_component_release,
+};
+
+static int __init enclosure_init(void)
+{
+	int err;
+
+	err = class_register(&enclosure_class);
+	if (err)
+		return err;
+	err = class_register(&enclosure_component_class);
+	if (err)
+		goto err_out;
+
+	return 0;
+ err_out:
+	class_unregister(&enclosure_class);
+
+	return err;
+}
+
+static void __exit enclosure_exit(void)
+{
+	class_unregister(&enclosure_component_class);
+	class_unregister(&enclosure_class);
+}
+
+module_init(enclosure_init);
+module_exit(enclosure_exit);
+
+MODULE_AUTHOR("James Bottomley");
+MODULE_DESCRIPTION("Enclosure Services");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
new file mode 100644
index 0000000..cc83acf
--- /dev/null
+++ b/include/linux/enclosure.h
@@ -0,0 +1,116 @@
+/*
+ * Enclosure Services
+ *
+ * Copyright (C) 2008 James Bottomley <James.Bottomley@HansenPartnership.com>
+ *
+**-----------------------------------------------------------------------------
+**
+**  This program is free software; you can redistribute it and/or
+**  modify it under the terms of the GNU General Public License
+**  version 2 as published by the Free Software Foundation.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+*/
+#ifndef _LINUX_ENCLOSURE_H_
+#define _LINUX_ENCLOSURE_H_
+
+#include <linux/device.h>
+#include <linux/list.h>
+
+/* A few generic types ... taken from ses-2 */
+enum enclosure_component_type {
+	ENCLOSURE_COMPONENT_DEVICE = 0x01,
+	ENCLOSURE_COMPONENT_ARRAY_DEVICE = 0x17,
+};
+
+/* ses-2 common element status */
+enum enclosure_status {
+	ENCLOSURE_STATUS_UNSUPPORTED = 0,
+	ENCLOSURE_STATUS_OK,
+	ENCLOSURE_STATUS_CRITICAL,
+	ENCLOSURE_STATUS_NON_CRITICAL,
+	ENCLOSURE_STATUS_UNRECOVERABLE,
+	ENCLOSURE_STATUS_NOT_INSTALLED,
+	ENCLOSURE_STATUS_UNKNOWN,
+	ENCLOSURE_STATUS_UNAVAILABLE,
+};
+
+/* SFF-8485 activity light settings */
+enum enclosure_component_setting {
+	ENCLOSURE_SETTING_DISABLED = 0,
+	ENCLOSURE_SETTING_ENABLED = 1,
+	ENCLOSURE_SETTING_BLINK_A_ON_OFF = 2,
+	ENCLOSURE_SETTING_BLINK_A_OFF_ON = 3,
+	ENCLOSURE_SETTING_BLINK_B_ON_OFF = 6,
+	ENCLOSURE_SETTING_BLINK_B_OFF_ON = 7,
+};
+
+struct enclosure_device;
+struct enclosure_component;
+struct enclosure_component_callbacks {
+	void (*get_status)(struct enclosure_device *,
+			     struct enclosure_component *);
+	int (*set_status)(struct enclosure_device *,
+			  struct enclosure_component *,
+			  enum enclosure_status);
+	void (*get_fault)(struct enclosure_device *,
+			  struct enclosure_component *);
+	int (*set_fault)(struct enclosure_device *,
+			 struct enclosure_component *,
+			 enum enclosure_component_setting);
+	void (*get_active)(struct enclosure_device *,
+			   struct enclosure_component *);
+	int (*set_active)(struct enclosure_device *,
+			  struct enclosure_component *,
+			  enum enclosure_component_setting);
+	void (*get_locate)(struct enclosure_device *,
+			   struct enclosure_component *);
+	int (*set_locate)(struct enclosure_device *,
+			  struct enclosure_component *,
+			  enum enclosure_component_setting);
+};
+
+
+struct enclosure_component {
+	struct class_device cdev;
+	enum enclosure_component_type type;
+	int number;
+	int fault;
+	int active;
+	int locate;
+	enum enclosure_status status;
+};
+
+struct enclosure_device {
+	void *scratch;
+	struct list_head node;
+	struct class_device cdev;
+	struct enclosure_component_callbacks *cb;
+	int components;
+	struct enclosure_component component[0];
+};
+
+#define to_enclosure_device(x) container_of((x), struct enclosure_device, cdev)
+#define to_enclosure_component(x) container_of((x), struct enclosure_component, cdev)
+
+struct enclosure_device *
+enclosure_register(struct device *, const char *, int,
+		   struct enclosure_component_callbacks *);
+void enclosure_unregister(struct enclosure_device *);
+int enclosure_component_register(struct enclosure_device *, unsigned int,
+				 enum enclosure_component_type, const char *);
+int enclosure_add_device(struct enclosure_device *enclosure, int component,
+			 struct device *dev);
+int enclosure_remove_device(struct enclosure_device *enclosure, int component);
+struct enclosure_device *enclosure_find(struct device *dev);
+
+#endif /* _LINUX_ENCLOSURE_H_ */
-- 
1.5.3.8



