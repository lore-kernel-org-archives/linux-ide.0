From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix incorrect link online check
 during probe
Date: Wed, 07 Oct 2009 15:17:08 +0900
Message-ID: <4ACC3264.1030607@kernel.org>
References: <4ACAFB08.8020501@kernel.org> <4ACBE8EC.3000609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60137 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbZJGGSG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Oct 2009 02:18:06 -0400
In-Reply-To: <4ACBE8EC.3000609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: ide <linux-ide@vger.kernel.org>, stable@kernel.org, Tim Blechmann <tim@klingt.org>

Jeff Garzik wrote:
> On 10/06/2009 04:08 AM, Tejun Heo wrote:
>> While trying to work around spurious detection retries for
>> non-existent devices on slave links, commit
>> 816ab89782ac139a8b65147cca990822bb7e8675 incorrectly added link
>> offline check logic before ata_eh_thaw() was called.  This means that
>> if an occupied link goes down briefly at the time that offline check
>> was performed, device class will be cleared to ATA_DEV_NONE and libata
>> wouldn't retry thus failing detection of the device.
>>
>> The offline check should be done after the port is thawed together
>> with online check so that such link glitches can be detected by the
>> interrupt handler and handled properly.
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> Reported-by: Tim Blechmann<tim@klingt.org>
>> Cc: stable@kernel.org
>> -- 
>>   drivers/ata/libata-eh.c |   50
>> ++++++++++++++++++++++++++++++------------------
>>   1 file changed, 32 insertions(+), 18 deletions(-)
> 
> applied.  BTW, note your separator lost a dash... it should be three
> dashes (---).

Oops, sorry about that.

-- 
tejun
