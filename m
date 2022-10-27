Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101E9C38A2D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 09:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiJ0JZ7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiJ0JZp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 05:25:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF172DAAC
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 02:25:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C333227AE;
        Thu, 27 Oct 2022 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666862741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpRm5qEV9Npuls0yuyKNRfoZHsQbsAqb1MRUCROH5nU=;
        b=woZDMsSKvU4dA1Vd7qvwxTKt9wHE98Yr8HPgT/dnNDWYyO2njj0Ff2WDf6rusiuKyJ3AgX
        QSi8gu5arqGI60j1KzeyW++ySiARRqeWHTH62YNT7M2Go8CyFVy9Is0lw2+xoupg8GjedN
        gUtBOwMnw5KRVOhW2GtXRifbBco8W+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666862741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpRm5qEV9Npuls0yuyKNRfoZHsQbsAqb1MRUCROH5nU=;
        b=gvaNmqLG2Emke8VsLffc+L5yMEgLnTZlMSDImJGKige3hRmbTuxCjTQoODWhsS6/P2ZVEL
        TwBU93ubPO++8TCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6218413357;
        Thu, 27 Oct 2022 09:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ozk7FpVOWmN0XgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Oct 2022 09:25:41 +0000
Message-ID: <ff051640-b330-fb1d-a9e8-f4a4d8b0a801@suse.de>
Date:   Thu, 27 Oct 2022 11:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/6] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-3-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221027075026.240017-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/27/22 09:50, Damien Le Moal wrote:
> Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
> reflect the fact that this function sets a task file command and
> protocol. The arguments order is also reversed and the function return
> type changed to a bool to indicate if the command and protocol were set
> corretly (instead of returning a completely arbitrary "-1" value.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-core.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
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

