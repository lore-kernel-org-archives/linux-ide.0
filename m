From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] RESPIN: libata: add atapi_passthru=1 parameter
Date: Fri, 19 Jan 2007 19:08:05 -0500
Message-ID: <45B15D65.1060203@garzik.org>
References: <200701021939.10496.liml@rtr.ca> <459B438A.8070601@rtr.ca> <200701030101.09838.liml@rtr.ca> <200701030124.19568.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53685 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932810AbXATAIH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:08:07 -0500
In-Reply-To: <200701030124.19568.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> On Wednesday 03 January 2007 01:01, Mark Lord wrote:
>> ..
>> This patch isn't really needed, but it might provide an "out"
>> just in case somebody has some really non-compliant hardware
>> out there someday.
>>
>> Add a boot/module parameter for libata to force the ATA_16
>> SCSI opcode to not be interpreted as a standards-compliant
>> ATA passthrough mechanism when used on an ATAPI device
>>  -- instead, it gets passed directly to the ATAPI device.
> 
> This version of the patch leaves ATA_16 enabled for non-ATAPI
> regardless of the setting of the new module parm.  Take your pick.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>

ACK this version of the patch, but it does not apply to #upstream...

	Jeff



