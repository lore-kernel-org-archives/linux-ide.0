From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 13/13] libata-hp: add ata_hotplug_wq
Date: Thu, 13 Apr 2006 14:11:25 +0800
Message-ID: <1144908685.19687.11.camel@localhost.localdomain>
References: <11447643821791-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58026 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964789AbWDMGVs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Apr 2006 02:21:48 -0400
In-Reply-To: <11447643821791-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

On Tue, 2006-04-11 at 23:06 +0900, Tejun Heo wrote:
> 1438492c4408fc908d3fb5865fd56231360a2fcd
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 0206791..610f963 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -72,6 +72,8 @@ static void ata_dev_xfermask(struct ata_
>  static unsigned int ata_unique_id = 1;
>  static struct workqueue_struct *ata_wq;
>  
> +struct workqueue_struct *ata_hotplug_wq;
> +
>  int atapi_enabled = 1;
>  module_param(atapi_enabled, int, 0444);
>  MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
> @@ -5300,6 +5302,12 @@ static int __init ata_init(void)
>  	if (!ata_wq)
>  		return -ENOMEM;
>  
> +	ata_hotplug_wq = create_workqueue("ata_hotplug");
> +	if (!ata_hotplug_wq) {
> +		destroy_workqueue(ata_wq);
> +		return -ENOMEM;
> +	}
> +
>  	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
>  	return 0;
>  }

create_workqueue() creates one workqueue for each logic CPU in
the system, so when loading libata.ko in a system with 8 CPU's
8 work queues for ata_hotplug will be created. Does it make sense
to use create_singlethread_workqueue() to create only one workqueue
for ata_hotplug since hotplug is not the operation happened with
high frequency?

Thanks,
Forrest
