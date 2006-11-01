From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Tue, 31 Oct 2006 21:03:06 -0500
Message-ID: <4548005A.4000605@pobox.com>
References: <20061020050948.GF13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29397 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946388AbWKACDJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 21:03:09 -0500
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
>   ata_set_port_max_cmd_len() unnecessary and dev->cdb_len meaningless
>   for ATA devices.  Both are stripped away.  Note that this doesn't
>   breach error checking in any substantial way.  shost->max_cmd_len
>   has never beena ble to properly protect CDB length violation anyway.
> 
> This problem has been spotted by Doublas Gilbert <dougg@torque.net>.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Douglas Gilbert <dougg@torque.net>

Resuming from the thread:

* Regarding CDB length:  DEPENDING ON IMPLEMENTATION DETAILS AND HOT 
PATH IMPACT, I think Douglas's comment about CDB lengths is fair:  we 
could unconditionally set the limit to 16 bytes, and then filter out 
16-byte CDBs at a lower level if the ATAPI device doesn't support 
16-byte CDBs.

* We need a better solution for the duplicate opcode.

