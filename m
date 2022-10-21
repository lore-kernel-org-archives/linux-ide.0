Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B97C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 06:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJUGUQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUGUQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 02:20:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5E106E13
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 23:20:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB8DF1F8D4;
        Fri, 21 Oct 2022 06:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666333212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9yjIDpXIsqkEajz7xr5E03nA0SSXCRq6PYH85mJK7U=;
        b=VTnVJgKCjELXbM8bD7fbWPk1TlOiRNg7REDUlWsuMW87QzrVXCXTSbHAh7J3MCj9j75s9P
        xFRh6OV9eFwFYyDU/P81oEi6aqamJYzetZpCdTXBfV+ChP6vwNdz7LdgNY1bNb6C9lhfoA
        82Cl9uqECnpQUytYJjDewsDZJX0IMjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666333212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9yjIDpXIsqkEajz7xr5E03nA0SSXCRq6PYH85mJK7U=;
        b=W5at3wJi8B/MOxIEdF9YgWN/ltNSdh61gcwA7uuWnMGqweLeSheyp0CIVSpRtsqBC2+fus
        Kh5cHks3EMCKqHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A53EB1331A;
        Fri, 21 Oct 2022 06:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bKyNJxw6UmMQDwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:20:12 +0000
Message-ID: <edb02b76-38bd-668a-a2a5-cd6537346735@suse.de>
Date:   Fri, 21 Oct 2022 08:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] ata: libata: cleanup fua handling
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <20221021053809.237651-2-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221021053809.237651-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/21/22 07:38, Damien Le Moal wrote:
> Move the detection of a device FUA support from
> ata_scsiop_mode_sense()/ata_dev_supports_fua() to device scan time in
> ata_dev_configure().
> 
> The function ata_dev_config_fua() is introduced to detect a device FUA
> support and this support is indicated using the new device flag
> ATA_DFLAG_FUA. In order to blacklist known buggy devices, the horkage
> flag ATA_HORKAGE_NO_FUA is introduced. Similarly to other horkage flags,
> the arguments fua and nofua are also introduced to allow a user to
> control this horkage flag through the "force" libata module parameter.
> 
> The ATA_DFLAG_FUA device flag is set only and only if all the following
> conditions are met:
> * libata.fua module parameter is set to 1
> * The device is not marked with the ATA_HORKAGE_NO_FUA flag, either from
>    the blacklist or set by the user with libata.force=nofua
> * The device advertizes support for the WRITE DMA FUA EXT command,
> * The device supports LBA48 and is not restricted to single block PIO
> 
> Note: Enabling or diabling libata fua support for all devices by default
> can now by done using either the "fua" module parameter or the
> "force=[port[.device]][no]fua" module parameter when libata.fua==1.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  3 ++
>   drivers/ata/libata-core.c                     | 29 +++++++++++++++++-
>   drivers/ata/libata-scsi.c                     | 30 ++-----------------
>   include/linux/libata.h                        |  8 +++--
>   4 files changed, 38 insertions(+), 32 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

