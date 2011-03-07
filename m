From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Mon, 07 Mar 2011 03:27:41 -0500
Message-ID: <4D7496FD.6040202@pobox.com>
References: <20110304085501.8B331F90E1@ochil.suse.de> <20110304170904.GW20499@htj.dyndns.org> <4D711FD7.6080507@pobox.com> <4D748FF8.1070903@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55365 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1CGI1z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Mar 2011 03:27:55 -0500
Received: by vxi39 with SMTP id 39so3518504vxi.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Mar 2011 00:27:54 -0800 (PST)
In-Reply-To: <4D748FF8.1070903@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 03/07/2011 02:57 AM, Hannes Reinecke wrote:
> On 03/04/2011 06:22 PM, Jeff Garzik wrote:
>> And if you're highly motivated, a separate patch to update
>> include/linux/ata.h to return bool for obvious ata_id_has_xxx functions
>> would be nice too.

> Like this?

> -static inline int ata_id_has_fua(const u16 *id)
> +static inline bool ata_id_has_fua(const u16 *id)
>  {
>  	if ((id[ATA_ID_CFSSE] & 0xC000) != 0x4000)
>  		return 0;
>  	return id[ATA_ID_CFSSE] & (1 << 6);
>  }

Not _quite_ that easy...  one must also s/0/false/ and s/1/true/ where 
the return value is explicit, rather than the result of an expression.

	Jeff


