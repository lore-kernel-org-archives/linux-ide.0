From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Tue, 30 May 2006 13:50:18 +0900
Message-ID: <447BCF0A.7020709@gmail.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com> <44779A05.4010209@garzik.org> <447AB9FB.6020706@gmail.com> <447BCCFC.10908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:19467 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932140AbWE3EuZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:50:25 -0400
Received: by wx-out-0102.google.com with SMTP id h27so431085wxd
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:50:24 -0700 (PDT)
In-Reply-To: <447BCCFC.10908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> * I've renamed ata_hotplug_wq to ata_scsi_wq in hotplug patches.  I 
>> think rescan can use this wq instead of creating its own.
> 
> I think we will use this workqueue even when SCSI is optional, so 
> ata_scsi_wq may not be the best name, long term.  I ACK'd its inclusion 
> of course, so not a big deal.

As it seems there will be another round of hotplug patches, I can rename 
it without too much trouble.  My candidates are...

ata_aux_wq
ata_management_wq / ata_mgmt_wq
ata_errands_wq

>> * When snooping for SETFEATURES in ata_scsi_qc_complete(), why check 
>> cdb[0] for ATA_16/12?  Isn't simply checking tf.command enough?
> 
> yes
> 
> 
>> * There's a race window between ATA revalidation and SCSI rescan.  We 
>> can plug this hole by deferring commands till rescan is complete.  But 
>> I doubt it would be worth the trouble.
> 
> probably, we'll see...  :)

Yeap, let's see.  I think this should fix Ric's cache type / barrier 
type problem.

-- 
tejun
