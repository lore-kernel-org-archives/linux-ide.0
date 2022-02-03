Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B6C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 07:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349373AbiBCH0I (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Feb 2022 02:26:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51926 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbiBCH0H (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2022 02:26:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BAB61F398;
        Thu,  3 Feb 2022 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643873167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RETcHfQpniexvMH04suLrfeBBCwbIIhTkXQ8Zovq/R4=;
        b=qiI3pZMjR/beDnH/TRQm/5gmDVzLrcWHDxRYXgv/5NfrN+taoDBaFU7Osn+YDReO4QqNE8
        ZJxn8F0DMRvbdhXRaexzuSi2N72zwN1yTt8hMbmq3GMQ5VOozGUjFsmKhyeAJXZDN8JiEd
        8PSdubeDRXbcW/k94A71czbtGI6W/go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643873167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RETcHfQpniexvMH04suLrfeBBCwbIIhTkXQ8Zovq/R4=;
        b=wv+4GtmMEDcaN2uVrYM4djCsRV4L/HmxecVwMhFAI1gr1vMzufAco5K+yZtUveF0uuImMM
        Nc23GnHKva00K4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C33D61344A;
        Thu,  3 Feb 2022 07:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r/7VLo6D+2EgdAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 03 Feb 2022 07:26:06 +0000
Message-ID: <8f4e6436-e5a1-201d-6bb7-548ed3abad9c@suse.de>
Date:   Thu, 3 Feb 2022 08:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] libata: make ata_host_suspend() *void*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>
References: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/2/22 21:58, Sergey Shtylyov wrote:
> ata_host_suspend() always returns 0, so the result checks in many drivers
> look pointless.  Let's make this function return *void* instead of *int*.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>   drivers/ata/ahci.c             |    3 ++-
>   drivers/ata/ata_piix.c         |    5 +----
>   drivers/ata/libahci_platform.c |    3 ++-
>   drivers/ata/libata-core.c      |    8 ++------
>   drivers/ata/pata_arasan_cf.c   |    3 ++-
>   drivers/ata/pata_cs5520.c      |    5 +----
>   drivers/ata/pata_imx.c         |   15 ++++++---------
>   drivers/ata/pata_macio.c       |    6 +-----
>   drivers/ata/pata_mpc52xx.c     |    3 ++-
>   drivers/ata/pata_samsung_cf.c  |    3 ++-
>   drivers/ata/pata_triflex.c     |    5 +----
>   drivers/ata/sata_fsl.c         |    4 +++-
>   drivers/ata/sata_highbank.c    |    3 ++-
>   drivers/ata/sata_mv.c          |    6 +++---
>   drivers/ata/sata_rcar.c        |   18 ++++++++----------
>   include/linux/libata.h         |    2 +-
>   16 files changed, 39 insertions(+), 53 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
