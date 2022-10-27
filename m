Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5270C38A2D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 09:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiJ0JdN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiJ0Jcp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 05:32:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7531219
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 02:32:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2ADA4227AE;
        Thu, 27 Oct 2022 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666863139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HblLZCnnz0ZTZGwwsJtpMaBATm0Cfp4o0UrN36xEw08=;
        b=M7G4r9+LmHfQq4GznzHxlNPuAGhN6ukdiLoPiROwiWa1bTqBtzasos6gbetr6+gxg/qjS+
        ZLenk+zbcNaGDxzPBDZFFLxliA0MbpvUsbHXQAIyZR63kHZWhx1L3yf8mnHi7O/oZi7CP0
        24dG9UpZRttR5ix91shKETbgAwDULgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666863139;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HblLZCnnz0ZTZGwwsJtpMaBATm0Cfp4o0UrN36xEw08=;
        b=Fsa0n5E+kBypVXTSQV5c1dkHIWSzyr5XJ8qDxV6FZvzMtHN9CyrFSb8KWotnVrNrSijZ3N
        MRLCfGeQA2KevpDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB0A213357;
        Thu, 27 Oct 2022 09:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zd0aLiJQWmMPYgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Oct 2022 09:32:18 +0000
Message-ID: <9559f516-eb6b-1be5-15a4-92706d56a586@suse.de>
Date:   Thu, 27 Oct 2022 11:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 3/6] ata: libata: cleanup fua handling
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-4-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221027075026.240017-4-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/27/22 09:50, Damien Le Moal wrote:
> Move the detection of a device FUA support from
> ata_scsiop_mode_sense()/ata_dev_supports_fua() to device scan time in
> ata_dev_configure().
> 
> The function ata_dev_config_fua() is introduced to detect a device FUA
> support and this support is indicated using the new device flag

'detect a device FUA support'?
maybe 'to detect if a device supports FUA'?

> ATA_DFLAG_FUA. In order to blacklist known buggy devices, the horkage
> flag ATA_HORKAGE_NO_FUA is introduced. Similarly to other horkage flags,
> the libata.force= arguments "fua" and "nofua" are also introduced to
> allow a user to control this horkage flag through the "force" libata
> module parameter.
> 
> The ATA_DFLAG_FUA device flag is set only and only if all the following
> conditions are met:
> * libata.fua module parameter is set to 1
> * The device advertizes support for the WRITE DMA FUA EXT command,
> * The device is not marked with the ATA_HORKAGE_NO_FUA flag, either from
>    the blacklist or set by the user with libata.force=nofua
> * The device supports NCQ (while this is not mandated by the standards,
>    this restriction is introduced to avoid problems with older non-NCQ
>    devices).
> 
> Note: Enabling or diabling libata fua support for all devices by default
> can now by done using either the "fua" module parameter or the
> "force=[port[.device]][no]fua" module parameter when libata.fua==1.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  3 ++
>   drivers/ata/libata-core.c                     | 30 ++++++++++++++++++-
>   drivers/ata/libata-scsi.c                     | 30 ++-----------------
>   include/linux/libata.h                        |  8 +++--
>   4 files changed, 39 insertions(+), 32 deletions(-)
> Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

