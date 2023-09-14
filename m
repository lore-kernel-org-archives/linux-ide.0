Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1795FEDE983
	for <linux-ide@archiver.kernel.org>; Thu, 14 Sep 2023 06:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjINGBT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Sep 2023 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjINGBR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Sep 2023 02:01:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47948DF
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 23:01:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C1C61F74A;
        Thu, 14 Sep 2023 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694671271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/da5NSWSD400nl3GyoaLnkIy3BszzNsshWn5yC8/IsE=;
        b=Nt4m2KIdgpyZNqQTZ9TAx2rs9T7/6SKI+kBZ4NPV6HKoAMWr32Rrkhd8VW9TAJS7RYREXR
        tE2veaFWeIMxPBTJ+9o8M5HkTb3paonUcqZBOZPjPQRX/edxiXK7FxEx/gd8X6GFV2hoAa
        qqYV6glUmwELtddN5WzvS4hF8gS6w/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694671271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/da5NSWSD400nl3GyoaLnkIy3BszzNsshWn5yC8/IsE=;
        b=E/Ea/1boPuoT/93XNdmtgq/2rs8uDbcq7IWzY+E90cbntf8cjtFI30IyfjTyKFh0aSWNLX
        Fe1TjtRgGVPvPcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CC8B13580;
        Thu, 14 Sep 2023 06:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IyfRAKehAmWEWgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Sep 2023 06:01:11 +0000
Message-ID: <9fb73646-ced8-4270-a047-d522d20f95e8@suse.de>
Date:   Thu, 14 Sep 2023 08:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: fetch sense data for successful
 commands iff CDL enabled
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        patenteng <dimitar@daskalov.co.uk>, linux-ide@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20230913150443.1200790-1-nks@flawful.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230913150443.1200790-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/13/23 17:04, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Currently, we fetch sense data for a _successful_ command if either:
> 1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
>     ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
>     sense data supported bit is set); or
> 2) Command was non-NCQ and regular sense data reporting is enabled.
> 
> This means that case 2) will trigger for a non-NCQ command which has
> ATA_SENSE bit set, regardless if CDL is enabled or not.
> 
> This decision was by design. If the device reports that it has sense data
> available, it makes sense to fetch that sense data, since the sk/asc/ascq
> could be important information regardless if CDL is enabled or not.
> 
> However, the fetching of sense data for a successful command is done via
> ATA EH. Considering how intricate the ATA EH is, we really do not want to
> invoke ATA EH unless absolutely needed.
> 
> Before commit 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL
> commands using policy 0xD") we never fetched sense data for successful
> non-NCQ commands.
> 
> In order to not invoke the ATA EH unless absolutely necessary, even if the
> device claims support for sense data reporting, only fetch sense data for
> successful (NCQ and non-NCQ commands) if CDL is supported and enabled.
> 
Errm. We need sense data for zoned devices, do we not?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

