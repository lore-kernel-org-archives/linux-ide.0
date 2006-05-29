From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 18:08:11 +0900
Message-ID: <447AB9FB.6020706@gmail.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com> <44779A05.4010209@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:34348 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750787AbWE2JIS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 05:08:18 -0400
Received: by wx-out-0102.google.com with SMTP id h27so312033wxd
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 02:08:17 -0700 (PDT)
In-Reply-To: <44779A05.4010209@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> zhao, forrest wrote:
>> Hi, all
>>
>> This patch makes libata "Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE
>> command" and clean the things up(e.g. revalidate and rescan).
>> Here is the processing path:
>>
>> 1 in ata_scsi_qc_complete(), if we find that a "SET FEATURES - WRITE 
>> CACHE
>> ENABLE/DISABLE" command is executed successfully, we schedule the 
>> according
>> port to do revalidation
>> 2 in ata_dev_revalidate(), if we find that the "write cahce enable 
>> bit" was
>> changed, set port flags in order to schedule scsi_rescan_device() 
>> later in
>> ata_scsi_error()
>> 3 in ata_scsi_error(), if ATA_FLAG_SCSI_RESCAN is set for ap->flags, we
>> queue the ata_scsi_dev_rescan() to work_queue "ata_scsi_wq"
>> 4 at last, scsi_rescan_device() is invoked, so the current state of 
>> "write
>> cahce enable bit" is propogated to SCSI layer.
> 
> I agree with the concept, and agree that the SCSI layer must be notified 
> when the ATA write cache type changes.  However, I NAK the patch for the 
> following reasons:
> 
> 1) Tejun's revalidate should trigger scsi_rescan_device(), as your patch 
> indicates.  But that's pretty much all that needs to be done.
> 
> 2) Thus, a new bit (ATA_FLAG_SCSI_RESCAN) and a new workqueue are 
> unnecessary.

SCSI rescan is done by issuing commands using scsi_execute_req().  The 
commands are supposed to be processed via normal SCSI command execution 
path which is blocked during EH is in progress, so we need to rescan in 
separate context.

> 3) While the following test is correct,
> +    if ((dev->id[85] & (1 << 5)) != (id[85] & (1 << 5)))
> +        dev->ap->flags |= ATA_FLAG_SCSI_RESCAN;
> 
> there is no pressing need to avoid unnecessary rescans, during 
> revalidation.

Agreed.  Just rescan unconditionally.

> 4) Using [__]scsi_add_device() is a regression from using 
> scsi_scan_target()

I think it's taken from the hotplug patch store-attached-SCSI-device[1]. 
  Using [__]scsi_add_device() seems to be the only way to reliably 
obtain the attached sdev.

More notes...

* I've renamed ata_hotplug_wq to ata_scsi_wq in hotplug patches.  I 
think rescan can use this wq instead of creating its own.

* When snooping for SETFEATURES in ata_scsi_qc_complete(), why check 
cdb[0] for ATA_16/12?  Isn't simply checking tf.command enough?

* There's a race window between ATA revalidation and SCSI rescan.  We 
can plug this hole by deferring commands till rescan is complete.  But I 
doubt it would be worth the trouble.

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/10898
