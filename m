From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/13] libata-hp: add ata_hotplug_wq
Date: Thu, 13 Apr 2006 15:33:06 +0900
Message-ID: <443DF0A2.8070307@gmail.com>
References: <11447643821791-git-send-email-htejun@gmail.com> <1144908685.19687.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:57480 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964783AbWDMGdG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 02:33:06 -0400
Received: by pproxy.gmail.com with SMTP id i49so1882158pye
        for <linux-ide@vger.kernel.org>; Wed, 12 Apr 2006 23:33:05 -0700 (PDT)
In-Reply-To: <1144908685.19687.11.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-04-11 at 23:06 +0900, Tejun Heo wrote:
>> 1438492c4408fc908d3fb5865fd56231360a2fcd
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index 0206791..610f963 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -72,6 +72,8 @@ static void ata_dev_xfermask(struct ata_
>>  static unsigned int ata_unique_id = 1;
>>  static struct workqueue_struct *ata_wq;
>>  
>> +struct workqueue_struct *ata_hotplug_wq;
>> +
>>  int atapi_enabled = 1;
>>  module_param(atapi_enabled, int, 0444);
>>  MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
>> @@ -5300,6 +5302,12 @@ static int __init ata_init(void)
>>  	if (!ata_wq)
>>  		return -ENOMEM;
>>  
>> +	ata_hotplug_wq = create_workqueue("ata_hotplug");
>> +	if (!ata_hotplug_wq) {
>> +		destroy_workqueue(ata_wq);
>> +		return -ENOMEM;
>> +	}
>> +
>>  	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
>>  	return 0;
>>  }
> 
> create_workqueue() creates one workqueue for each logic CPU in
> the system, so when loading libata.ko in a system with 8 CPU's
> 8 work queues for ata_hotplug will be created. Does it make sense
> to use create_singlethread_workqueue() to create only one workqueue
> for ata_hotplug since hotplug is not the operation happened with
> high frequency?
> 

Yeap, that makes a lot of sense.  Will change to single threaded variant.

Thanks.

-- 
tejun
