Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E61C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiADLvL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:51:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53412 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiADLvL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:51:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39B0F212B9;
        Tue,  4 Jan 2022 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641297070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nifTvpwRfjDX98MbYogBT6xTCM9WgV+YGQikEl+SX78=;
        b=QWecZ545x5TGs3htadeSqGQ287JKCvsues1RzSllc4DfLtLfJyPveOJ8zm4Ie/fNyqlrvh
        vh/xWH3QeV0R20bKXmX6iI1EKJeultoPXj+9M2tQUfoD2RLv0XOjHg/iwV01hAqvisAThO
        TFVz57webYwBZzlgB024O3gsw6BqSPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641297070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nifTvpwRfjDX98MbYogBT6xTCM9WgV+YGQikEl+SX78=;
        b=RlglnVWTtDCe0YxkcsY3lKF6djHgSYldBvh1Xt0/e3xYmjwGKO/NQ134kSvvM2LH+1P8BX
        mqD5TssVLd8ey5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30E3513AF4;
        Tue,  4 Jan 2022 11:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2ZEwC6401GGuRAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:51:10 +0000
Subject: Re: [PATCH v2 22/22] ata: ahci_xgene: Fix id array access in
 xgene_ahci_read_id()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-23-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <88f71464-135d-7cae-287d-8961eff37333@suse.de>
Date:   Tue, 4 Jan 2022 12:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-23-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> ATA IDENTIFY command returns an array of le16 words. Accessing it as a
> u16 array triggers the following sparse warning:
> 
> drivers/ata/ahci_xgene.c:262:33: warning: invalid assignment: &=
> drivers/ata/ahci_xgene.c:262:33:    left side has type unsigned short
> drivers/ata/ahci_xgene.c:262:33:    right side has type restricted __le16
> 
> Use a local variable to explicitly cast the id array to __le16 to avoid
> this warning.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/ahci_xgene.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 68ec7e9430b2..d5075d0f8cb1 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -239,6 +239,7 @@ static bool xgene_ahci_is_memram_inited(struct xgene_ahci_context *ctx)
>  static unsigned int xgene_ahci_read_id(struct ata_device *dev,
>  				       struct ata_taskfile *tf, u16 *id)
>  {
> +	__le16 *__id = (__le16 *)id;
>  	u32 err_mask;
>  
>  	err_mask = ata_do_dev_read_id(dev, tf, id);
> @@ -259,7 +260,7 @@ static unsigned int xgene_ahci_read_id(struct ata_device *dev,
>  	 *
>  	 * Clear reserved bit 8 (DEVSLP bit) as we don't support DEVSLP
>  	 */
> -	id[ATA_ID_FEATURE_SUPP] &= cpu_to_le16(~(1 << 8));
> +	__id[ATA_ID_FEATURE_SUPP] &= cpu_to_le16(~(1 << 8));
>  
>  	return 0;
>  }
> 
Hmm. I would think that the 'id' argument is wrong; it really should be
'__le16 *', as it only gets converted later on with the call to
swap_buf_le16(id, ATA_ID_WORDS) in
drivers/ata/libata-core.c:ata_dev_read_id(). So when this function is
called the argument really _is_ __le16, only the declaration doesn't
tell us.

Maybe one should rather fix this?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
