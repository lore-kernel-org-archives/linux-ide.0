From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Tue, 24 Jan 2017 11:19:37 -0500
Message-ID: <20170124161937.GE12281@htj.duckdns.org>
References: <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org>
 <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org>
 <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
 <20170120191946.GA9280@mtj.duckdns.org>
 <20170120193828.GB9280@mtj.duckdns.org>
 <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
 <CAP8WD_aya3junhovXtc=iUaaX43=Y1s8-eya_LvN_BQjXGLbew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33909 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdAXQTl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2017 11:19:41 -0500
Received: by mail-pg0-f68.google.com with SMTP id t6so17028097pgt.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2017 08:19:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_aya3junhovXtc=iUaaX43=Y1s8-eya_LvN_BQjXGLbew@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: Gwendal Grignou <gwendal@google.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Matthew.

On Mon, Jan 23, 2017 at 06:57:34PM -0500, tedheadster wrote:
> Gwendal,
> 
> >> Also, it looks like there is a ref leak on the transport device
> >> itself.  Its release function never gets called and thus the parent
> >> device (ata_port) stays pinned too.
> > That's the root cause of pata port not released. Can we run your debug
> > code one more time, enabling ap->tdev.kobj.release_debug?
> >
> 
> I'm building the debug kernel because I have the test hardware, but
> I'm not quite sure what I need to do to enable
> ap->tdev.kobj.release_debug. Tejun's patch enables kobj.release_debug,
> but I'm not sure if that is the same thing you want. Please advise.

The following patch should printout the same debug info for all
transport kobjects.

Thanks!

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 7ef16c0..80d72a6 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -283,6 +283,7 @@ int ata_tport_add(struct device *parent,
 
 	device_initialize(dev);
 	dev->type = &ata_port_type;
+	dev->kobj.release_debug = true;
 
 	dev->parent = get_device(parent);
 	dev->release = ata_tport_release;
@@ -412,6 +413,7 @@ int ata_tlink_add(struct ata_link *link)
 	device_initialize(dev);
 	dev->parent = get_device(&ap->tdev);
 	dev->release = ata_tlink_release;
+	dev->kobj.release_debug = true;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
         else
@@ -664,6 +666,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	device_initialize(dev);
 	dev->parent = get_device(&link->tdev);
 	dev->release = ata_tdev_release;
+	dev->kobj.release_debug = true;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
         else
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 53828b6c..074bb45 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -965,6 +965,8 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
+	pdev->dev.kobj.release_debug = true;
+
 	ret = -EBUSY;
 	if (devm_request_region(&pdev->dev, io, 8, "pata_legacy") == NULL ||
 	    devm_request_region(&pdev->dev, io + 0x0206, 1,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 020ea7f..6666a49 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -803,8 +803,17 @@ static void device_release(struct kobject *kobj)
 	 * is deleted but alive, so release devres here to avoid
 	 * possible memory leak.
 	 */
+	if (kobj->release_debug)
+		dev_info(dev, "XXX device_release: drel=%pf trel=%pf cdrel=%pf\n",
+			 dev->release,
+			 dev->type ? dev->type->release : NULL,
+			 dev->class ? dev->class->dev_release : NULL);
+
 	devres_release_all(dev);
 
+	if (kobj->release_debug)
+		dev_info(dev, "XXX device_release: devres_release_all() done\n");
+
 	if (dev->release)
 		dev->release(dev);
 	else if (dev->type && dev->type->release)
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index e628459..e1740de 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -76,6 +76,7 @@ struct kobject {
 	unsigned int state_add_uevent_sent:1;
 	unsigned int state_remove_uevent_sent:1;
 	unsigned int uevent_suppress:1;
+	unsigned int release_debug:1;
 };
 
 extern __printf(2, 3)
diff --git a/lib/kobject.c b/lib/kobject.c
index 445dcae..058c486 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -595,6 +595,13 @@ struct kobject *kobject_get(struct kobject *kobj)
 			WARN(1, KERN_WARNING "kobject: '%s' (%p): is not "
 			       "initialized, yet kobject_get() is being "
 			       "called.\n", kobject_name(kobj), kobj);
+		if (kobj->release_debug)
+			printk("XXX kobject_get(%s): ref=%d++ (%pf:%pf:%pf)\n",
+			       kobject_name(kobj),
+			       atomic_read(&kobj->kref.refcount),
+			       __builtin_return_address(1),
+			       __builtin_return_address(2),
+			       __builtin_return_address(3));
 		kref_get(&kobj->kref);
 	}
 	return kobj;
@@ -620,6 +627,14 @@ static void kobject_cleanup(struct kobject *kobj)
 	pr_debug("kobject: '%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
+	if (kobj->release_debug)
+		printk("XXX kobject_cleanup(%s): rel=%pf (%pf:%pf:%pf)\n",
+		       kobject_name(kobj),
+		       (t && t->release) ? t->release : NULL,
+		       __builtin_return_address(1),
+		       __builtin_return_address(2),
+		       __builtin_return_address(3));
+
 	if (t && !t->release)
 		pr_debug("kobject: '%s' (%p): does not have a release() "
 			 "function, it is broken and must be fixed.\n",
@@ -688,6 +703,13 @@ void kobject_put(struct kobject *kobj)
 			WARN(1, KERN_WARNING "kobject: '%s' (%p): is not "
 			       "initialized, yet kobject_put() is being "
 			       "called.\n", kobject_name(kobj), kobj);
+		if (kobj->release_debug)
+			printk("XXX kobject_put(%s): ref=%d-- (%pf:%pf:%pf)\n",
+			       kobject_name(kobj),
+			       atomic_read(&kobj->kref.refcount),
+			       __builtin_return_address(1),
+			       __builtin_return_address(2),
+			       __builtin_return_address(3));
 		kref_put(&kobj->kref, kobject_release);
 	}
 }
