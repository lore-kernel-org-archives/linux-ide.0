From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/15] libata-hp: implement ata_scsi_slave_destroy()
Date: Wed, 12 Apr 2006 14:27:42 +0900
Message-ID: <20060412052742.GA25726@htj.dyndns.org>
References: <1144764846705-git-send-email-htejun@gmail.com> <11447648471249-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:12008 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750797AbWDLF1o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 01:27:44 -0400
Received: by zproxy.gmail.com with SMTP id o37so1279069nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 22:27:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11447648471249-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

On Tue, Apr 11, 2006 at 11:14:07PM +0900, Tejun Heo wrote:
> This function is called during sdev removal by SCSI midlayer.  For
> user-initiated removals, this is the only indication we get from SCSI
> midlayer that the sdev is going away.  In such cases, schedule ATA
> detach and invoke EH.  For libata-initiated removal, nothing needs to
> be done.
> 

User initiated warm unplugging has a race condition.  If user
initiated warm unplug kicks int after ata_scsi_remove_dev() fetched
dev->sdev but before it actually removes the device, the sdev will go
away while ata_scsi_remove_dev() is still trying to remove it.  This
can be solved by doing scsi_device_get() in ata_scsi_remove_dev()
after fetching dev->sdev.

I'll post the fixed version in the next round.  The #upstream change
breaks all EH/NCQ/hotplug patchsets anyway.  My repo currently
contains the following changes from the posted version.

* above mentioned sdev removal race fix
* scsi_eh_schedule_* are updated to reflect ->eh_strategy_handler
  relocation
* duplicate .can_queue initialization removed from sil24-NCQ patch
  removed (why doesn't compiler complian about this?)
* updated to use ata_shost_to_port()

I think above changes shouldn't hinder reviewing process too much.
Though, if you want me to post the updated version, just let me know.

Thanks.

-- 
tejun
