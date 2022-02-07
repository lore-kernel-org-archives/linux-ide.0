Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969EC41535
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 07:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiBGHQP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbiBGG7Q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 01:59:16 -0500
X-Greylist: delayed 480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:58:57 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0DC043185
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 22:58:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE1151F37E;
        Mon,  7 Feb 2022 06:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644216655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vtf7Eucp3dMH4ju9GZSnc/FCcicNZ1PceO2X2vFlBs=;
        b=zEOX34exUNS2Qwvqxoc0ehpV8m1XdZMJp6A13BVRWdCDQbk9FZxwIo+yB9tzlmHlo+5VNR
        AIBHYfoprcBes2hNbwq/UprMSazjTrvmCajHPx3xyyqrZE+Tg/Iw+uly4AGo2DSEl8ql1B
        cDPsmyPB9THy9TZQRayynUvj/EUcx5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644216655;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vtf7Eucp3dMH4ju9GZSnc/FCcicNZ1PceO2X2vFlBs=;
        b=r2TApO4n5s3T//ctqXZnwvtlq6CGkcNorvFteDJ74HoucNJK8K3xe96Gio1wWJ4FHBN/35
        oezEbPYMMIkCkhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCED313519;
        Mon,  7 Feb 2022 06:50:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7hbhL0/BAGJWVQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Feb 2022 06:50:55 +0000
Message-ID: <e07372be-3bb5-ad24-1014-2f4d9f59dc62@suse.de>
Date:   Mon, 7 Feb 2022 07:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: libata-core: Fix ata_dev_config_cpr()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220207031616.944994-1-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220207031616.944994-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/7/22 04:16, Damien Le Moal wrote:
> The concurrent positioning ranges log page 47h is a general purpose log
> page and not a subpage of the indentify device log. Using
> ata_identify_page_supported() to test for concurrent positioning ranges
> support is thus wrong. ata_log_supported() must be used.
> This invalid test created boot problems for several users in the field.
> 
> While at it, strengthen the detection for concurrent positioning ranges
> support by limiting the detection to drives implementing a recent ATA
> standard, that is, ACS-4 (major version 11) or later ACS versions. This
> additional condition effectively turns ata_dev_config_cpr() into a nop,
> avoiding problems in the field with older drives.
> 
> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215519
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-core.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
