From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Thu, 19 Jan 2017 16:37:37 -0500
Message-ID: <20170119213737.GB25133@mtj.duckdns.org>
References: <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org>
 <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
 <20161222163711.GB29161@htj.duckdns.org>
 <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
 <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org>
 <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33967 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbdASVqt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2017 16:46:49 -0500
Received: by mail-io0-f193.google.com with SMTP id c80so6400706iod.1
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2017 13:46:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

On Wed, Jan 11, 2017 at 08:54:21PM -0500, tedheadster wrote:
> ​Tejun,
>   I'm interested in debugging this. What can I do to help?

Sorry about taking so long.  I suck. :)

Can you please try the following patch and post what the kernel prints
out?

Thanks.
---
 drivers/ata/pata_legacy.c |    2 ++
 drivers/base/core.c       |    9 +++++++++
 include/linux/kobject.h   |    1 +
 lib/kobject.c             |   22 ++++++++++++++++++++++
 4 files changed, 34 insertions(+)

--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -962,6 +962,8 @@ static __init int legacy_init_one(struct
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
+	pdev->dev.kobj.release_debug = true;
+
 	ret = -EBUSY;
 	if (devm_request_region(&pdev->dev, io, 8, "pata_legacy") == NULL ||
 	    devm_request_region(&pdev->dev, io + 0x0206, 1,
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -803,8 +803,17 @@ static void device_release(struct kobjec
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
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -76,6 +76,7 @@ struct kobject {
 	unsigned int state_add_uevent_sent:1;
 	unsigned int state_remove_uevent_sent:1;
 	unsigned int uevent_suppress:1;
+	unsigned int release_debug:1;
 };
 
 extern __printf(2, 3)
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -595,6 +595,13 @@ struct kobject *kobject_get(struct kobje
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
@@ -620,6 +627,14 @@ static void kobject_cleanup(struct kobje
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
