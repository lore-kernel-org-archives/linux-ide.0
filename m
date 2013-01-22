From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [libata:upstream 7/11] drivers/ata/libata-zpodd.c:83
 zpodd_wake_dev() warn: variable dereferenced before check 'ata_dev' (see
 line 80)
Date: Tue, 22 Jan 2013 09:25:36 +0300
Message-ID: <20130122062536.GB16282@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27280 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab3AVGZi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2013 01:25:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, kbuild@01.org

Hi Aaron,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream
head:   7e15e9be37eb834aaaca69030064ac97eaf5df2f
commit: f064a20dded807448669426c9bfb7d03aba5659c [7/11] libata: move acpi notification code to zpodd

New smatch warnings:
drivers/ata/libata-zpodd.c:83 zpodd_wake_dev() warn: variable dereferenced before check 'ata_dev' (see line 80)

git remote add libata git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
git remote update libata
git checkout f064a20dded807448669426c9bfb7d03aba5659c
vim +/ata_dev +83 drivers/ata/libata-zpodd.c

afe75951 Aaron Lu 2013-01-15  74  	return acpi_device_can_poweroff(acpi_dev);
afe75951 Aaron Lu 2013-01-15  75  }
afe75951 Aaron Lu 2013-01-15  76  
f064a20d Aaron Lu 2013-01-15  77  static void zpodd_wake_dev(acpi_handle handle, u32 event, void *context)
f064a20d Aaron Lu 2013-01-15  78  {
f064a20d Aaron Lu 2013-01-15  79  	struct ata_device *ata_dev = context;
f064a20d Aaron Lu 2013-01-15 @80  	struct zpodd *zpodd = ata_dev->zpodd;
f064a20d Aaron Lu 2013-01-15  81  	struct device *dev = &ata_dev->sdev->sdev_gendev;
f064a20d Aaron Lu 2013-01-15  82  
f064a20d Aaron Lu 2013-01-15 @83  	if (event == ACPI_NOTIFY_DEVICE_WAKE && ata_dev &&
f064a20d Aaron Lu 2013-01-15  84  			pm_runtime_suspended(dev)) {
f064a20d Aaron Lu 2013-01-15  85  		zpodd->from_notify = true;
f064a20d Aaron Lu 2013-01-15  86  		pm_runtime_resume(dev);

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
