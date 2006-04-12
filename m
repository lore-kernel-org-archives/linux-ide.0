From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/15] libata-hp: implement ata_scsi_slave_destroy()
Date: Wed, 12 Apr 2006 18:32:47 -0400
Message-ID: <443D800F.2070608@pobox.com>
References: <1144764846705-git-send-email-htejun@gmail.com> <11447648471249-git-send-email-htejun@gmail.com> <20060412052742.GA25726@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:17590 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932361AbWDLWc5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 18:32:57 -0400
In-Reply-To: <20060412052742.GA25726@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Tue, Apr 11, 2006 at 11:14:07PM +0900, Tejun Heo wrote:
>> This function is called during sdev removal by SCSI midlayer.  For
>> user-initiated removals, this is the only indication we get from SCSI
>> midlayer that the sdev is going away.  In such cases, schedule ATA
>> detach and invoke EH.  For libata-initiated removal, nothing needs to
>> be done.
>>
> 
> User initiated warm unplugging has a race condition.  If user
> initiated warm unplug kicks int after ata_scsi_remove_dev() fetched
> dev->sdev but before it actually removes the device, the sdev will go
> away while ata_scsi_remove_dev() is still trying to remove it.  This
> can be solved by doing scsi_device_get() in ata_scsi_remove_dev()
> after fetching dev->sdev.
> 
> I'll post the fixed version in the next round.  The #upstream change
> breaks all EH/NCQ/hotplug patchsets anyway.  My repo currently
> contains the following changes from the posted version.
> 
> * above mentioned sdev removal race fix
> * scsi_eh_schedule_* are updated to reflect ->eh_strategy_handler
>   relocation
> * duplicate .can_queue initialization removed from sil24-NCQ patch
>   removed (why doesn't compiler complian about this?)
> * updated to use ata_shost_to_port()
> 
> I think above changes shouldn't hinder reviewing process too much.
> Though, if you want me to post the updated version, just let me know.

Actually, you have so many patches now, it would make the process go 
faster to post them in cascading git branches somewhere.

tejun.git#p5	== libata-dev.git#upstream + new EH framework
tejun.git#p6	== #p5 + new EH implementation
tejun.git#p7	== #p6 + add new NCQ support
etc.

That way, if I approve through patchset #7, I can just pull 
tejun.git#p7, and get all patchsets through patchset 7.  If some patches 
need to be revised, a script should be able to reconstitute these sets 
of branches.

git is recommended for high volume submittors :)

	Jeff



