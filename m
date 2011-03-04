From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Fri, 04 Mar 2011 12:22:31 -0500
Message-ID: <4D711FD7.6080507@pobox.com>
References: <20110304085501.8B331F90E1@ochil.suse.de> <20110304170904.GW20499@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34205 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759919Ab1CDRWe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 12:22:34 -0500
Received: by qyk7 with SMTP id 7so364306qyk.19
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2011 09:22:34 -0800 (PST)
In-Reply-To: <20110304170904.GW20499@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org

On 03/04/2011 12:09 PM, Tejun Heo wrote:
> Hello, Hannes.
>
> On Fri, Mar 04, 2011 at 09:55:01AM +0100, Hannes Reinecke wrote:
>> +static inline int ata_id_has_wwn(const u16 *id)
>> +{
>> +	if ((id[ATA_ID_CSF_DEFAULT]&  0xC000) != 0x4000)
>> +		return 0;
>> +	return id[ATA_ID_CSF_DEFAULT]&  (1<<  8);
>> +}
>
> Can you please make this return bool?  Otherwise,

And if you're highly motivated, a separate patch to update 
include/linux/ata.h to return bool for obvious ata_id_has_xxx functions 
would be nice too.

But yes, including WWN here is just fine.


