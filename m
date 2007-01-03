From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for ATA_16 commands to ATAPI devices
Date: Wed, 03 Jan 2007 00:47:54 -0500
Message-ID: <459B438A.8070601@rtr.ca>
References: <200701021939.10496.liml@rtr.ca> <459AFDC2.6060900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1378 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbXACFsA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 00:48:00 -0500
In-Reply-To: <459AFDC2.6060900@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>> This patch adds support for passing ATA_16 commands
>> through to ATAPI devices in libata.  In practice, the upper layers will
>> still currently prevent ATA_16 commands, as no (?) ATAPI drives support
>> them yet.  But it will work if such a drive is ever encountered.
>>
>> Support for ATA_16 is necessary for using SG_IO from userspace,
>> and an upcoming hdparm release will be updated to use this interface.
>>
>> This version is very similar to the earlier first submission,
>> except that ATA_12 is no longer passed through to ATAPI
>> because of the conflict it has with the SCSI BLANK opcode.
..
> As I said, provide some avenue for the user to choose.

The user does NOT want to choose here.  They just want it to work,
without needing to alter some mysterious boot flag from app to app.  ;)

The only conflict was with ATA_12, and that is no longer a problem here,
so no option is necessary for it.

ATA_16 is a heretofore unused opcode, now standardized for the future.
It falls completely outside the "vendor specific" opcode blocks for SCSI
(there's a standard formula for those, and ATA_16 doesn't fit it).

We can add a useless boot/module flag if you really want one, though.
But it's really just bloat in this case.

Cheers
