From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Fri, 04 Mar 2011 14:17:12 +0300
Message-ID: <4D70CA38.5000904@ru.mvista.com>
References: <20110304085501.8B331F90E1@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37792 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1CDLSe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 06:18:34 -0500
Received: by bwz15 with SMTP id 15so1958561bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2011 03:18:33 -0800 (PST)
In-Reply-To: <20110304085501.8B331F90E1@ochil.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 04-03-2011 11:55, Hannes Reinecke wrote:

> As per SAT-3 the WWN ID should be included in the VPD page 0x83
> (device identification) emulation.

> Signed-off-by: Hannes Reinecke<hare@suse.de>
[...]

> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 0c4929f..f62463e 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
[...]
> @@ -815,6 +817,13 @@ static inline int ata_id_has_unload(const u16 *id)
>   	return 0;
>   }
>
> +static inline int ata_id_has_wwn(const u16 *id)
> +{
> +	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
> +		return 0;
> +	return id[ATA_ID_CSF_DEFAULT] & (1 << 8);

    Could be compacted to:

	return (id[ATA_ID_CSF_DEFAULT] & 0xC100) == 0x4100;

WBR, Sergei
