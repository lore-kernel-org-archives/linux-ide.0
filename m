From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Tue, 30 May 2006 16:22:29 +0900
Message-ID: <447BF2B5.5050000@gmail.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com>	 <44779A05.4010209@garzik.org> <447AB9FB.6020706@gmail.com>	 <447BCCFC.10908@garzik.org> <447BCF0A.7020709@gmail.com>	 <447BD0AE.2080904@garzik.org>  <447BD3E0.4010002@gmail.com> <1148965709.3466.37.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:39322 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932152AbWE3HWf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 03:22:35 -0400
Received: by py-out-1112.google.com with SMTP id e30so625254pya
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2006 00:22:35 -0700 (PDT)
In-Reply-To: <1148965709.3466.37.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-05-30 at 14:10 +0900, Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> Jeff Garzik wrote:
>>>>> Tejun Heo wrote:
>>>>>> * I've renamed ata_hotplug_wq to ata_scsi_wq in hotplug patches.  I 
>>>>>> think rescan can use this wq instead of creating its own.
>>>>> I think we will use this workqueue even when SCSI is optional, so 
>>>>> ata_scsi_wq may not be the best name, long term.  I ACK'd its 
>>>>> inclusion of course, so not a big deal.
>>>> As it seems there will be another round of hotplug patches, I can 
>>>> rename it without too much trouble.  My candidates are...
>>>>
>>>> ata_aux_wq
>>>> ata_management_wq / ata_mgmt_wq
>>>> ata_errands_wq
>>> Another thing to consider is using the kthread API, ignore workqueues, 
>>> and simply creating "one-shot" threads as needed.
>> It wouldn't work for SCSI hotplug.  It depends on that there is only one 
>> thread running the thing, so I think wq is the better choice.  Any 
>> suggestion on naming?
> 
> ata_misc_wq?
> ata_sweep_wq?

I think I'm going with ata_aux_wq.

-- 
tejun
