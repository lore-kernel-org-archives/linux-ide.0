From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 23:57:19 -0400
Message-ID: <447BC29F.6010708@garzik.org>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com> <44779A05.4010209@garzik.org> <447AB9FB.6020706@gmail.com> <447ABCD0.2060305@garzik.org> <447AC253.10608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64994 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751306AbWE3D5Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2006 23:57:24 -0400
In-Reply-To: <447AC253.10608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Jeff Garzik wrote:
>>>> 4) Using [__]scsi_add_device() is a regression from using 
>>>> scsi_scan_target()
>>>
>>> I think it's taken from the hotplug patch 
>>> store-attached-SCSI-device[1].  Using [__]scsi_add_device() seems to 
>>> be the only way to reliably obtain the attached sdev.
>>
>>
>> We want to continue to use scsi_scan_target(), because that's the 
>> preferred model.  In SCSI-land, the target is what receives RPC calls 
>> (ATA commands, for us), which are then dispatched internally to one of 
>> $N logical units (LU) according to the logical unit number (LUN).
>>
>> In libata, of course, there is only one logical unit attached to the 
>> target, LUN 0.
>>
>> Regardless, using [__]scsi_add_device() is a regression, because 
>> libata handles the transport layer completely -- and importantly -- 
>> handles all addressing.  scsi_add_device() is specifically for 
>> H/C/I/L, i.e. SPI (parallel SCSI) addressing.
>>
>> Eventually SCSI will reach a point where HCIL is not the only 
>> addressing method.  SAS disks, for example, are addressed via a LUN's 
>> WWN.  SCSI fibre channel addresses LUNs via WWN as well.  Once SCSI 
>> core does not exclusively use HCIL addressing, libata will reap the 
>> benefits of using the proper scsi_target model.
> 
> I fully agree with everything you said, but we're faced with a real 
> problem here.  libata needs to know the current attached sdev for 
> hotplug and rescan; however, there's no way to determine the current 
> sdev after it's already added.

[looks at the core code again]  That's not the problem.  The real 
problem is that scsi_target hotplug infrastructure is non-existent. 
scsi_transport_fc gives a hint as to how nasty it would be to add such 
code, too.

So, life sucks.  Oh well.  Your solution is therefore the best, under 
present circumstances.  ACK use of [__]scsi_add_device().

	Jeff


