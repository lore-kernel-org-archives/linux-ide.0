Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E4AC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiADLph (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:45:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52890 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiADLph (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:45:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A747212BC;
        Tue,  4 Jan 2022 11:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641296736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxlML54io5ylTt9OcXqxWGVv66doHYMvZoMosPrvVaM=;
        b=CS1jZRWmBqxAVgxFGacc3GKmIhdtmOQMMVGS6bOlkwXh2s7EBkkWlQkiCYky/OQZVHfH1N
        m+lzVa1EPKoDtXEjufkFRzhqV6KNHaiSHXrHVjX0kBnO2bNRyHz8pP767rjbmdBsUslY+y
        nFDCjj8uRO7BOy9tI8u47W7C2VvMYRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641296736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxlML54io5ylTt9OcXqxWGVv66doHYMvZoMosPrvVaM=;
        b=q0hnY339/ByYQWX8xWtdlXhdC+UGQ0vCbbXJc7MlX4NoBEmStq7K1kXFpSX+1pZJjWzJ4D
        O2wHFHGo/xX96LAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31E3913AF4;
        Tue,  4 Jan 2022 11:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vU/2C2Az1GHqQQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:45:36 +0000
Subject: Re: [PATCH v2 20/22] ata: sata_fsl: fix cmdhdr_tbl_entry and prde
 struct definitions
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-21-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <345fa64f-a5a8-d6ff-8bf3-e3cd38c53445@suse.de>
Date:   Tue, 4 Jan 2022 12:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-21-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> The fields of the cmdhdr_tbl_entry structure all store __le32 values,
> and so are the dba and ddc_and_ext fields of the prde structure. Define
> these fields using the __le32 type to avoid sparse warnings about
> incorrect type in assignment.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/sata_fsl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 101d4dd79f62..13d532193405 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -221,10 +221,10 @@ enum {
>   * 4 Dwords per command slot, command header size ==  64 Dwords.
>   */
>  struct cmdhdr_tbl_entry {
> -	u32 cda;
> -	u32 prde_fis_len;
> -	u32 ttl;
> -	u32 desc_info;
> +	__le32 cda;
> +	__le32 prde_fis_len;
> +	__le32 ttl;
> +	__le32 desc_info;
>  };
>  
>  /*
> @@ -259,9 +259,9 @@ struct command_desc {
>   */
>  
>  struct prde {
> -	u32 dba;
> +	__le32 dba;
>  	u8 fill[2 * 4];
> -	u32 ddc_and_ext;
> +	__le32 ddc_and_ext;
>  };
>  
>  /*
> 
... which means that _technically_ we should modify the log message in
sata_fsl_setup_cmd_hdr_entry() to use le32_to_cpu(), too, to avoid
garbled numbers on big endian. Or maybe not, if we argue that we want
to print out the values as sent to the HW.

Anyway.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
