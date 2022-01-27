Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B15DC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 08:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiA0IFd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 03:05:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55220 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiA0IFc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 03:05:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAE9821997;
        Thu, 27 Jan 2022 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643270731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tz21vtcyyJOZEi78a+zRtbopsKtusbtBTIrg1Ujo9Ag=;
        b=ZkP94rr7W7GmqUKaakRws82pUOgtZivYuIOk3kU96WyCbAozOAZ/d86LmXMAQaZVunUZ6Z
        YaBF0ne5bWWKWg77s9OIX1vQkv1EK7kZZ7MGTG4PkovRh8pBII9JzW2MWDuEVmGZ1/kATS
        q+aYbxX6vxLUGcPMqweL08Esy4HsEaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643270731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tz21vtcyyJOZEi78a+zRtbopsKtusbtBTIrg1Ujo9Ag=;
        b=KOhw106zGbniIkF+OFTwEWR2ASb/hF4sYt8L24yFwX/X//C1SjesC6PgoKW6xtsqw5qPx7
        pYX+sncFT8MwW/CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFB8713F69;
        Thu, 27 Jan 2022 08:05:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QVOqLUtS8mHoFgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 08:05:31 +0000
Message-ID: <1b708271-50ad-b825-be37-a2560dddc7e5@suse.de>
Date:   Thu, 27 Jan 2022 09:05:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] ata: libata-scsi: Simplify
 ata_scsi_mode_select_xlat()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
 <20220127072919.139615-3-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220127072919.139615-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/27/22 08:29, Damien Le Moal wrote:
> Use get_unaligned_be16() instead of using hardcoded accesses to
> 16-bits big endian cdb fields.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-scsi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
