Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A23AC77B75
	for <linux-ide@archiver.kernel.org>; Mon, 15 May 2023 06:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjEOGDw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 May 2023 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjEOGDW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2023 02:03:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B26A47
        for <linux-ide@vger.kernel.org>; Sun, 14 May 2023 22:56:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85BD821D4D;
        Mon, 15 May 2023 05:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684130159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HaW3D4fP2le9mx6aseet94R06MGJz9y4fNI5upmKmrI=;
        b=z+Mj0XH6wnv526GvXWY7b3K6tl0u03ggDGBTcmt0eUFj2w4olEXVKFYMkkBdDga2lhpNYD
        Kpgxih7EKmLRkPN6yIp55DO7C+FZE45j/XkdisWnQbsukRxK+kQ1DWI+6bLPGrSBY4HcfD
        gGm9XEpcNv4uefevFmKAYMGb3rYCWK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684130159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HaW3D4fP2le9mx6aseet94R06MGJz9y4fNI5upmKmrI=;
        b=LpkUjvT/1Y9oOdKvvmFvoHUJwuScidGuUbTp//dzT/VgPSu81+acdiHT11q/Zp0f/NSTVD
        Hkii42IYNqqOFVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 685F2138E5;
        Mon, 15 May 2023 05:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jqxlGG/JYWQiZAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 15 May 2023 05:55:59 +0000
Message-ID: <f0b8f503-d910-d121-71a2-09d3c25d3070@suse.de>
Date:   Mon, 15 May 2023 07:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] ata: pata_parport: Fix bpck module code indentation
 and style
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20230514220118.114385-1-dlemoal@kernel.org>
 <20230514220118.114385-2-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230514220118.114385-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/15/23 00:01, Damien Le Moal wrote:
> Fix indentation and coding style in the bpck pata parport protocol
> module to suppress smatch warnings such as:
> 
> drivers/ata/pata_parport/bpck.c:66 bpck_read_regr() warn: inconsistent indenting
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305021913.nCMzH5Zj-lkp@intel.com/
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/pata_parport/bpck.c | 446 ++++++++++++++++++--------------
>   1 file changed, 256 insertions(+), 190 deletions(-)
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

