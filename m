From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/13] libata-hp: implement SCSI part of hotplug
Date: Fri, 09 Jun 2006 11:58:10 +0900
Message-ID: <4488E3C2.6000705@gmail.com>
References: <11490747442153-git-send-email-htejun@gmail.com> <44888EE8.6090405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:64049 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965114AbWFIC6R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jun 2006 22:58:17 -0400
Received: by py-out-1112.google.com with SMTP id x31so828756pye
        for <linux-ide@vger.kernel.org>; Thu, 08 Jun 2006 19:58:17 -0700 (PDT)
In-Reply-To: <44888EE8.6090405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 5697194..4071156 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -521,7 +521,7 @@ struct ata_port {
>>      struct ata_host_set    *host_set;
>>      struct device         *dev;
>>  
>> -    struct work_struct    port_task;
>> +    struct work_struct    port_task, hotplug_task;
> 
> nit:  break this into two lines.

Will do.

-- 
tejun
