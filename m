Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A0EC001DC
	for <linux-ide@archiver.kernel.org>; Sun, 23 Jul 2023 22:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGWW4l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 23 Jul 2023 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGWW4l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jul 2023 18:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C691B7
        for <linux-ide@vger.kernel.org>; Sun, 23 Jul 2023 15:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE06B60DFE
        for <linux-ide@vger.kernel.org>; Sun, 23 Jul 2023 22:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CE0C433C7;
        Sun, 23 Jul 2023 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690152999;
        bh=NfhFVYD2Rt3iO1WaZz+OcwodpRSD5mfzqwA+bQ9iJbo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hgAACI6abaRYwAXjZH/PlxLkpnciF36gK7FJ13czZvA4WnGGdVcAAaMIQ4PXPQNBa
         FWWwPKSTshmhJGayQAWuz2Nng4PEgIY1VvhYXKj1/Dm452NQYA3DEIY3hUdV8NG6R6
         kndPkDzzuIY9k1isjgIVJWrvQBxwqf3x8PpfRjMRhriGQMy7a7BJaJsM3TdLfYkLkj
         /ktszrk6YyerkG8sRDqhDBrFxZiPTKGrzURLd3GboRyGRwWXMPtOMI1R8ZFnTKhYbQ
         3aJ7fMpyfBu8doZWJGxHg54bn3ms0n+oqi59eagpmBV0NQuOx8USyjY/F0nJ470miR
         +WyALZ7yLaWMw==
Message-ID: <7f98734b-979e-41b5-2bc0-ab3dabffb3e5@kernel.org>
Date:   Mon, 24 Jul 2023 07:56:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: fix when to fetch sense data for successful commands
To:     Niklas Cassel <nks@flawful.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org
References: <20230723130315.427513-1-nks@flawful.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230723130315.427513-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/23/23 22:03, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The condition to fetch sense data was supposed to be:
> ATA_SENSE set AND either
> 1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
>    ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
>    sense data supported bit is set); or
> 2) Command was non-NCQ and regular sense data reporting is enabled.
> 
> However the check in 2) accidentally had the negation at the wrong place,
> causing it to try to fetch sense data if it was a non-NCQ command _or_
> if regular sense data reporting was _not_ enabled.
> 
> Fix this by removing the extra parentheses that should not be there,
> such that only the correct return (ata_is_ncq()) is negated.
> 
> Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Closes: https://lore.kernel.org/linux-ide/20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local/
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d37ab6087f2f..04db0f2c683a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4938,8 +4938,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>  		if (qc->result_tf.status & ATA_SENSE &&
>  		    ((ata_is_ncq(qc->tf.protocol) &&
>  		      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
> -		     (!(ata_is_ncq(qc->tf.protocol) &&
> -			ata_id_sense_reporting_enabled(dev->id))))) {
> +		     (!ata_is_ncq(qc->tf.protocol) &&

Even though it is not necessary, to be extra clear, it would be nice to have
parenthesis around "!ata_is_ncq(qc->tf.protocol)". I will add that when applying.

> +		      ata_id_sense_reporting_enabled(dev->id)))) {
>  			/*
>  			 * Tell SCSI EH to not overwrite scmd->result even if
>  			 * this command is finished with result SAM_STAT_GOOD.

-- 
Damien Le Moal
Western Digital Research

