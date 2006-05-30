From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Tue, 30 May 2006 13:08:29 +0800
Message-ID: <1148965709.3466.37.camel@forrest26.sh.intel.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com>
	 <44779A05.4010209@garzik.org> <447AB9FB.6020706@gmail.com>
	 <447BCCFC.10908@garzik.org> <447BCF0A.7020709@gmail.com>
	 <447BD0AE.2080904@garzik.org>  <447BD3E0.4010002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:829 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932075AbWE3FUD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 01:20:03 -0400
In-Reply-To: <447BD3E0.4010002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, linux-ide@vger.kernel.org

On Tue, 2006-05-30 at 14:10 +0900, Tejun Heo wrote:
> Jeff Garzik wrote:
> > Tejun Heo wrote:
> >> Jeff Garzik wrote:
> >>> Tejun Heo wrote:
> >>>> * I've renamed ata_hotplug_wq to ata_scsi_wq in hotplug patches.  I 
> >>>> think rescan can use this wq instead of creating its own.
> >>>
> >>> I think we will use this workqueue even when SCSI is optional, so 
> >>> ata_scsi_wq may not be the best name, long term.  I ACK'd its 
> >>> inclusion of course, so not a big deal.
> >>
> >> As it seems there will be another round of hotplug patches, I can 
> >> rename it without too much trouble.  My candidates are...
> >>
> >> ata_aux_wq
> >> ata_management_wq / ata_mgmt_wq
> >> ata_errands_wq
> > 
> > Another thing to consider is using the kthread API, ignore workqueues, 
> > and simply creating "one-shot" threads as needed.
> 
> It wouldn't work for SCSI hotplug.  It depends on that there is only one 
> thread running the thing, so I think wq is the better choice.  Any 
> suggestion on naming?

ata_misc_wq?
ata_sweep_wq?
