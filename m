From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: cosmetic updates
Date: Tue, 21 Jul 2009 12:08:01 -0400
Message-ID: <4A65E7E1.3010705@garzik.org>
References: <4A65DAD9.8050001@kernel.org> <4A65DF92.5050305@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53521 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754675AbZGUQID (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jul 2009 12:08:03 -0400
In-Reply-To: <4A65DF92.5050305@novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@novell.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Marcus Meissner <meissner@novell.com>

Tejun Heo wrote:
> Tejun Heo wrote:
>> We're about to add more SATA_* and ATA_ACPI_FILTER_* constants.
>> Reformat them in preparation.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> I was about to send the second patch which filters out the offending
> commands by default but now that I think more about it I think it
> would be better to specifically blacklist the machine.  So, please
> don't commit the first patch.  I'll re-post later along with updated
> patch.

Will do...


