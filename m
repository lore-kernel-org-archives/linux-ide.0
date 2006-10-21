From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Sat, 21 Oct 2006 15:16:28 -0400
Message-ID: <453A720C.6070905@pobox.com>
References: <20061020050948.GF13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60141 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422686AbWJUTQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2006 15:16:34 -0400
In-Reply-To: <20061020050948.GF13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, dougg@torque.net

Tejun Heo wrote:
> libata used to pass all SCSI commands directly to ATAPI devices.
> However, this is incorrect for ATA passthrough commands as they must
> be handled by the SAT layer in libata.  Also, regardless of the
> attached ATAPI device's supported packet length, SAT says that both
> flavors of passthrough commands (ATA12 and ATA16) should work.
> 
> This patch makes the following changes to fix ATA passthrough handling
> for ATAPI devices.
> 
> * implement atapi_get_xlat_func() and make libata handle ATA12 and
>   ATA16 in SAT layer instead of passing it directly to the target
>   device even if the device is ATAPI.
> 
> * Always allow 16byte CDBs for ATAPI devices.  This makes

This is definitely wrong.  Some ATAPI devices are limited to 12-byte CDBs.

Also, are we sure that no ATAPI device ever implements these opcodes?

Prior to the SAT spec -- which includes most ATAPI firmwares -- those 
opcodes might have been vendor-reserved space.  Did you or Doug verify 
against the older specifications who might care about these opcodes?

Or maybe there is a flag somewhere we can abuse, that permits support of 
both scenarios -- passing the command to the device, and handling the 
command internally?

	Jeff



