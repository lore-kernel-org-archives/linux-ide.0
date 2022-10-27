Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11BDC38A2D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 09:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiJ0Jmy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiJ0Jmx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 05:42:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480DC5F72
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 02:42:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 914761FD9E;
        Thu, 27 Oct 2022 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666863771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0M73oisHVsa3Ya1/sMKT/z9kqF9GtHB+q0ehUlMgmM=;
        b=cXR+EZA8WuxRYqwGoJ9hmlUGREfn9k4wznIsGBtoJ7uEu7oOKmWa8cw8umO4+v4BPu8Lko
        CmqAM+iZk68fPSJWJaimXc0s4uzeqlflBfyOPUmA0IAwoAS6BCbjSpKqWpeF+jC47GcOZ8
        ok7yjzKaW0WFLiKhoYxkXu6LEz3OytQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666863771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0M73oisHVsa3Ya1/sMKT/z9kqF9GtHB+q0ehUlMgmM=;
        b=vZa4D7nRxYCWeuOmQHukGdvQsMcm3Qh1P0z3V9o8sn1QV0jntSinEXElcauA9lS2wrdkZ9
        2weFHFFffySyS9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64C0A13357;
        Thu, 27 Oct 2022 09:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XviVFptSWmN3ZwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Oct 2022 09:42:51 +0000
Message-ID: <69b5067c-dd13-a56a-3267-867902953045@suse.de>
Date:   Thu, 27 Oct 2022 11:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 4/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/27/22 09:50, Damien Le Moal wrote:
> If a user issues a write command with the FUA bit set for a device with
> NCQ support disabled (that is, the device queue depth was set to 1), the
> LBA 48 command WRITE DMA FUA EXT must be used. However,
> ata_build_rw_tf() ignores this and first test if LBA 28 can be used.
> That is, for small FUA writes at low LBAs, ata_rwcmd_protocol() will
> cause the write to fail.
> 
> Fix this by preventing the use of LBA 28 for any FUA write request.
> While at it, also early test if the request is a FUA read and fail these
> requests for the NCQ-disabled case instead of relying on
> ata_rwcmd_protocol() returning an error.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-core.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 81b20ffb1554..fea06f41f371 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -725,9 +725,21 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_block,
>   		    class == IOPRIO_CLASS_RT)
>   			tf->hob_nsect |= ATA_PRIO_HIGH << ATA_SHIFT_PRIO;
>   	} else if (dev->flags & ATA_DFLAG_LBA) {
> +		bool lba28_ok;
> +
> +		if (tf->flags & ATA_TFLAG_FUA) {
> +			/* FUA reads are not defined */
> +			if (!(tf->flags & ATA_TFLAG_WRITE))
> +				return -EINVAL;
> +			/* We need LBA48 / WRITE DMA FUA EXT for FUA writes */
> +			lba28_ok = false;
> +		} else {
> +			lba28_ok = lba_28_ok(block, n_block);
> +		}
> +
>   		tf->flags |= ATA_TFLAG_LBA;
>   
> -		if (lba_28_ok(block, n_block)) {
> +		if (lba28_ok) {
>   			/* use LBA28 */
>   			tf->device |= (block >> 24) & 0xf;
>   		} else if (lba_48_ok(block, n_block)) {

I am still skeptical about this change.
Having checked the code I don't think that we ever issue a 
REQ_READ|REQ_FUA; but at the same time there doesn't seem to be a strict 
rule. I wonder if we shouldn't move that check into the block layer, and 
error out any attempts to issue such?

Otherwise we would error out an otherwise fine I/O (which we _could_ 
have handled via PREFLUSH etc semantics), which I don't think is a good 
idea.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

