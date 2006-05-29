From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 18:43:47 +0900
Message-ID: <447AC253.10608@gmail.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com> <44779A05.4010209@garzik.org> <447AB9FB.6020706@gmail.com> <447ABCD0.2060305@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:43438 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750767AbWE2Jnx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 05:43:53 -0400
Received: by py-out-1112.google.com with SMTP id e30so343015pya
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 02:43:53 -0700 (PDT)
In-Reply-To: <447ABCD0.2060305@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> 4) Using [__]scsi_add_device() is a regression from using 
>>> scsi_scan_target()
>>
>> I think it's taken from the hotplug patch 
>> store-attached-SCSI-device[1].  Using [__]scsi_add_device() seems to 
>> be the only way to reliably obtain the attached sdev.
> 
> 
> We want to continue to use scsi_scan_target(), because that's the 
> preferred model.  In SCSI-land, the target is what receives RPC calls 
> (ATA commands, for us), which are then dispatched internally to one of 
> $N logical units (LU) according to the logical unit number (LUN).
> 
> In libata, of course, there is only one logical unit attached to the 
> target, LUN 0.
> 
> Regardless, using [__]scsi_add_device() is a regression, because libata 
> handles the transport layer completely -- and importantly -- handles all 
> addressing.  scsi_add_device() is specifically for H/C/I/L, i.e. SPI 
> (parallel SCSI) addressing.
> 
> Eventually SCSI will reach a point where HCIL is not the only addressing 
> method.  SAS disks, for example, are addressed via a LUN's WWN.  SCSI 
> fibre channel addresses LUNs via WWN as well.  Once SCSI core does not 
> exclusively use HCIL addressing, libata will reap the benefits of using 
> the proper scsi_target model.

I fully agree with everything you said, but we're faced with a real 
problem here.  libata needs to know the current attached sdev for 
hotplug and rescan; however, there's no way to determine the current 
sdev after it's already added.

scsi_device_lookup*() functions don't discriminate between dead and live 
devices and ends up operating on the first device it stumbles upon (the 
dead one if it's still hanging around).  Storing dev->sdev was a way to 
get around the limitation.  If a SCSI function which looks up the live 
device is implemented, we don't need to store dev->sdev at all.  IMHO, 
the current implementation can be left as it is until such interface is 
implemented.

Thanks.

-- 
tejun
