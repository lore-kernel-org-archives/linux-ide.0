From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Tue, 30 May 2006 00:57:18 -0400
Message-ID: <447BD0AE.2080904@garzik.org>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com> <44779A05.4010209@garzik.org> <447AB9FB.6020706@gmail.com> <447BCCFC.10908@garzik.org> <447BCF0A.7020709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11750 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932144AbWE3E5V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:57:21 -0400
In-Reply-To: <447BCF0A.7020709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> * I've renamed ata_hotplug_wq to ata_scsi_wq in hotplug patches.  I 
>>> think rescan can use this wq instead of creating its own.
>>
>> I think we will use this workqueue even when SCSI is optional, so 
>> ata_scsi_wq may not be the best name, long term.  I ACK'd its 
>> inclusion of course, so not a big deal.
> 
> As it seems there will be another round of hotplug patches, I can rename 
> it without too much trouble.  My candidates are...
> 
> ata_aux_wq
> ata_management_wq / ata_mgmt_wq
> ata_errands_wq

Another thing to consider is using the kthread API, ignore workqueues, 
and simply creating "one-shot" threads as needed.

	Jeff



