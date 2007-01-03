From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] RESPIN: libata: add atapi_passthru=1 parameter
Date: Wed, 03 Jan 2007 13:17:30 -0500
Message-ID: <459BF33A.8050003@rtr.ca>
References: <200701021939.10496.liml@rtr.ca> <459B438A.8070601@rtr.ca> <200701030101.09838.liml@rtr.ca> <200701030124.19568.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2230 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbXACSRe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 13:17:34 -0500
In-Reply-To: <200701030124.19568.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> On Wednesday 03 January 2007 01:01, Mark Lord wrote:
..
>> Add a boot/module parameter for libata to force the ATA_16
>> SCSI opcode to not be interpreted as a standards-compliant
>> ATA passthrough mechanism when used on an ATAPI device
>>  -- instead, it gets passed directly to the ATAPI device.
..
> +int atapi_passthru = 0;
> +module_param(atapi_passthru, int, 0444);
> +MODULE_PARM_DESC(atapi_passthru, "Enable passthru of SCSI opcode 0x85 to ATAPI devices");

Oh, and if anyone can come up with a less-sucky name for this variable,
then PLEASE do so!  I don't like it, but had trouble inventing anything
better that didn't harken back to my (long ago) COBOL days.. ;)

Cheers
