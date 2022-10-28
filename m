Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3848DC38A02
	for <linux-ide@archiver.kernel.org>; Fri, 28 Oct 2022 16:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ1Qpa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Oct 2022 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJ1Qp3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2022 12:45:29 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56156DE94
        for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2022 09:45:25 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ooSTt-0005FR-To; Fri, 28 Oct 2022 18:45:17 +0200
Message-ID: <b0538c3e-a77c-86aa-ab00-b439d61aeb56@maciej.szmigiero.name>
Date:   Fri, 28 Oct 2022 18:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, pl-PL
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        linux-ide@vger.kernel.org
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 4/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
In-Reply-To: <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 27.10.2022 09:50, Damien Le Moal wrote:
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

If we are supporting FUA even in the non-NCQ case (at least for writes)
we do *not* need to limit the FUA support to NCQ-supporting drives in
ata_dev_config_fua() anymore.

Having support for ATA_DFLAG_LBA48 and ata_id_has_fua() is enough in
this case.

Limiting the FUA support to NCQ-supporting drives would make sense if NCQ
commands were always used to implement FUA (even with QD set to 1), but
this patch set version does not do that.

Thanks,
Maciej

