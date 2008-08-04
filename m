From: "Grant Grundler" <grundler@google.com>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140, simg 3726
Date: Mon, 4 Aug 2008 13:58:07 -0700
Message-ID: <da824cf30808041358p76eaf520w837a6d922db1747e@mail.gmail.com>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com>
	 <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:10295 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756413AbYHDU6U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 16:58:20 -0400
Received: from zps19.corp.google.com (zps19.corp.google.com [172.25.146.19])
	by smtp-out.google.com with ESMTP id m74Kw95s019322
	for <linux-ide@vger.kernel.org>; Mon, 4 Aug 2008 21:58:09 +0100
Received: from rv-out-0708.google.com (rvbk29.prod.google.com [10.140.87.29])
	by zps19.corp.google.com with ESMTP id m74Kw85P008272
	for <linux-ide@vger.kernel.org>; Mon, 4 Aug 2008 13:58:08 -0700
Received: by rv-out-0708.google.com with SMTP id k29so2503860rvb.30
        for <linux-ide@vger.kernel.org>; Mon, 04 Aug 2008 13:58:08 -0700 (PDT)
In-Reply-To: <48918DD9.9050603@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: khchen@synology.com, linux-ide@vger.kernel.org

On Thu, Jul 31, 2008 at 3:03 AM, Tejun Heo <tj@kernel.org> wrote:
...
> Heh.. didn't read the last line.  If you can't upgrade the kernel,
> you'll need to backport.  We had to fix core PMP support quite a bit to
> get mv working, so you'll need to backport whole libata, which usually
> isn't too difficult.  Someone knowledgeable would be able to pull it in
> a few days but if you don't know what you're doing it can be pretty
> hairy.  :-)

Backport libata from 2.6.26 to 2.6.24 is trivial compared
to other stuff I've seen backported. Below is an initial version
someone else did for 2.6.26-rc5 and it seems to be working.
It at least will give you an idea of what changed.

Steps to apply are:
o rm -rf 2.6.24/drivers/ata
o copy 2.6.26/drivers/ata to your 2.6.24/drivers/ata
o apply the following patch and it should at least compile.

hth,
grant

 --- /usr/local/work/linux-2.6.26-rc5/drivers/ata/ahci.c	2008-06-04
23:42:33.000000000 -0700
+++ /usr/local/work/libata2624_all/2.6.24/drivers/ata/ahci.c	2008-06-05
11:55:12.000000000 -0700
@@ -273,8 +273,8 @@
 static int ahci_pci_device_resume(struct pci_dev *pdev);
 #endif

-static struct device_attribute *ahci_shost_attrs[] = {
-	&dev_attr_link_power_management_policy,
+static struct class_device_attribute *ahci_shost_attrs[] = {
+	&class_device_attr_link_power_management_policy,
 	NULL
 };

diff -urNbBwEP /usr/local/work/linux-2.6.26-rc5/drivers/ata/libata-scsi.c
/usr/local/work/libata2624_all/2.6.24/drivers/ata/libata-scsi.c
--- /usr/local/work/linux-2.6.26-rc5/drivers/ata/libata-scsi.c	2008-06-10
02:25:59.000000000 -0700
+++ /usr/local/work/libata2624_all/2.6.24/drivers/ata/libata-scsi.c	2008-06-05
12:19:08.000000000 -0700
@@ -135,11 +135,10 @@
 	return NULL;
 }

-static ssize_t ata_scsi_lpm_put(struct device *dev,
-				struct device_attribute *attr,
+static ssize_t ata_scsi_lpm_put(struct class_device *class_dev,
 				const char *buf, size_t count)
 {
-	struct Scsi_Host *shost = class_to_shost(dev);
+	struct Scsi_Host *shost = class_to_shost(class_dev);
 	struct ata_port *ap = ata_shost_to_port(shost);
 	enum link_pm policy = 0;
 	int i;
@@ -167,9 +166,9 @@
 }

 static ssize_t
-ata_scsi_lpm_show(struct device *dev, struct device_attribute *attr, char *buf)
+ata_scsi_lpm_show(struct class_device *class_dev, char *buf)
 {
-	struct Scsi_Host *shost = class_to_shost(dev);
+	struct Scsi_Host *shost = class_to_shost(class_dev);
 	struct ata_port *ap = ata_shost_to_port(shost);
 	const char *policy =
 		ata_scsi_lpm_get(ap->pm_policy);
@@ -179,9 +178,9 @@

 	return snprintf(buf, 23, "%s\n", policy);
 }
-DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
+CLASS_DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
 		ata_scsi_lpm_show, ata_scsi_lpm_put);
-EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
+EXPORT_SYMBOL_GPL(class_device_attr_link_power_management_policy);

 static void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq)
 {
diff -urNbBwEP /usr/local/work/linux-2.6.26-rc5/drivers/ata/libata-sff.c
/usr/local/work/libata2624_all/2.6.24/drivers/ata/libata-sff.c
--- /usr/local/work/linux-2.6.26-rc5/drivers/ata/libata-sff.c	2008-06-04
23:42:33.000000000 -0700
+++ /usr/local/work/libata2624_all/2.6.24/drivers/ata/libata-sff.c	2008-06-10
00:19:49.000000000 -0700
@@ -278,7 +278,7 @@
 		    	return status;
 	}
 	/* Clear INTRQ latch */
-	status = ata_sff_check_status(ap);
+	status = ap->ops->sff_check_status(ap);
 	return status;
 }
