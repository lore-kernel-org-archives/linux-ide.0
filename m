Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ECFC77B7D
	for <linux-ide@archiver.kernel.org>; Mon, 15 May 2023 06:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjEOGER (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 May 2023 02:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbjEOGDm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2023 02:03:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08ED4233
        for <linux-ide@vger.kernel.org>; Sun, 14 May 2023 22:56:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9395521D61;
        Mon, 15 May 2023 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684130189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16iYMbWvyXofauuEZ8Q9aqnDqEjKp/10BQVIWrSouMA=;
        b=cA0NTkTT8pLpWUlhw2/8HkOPmrkyF4cbghOTacHc1Ui3ap0CjSPhlI4xN5s2LXyWmlY41l
        1OPlRM/JLM2ZnMqrKGLyXI+xPbSvqo67JaTYi2dZ9a8NyVTvS5VaJ36m08ysattRKcEsxV
        VWOwSEaaxtZSNYZB1OPkqnmnqb3mzVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684130189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16iYMbWvyXofauuEZ8Q9aqnDqEjKp/10BQVIWrSouMA=;
        b=49OcT8E5CGF7LcGZArk3J3QQPTIofHHzUAWzXxPs9z+kjJVtLIduRIi9t6Bvhbms0mt9hm
        e0rS21O8ZE93XyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 715B8138E5;
        Mon, 15 May 2023 05:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZGJxGY3JYWRgZAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 15 May 2023 05:56:29 +0000
Message-ID: <e8cd4b43-66ca-83b2-a165-ca1f7080831a@suse.de>
Date:   Mon, 15 May 2023 07:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] ata: pata_parport: Fix frpw module code indentation
 and style
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20230514220118.114385-1-dlemoal@kernel.org>
 <20230514220118.114385-3-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230514220118.114385-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/15/23 00:01, Damien Le Moal wrote:
> Fix indentation and coding style in the frpw pata parport protocol
> module to suppress smatch warnings such as:
> 
> drivers/ata/pata_parport/frpw.c:234 frpw_test_proto() warn: inconsistent indenting
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305061212.EPgEMLXl-lkp@intel.com/
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/pata_parport/frpw.c | 310 +++++++++++++++++---------------
>   1 file changed, 162 insertions(+), 148 deletions(-)
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

