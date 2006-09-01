From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: implement new initialization model w/ iomap
 support, take 2
Date: Fri, 01 Sep 2006 22:45:44 +0900
Message-ID: <44F83988.20102@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com> <44EB80BB.5040309@us.ibm.com> <44F16FF8.7010706@gmail.com> <44F5FBE2.3030201@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:14752 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWIAPKe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Sep 2006 11:10:34 -0400
Received: by nz-out-0102.google.com with SMTP id n1so592526nzf
        for <linux-ide@vger.kernel.org>; Fri, 01 Sep 2006 08:10:33 -0700 (PDT)
In-Reply-To: <44F5FBE2.3030201@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@us.ibm.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, uchang@tw.ibm.com, linux-ide@vger.kernel.org

Hello, Brian.

Brian King wrote:
>> Making the array dynamically-sized isn't difficult at all; however, the 
>> current libata code assumes that ata_host->ports[] array is packed - ie. 
>> no intervening empty entry.  Can SAS keep this restriction or does it 
>> need more flexibility?
> 
> This could be made to work with the addition of a new API. Rather than
> having just ata_sas_port_destroy, we would need ata_sas_port_delete
> and ata_sas_port_free. ata_sas_port_delete would remove the port from
> the ata_host and do everything except free the ata port since there
> could still be references to it. Then ata_sas_port_free would get called
> once all the references were deleted.

I see.

>> Hmmm.... I was kind of hoping SAS could use ata_host_alloc() and store 
>> its pointer and then later release it w/ ata_host_free(), hmmm.. maybe 
>> you can call ata_host_free from ->slave_destroy?.  That gives libata 
>> more control over the host structure (e.g. if we implement dynamic ports 
>> array, it needs to be freed too).  Port lifetime rules aren't changed by 
>> these updates and host free does need some changes but IMHO that 
>> shouldn't be difficult.
> 
> The current design for SAS is to have a single ata_host per scsi host.
> This means the ata_host is really tied to the object lifetime rules
> of the scsi host. In the current SAS code, ata_host_set does not get allocated
> as a separate piece of memory, but rather as part of the scsi_host
> object. This means the memory for the ata_host doesn't get freed until
> the last reference to the scsi host is released. Making ata_host
> a separate allocation changes these rules and forces the caller to
> know when to free the ata_host memory, which they currently do not know.

You're right.  I was confused that ->slave_destroy() is called on host 
release.  SCSI doesn't have host release callback.  What do you think 
about adding a host release callback?  That should make things easier 
and it is generally useful.

> In order to do what you are proposing, I think we would need to add
> some refcounting to the ata_host object. Each allocated ata_port would
> get a reference to its parent ata_host and would put a reference when the
> port is freed. Otherwise I am concerned that we would end up in the situation
> where the ata_host is freed before all the ata ports and the scsi_host is
> freed. It might be appropriate to create an ata_host class device and
> an ata_port class device...

Or we can just keep ata_host_init() and let sas allocate ata_host as 
part of SCSI host and free all dynamic stuff when all ports are 
detached.  It's a bit hacky but should work for the time being.

>> Hmmm.... I see.  Something like ata_dev_attach(adev) after initialized 
>> by SAS maybe?
> 
> Possibly. Are you proposing that ata_dev_attach would then end up calling
> scsi_add_device after doing the ATA initialization stuff?

For SAS, libata isn't controlling SCSI host, so I think it's more 
logical to leave SCSI devices to SAS too.  Would that make much difference?

Thanks.

-- 
tejun

