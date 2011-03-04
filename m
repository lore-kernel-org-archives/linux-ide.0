From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Fri, 4 Mar 2011 18:09:04 +0100
Message-ID: <20110304170904.GW20499@htj.dyndns.org>
References: <20110304085501.8B331F90E1@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54981 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759404Ab1CDRJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 12:09:11 -0500
Received: by bwz15 with SMTP id 15so2227746bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2011 09:09:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110304085501.8B331F90E1@ochil.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Hannes.

On Fri, Mar 04, 2011 at 09:55:01AM +0100, Hannes Reinecke wrote:
> +static inline int ata_id_has_wwn(const u16 *id)
> +{
> +	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
> +		return 0;
> +	return id[ATA_ID_CSF_DEFAULT] & (1 << 8);
> +}

Can you please make this return bool?  Otherwise,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
