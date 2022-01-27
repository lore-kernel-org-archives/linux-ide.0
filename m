Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26B0C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 08:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiA0IFy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 03:05:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55854 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiA0IFx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 03:05:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA4301F882;
        Thu, 27 Jan 2022 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643270751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GehtgcFxue06jZDH1Y45Fvb3dN7uPW3IXTS0CT2Qsxs=;
        b=YL8iaVByzxB+B5RX7JmhU0cc24Al/znJgws+4HaJvJps+2OyJVoNteCPoBT46FWLjA+QQS
        OgoJnOqT7Zjnv+6C/kD1tDZm2UqcXSrrt09IOAuxBvrGuh7RjebBwdXuLjh6LShq4nGOL4
        ezy9fq9syIr1bodwvA6hTEIXcaLRocY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643270751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GehtgcFxue06jZDH1Y45Fvb3dN7uPW3IXTS0CT2Qsxs=;
        b=yH3oKWSdx87HhwkiV9/lhjqEdMacAGDMIWqCGrSfx9oAsQ4VeDPS4e3SZI29ZoPa+NEE9b
        bJU6yQOYllUg4vDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C21A113F69;
        Thu, 27 Jan 2022 08:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lZqsK19S8mEqFwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 08:05:51 +0000
Message-ID: <bd62bcf3-30b6-e7e8-6ccc-fb3c41777b83@suse.de>
Date:   Thu, 27 Jan 2022 09:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] ata: libata-scsi: Simplify scsi_XX_lba_len()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
 <20220127072919.139615-4-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220127072919.139615-4-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/27/22 08:29, Damien Le Moal wrote:
> In scsi_10_lba_len() and scsi_16_lba_len() functions, use
> get_unaligned_bexx() to access a cdb LBA and length fields instead of
> hardcoding the byte retrieval. With these simplification, the functions
> can also be declared inline.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-scsi.c | 40 ++++++---------------------------------
>   1 file changed, 6 insertions(+), 34 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
