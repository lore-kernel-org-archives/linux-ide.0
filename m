From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 05:20:16 -0400
Message-ID: <447ABCD0.2060305@garzik.org>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com> <44779A05.4010209@garzik.org> <447AB9FB.6020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43205 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750798AbWE2JUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2006 05:20:20 -0400
In-Reply-To: <447AB9FB.6020706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> 4) Using [__]scsi_add_device() is a regression from using 
>> scsi_scan_target()
> 
> I think it's taken from the hotplug patch store-attached-SCSI-device[1]. 
>  Using [__]scsi_add_device() seems to be the only way to reliably obtain 
> the attached sdev.


We want to continue to use scsi_scan_target(), because that's the 
preferred model.  In SCSI-land, the target is what receives RPC calls 
(ATA commands, for us), which are then dispatched internally to one of 
$N logical units (LU) according to the logical unit number (LUN).

In libata, of course, there is only one logical unit attached to the 
target, LUN 0.

Regardless, using [__]scsi_add_device() is a regression, because libata 
handles the transport layer completely -- and importantly -- handles all 
addressing.  scsi_add_device() is specifically for H/C/I/L, i.e. SPI 
(parallel SCSI) addressing.

Eventually SCSI will reach a point where HCIL is not the only addressing 
method.  SAS disks, for example, are addressed via a LUN's WWN.  SCSI 
fibre channel addresses LUNs via WWN as well.  Once SCSI core does not 
exclusively use HCIL addressing, libata will reap the benefits of using 
the proper scsi_target model.

	Jeff



