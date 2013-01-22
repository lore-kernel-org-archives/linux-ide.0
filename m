From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [libata:upstream 7/11] drivers/ata/libata-zpodd.c:83 zpodd_wake_dev()
 warn: variable dereferenced before check 'ata_dev' (see line 80)
Date: Tue, 22 Jan 2013 16:32:06 +0800
Message-ID: <50FE4E86.5090308@intel.com>
References: <20130122062536.GB16282@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32792 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab3AVIbV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jan 2013 03:31:21 -0500
In-Reply-To: <20130122062536.GB16282@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, kbuild@01.org

Hi Dan,

Thanks for the remind.

On 01/22/2013 02:25 PM, Dan Carpenter wrote:
> Hi Aaron,
> 
> FYI, there are new smatch warnings show up in
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream
> head:   7e15e9be37eb834aaaca69030064ac97eaf5df2f
> commit: f064a20dded807448669426c9bfb7d03aba5659c [7/11] libata: move acpi notification code to zpodd
> 
> New smatch warnings:
> drivers/ata/libata-zpodd.c:83 zpodd_wake_dev() warn: variable dereferenced before check 'ata_dev' (see line 80)

The ata_dev variable shouldn't ever be NULL here.

> 
> git remote add libata git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> git remote update libata
> git checkout f064a20dded807448669426c9bfb7d03aba5659c
> vim +/ata_dev +83 drivers/ata/libata-zpodd.c
> 
> afe75951 Aaron Lu 2013-01-15  74  	return acpi_device_can_poweroff(acpi_dev);
> afe75951 Aaron Lu 2013-01-15  75  }
> afe75951 Aaron Lu 2013-01-15  76  
> f064a20d Aaron Lu 2013-01-15  77  static void zpodd_wake_dev(acpi_handle handle, u32 event, void *context)
> f064a20d Aaron Lu 2013-01-15  78  {
> f064a20d Aaron Lu 2013-01-15  79  	struct ata_device *ata_dev = context;
> f064a20d Aaron Lu 2013-01-15 @80  	struct zpodd *zpodd = ata_dev->zpodd;
> f064a20d Aaron Lu 2013-01-15  81  	struct device *dev = &ata_dev->sdev->sdev_gendev;
> f064a20d Aaron Lu 2013-01-15  82  
> f064a20d Aaron Lu 2013-01-15 @83  	if (event == ACPI_NOTIFY_DEVICE_WAKE && ata_dev &&

If I remove the check for ata_dev here, will the smatch warning go away?
Or should I add a check above? I suppose we need to do something to the
warning, so that it won't pop up in the future, so please feel free to
suggest, thanks!

-Aaron

> f064a20d Aaron Lu 2013-01-15  84  			pm_runtime_suspended(dev)) {
> f064a20d Aaron Lu 2013-01-15  85  		zpodd->from_notify = true;
> f064a20d Aaron Lu 2013-01-15  86  		pm_runtime_resume(dev);
> 
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
> 

