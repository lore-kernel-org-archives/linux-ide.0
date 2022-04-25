Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3FDC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 05:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiDYFwq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Apr 2022 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiDYFwn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2022 01:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641A1FA4C;
        Sun, 24 Apr 2022 22:49:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C32C1F37D;
        Mon, 25 Apr 2022 05:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650865778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BABhl2XwAoC64ONJb1Rw9tKPDgyB/LZZFBh4Q1jN/Bo=;
        b=kCIUHuV3XyWPmCcdr6o5W94uaulbpdC2U1RZqAB7MGIdSD24kKI0hSMz6hnRzdeMvJGeK7
        icI/yE6B+HIs1mslAQTsnyzqPGNYsbFlKbgqJxRmnEHStwkp2PDXo7ysBNEJP+kumR8G+q
        n9hxjmHQmHM2bYjfTty013HJefl0vr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650865778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BABhl2XwAoC64ONJb1Rw9tKPDgyB/LZZFBh4Q1jN/Bo=;
        b=8HZ5lYYlsMviAf3ygK/BRlYhqmMWFlZWzvy0uOVbILCmWy4eeZUIzTV64O/GZAMVsQ4tNe
        wsyz39Aw2GQrQ+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C4BA13780;
        Mon, 25 Apr 2022 05:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IZ/9NXE2ZmJDRAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 05:49:37 +0000
Message-ID: <f9692268-1fdb-4144-b354-7064611896b0@suse.de>
Date:   Mon, 25 Apr 2022 07:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/5] ata: libata-core: cleanup ata_device_blacklist
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
 <20220425013417.3947791-2-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220425013417.3947791-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/22 03:34, Damien Le Moal wrote:
> Remove the unneeded comma after the last field of the array entries.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>   drivers/ata/libata-core.c | 96 +++++++++++++++++++--------------------
>   1 file changed, 48 insertions(+), 48 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
