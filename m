Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52FC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhLIIXl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:23:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58106 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbhLIIXj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:23:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EB931FCA3;
        Thu,  9 Dec 2021 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639038006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rb/m0Ra3zud7jrbpRMNDYOhrYShvl4yjODNowQYi8WE=;
        b=A6Ll8SbCnyGR9UtIa2r4VXY1NMEiZcKD+MsSORc4Fv+MGYjrjXYBjRp2a+h9JA496/D97n
        klXYRC0dhJOmNI7HEzwGVlNuI/od9g77nmzhUGxliH81j56k2jHtztzWeYDBFLu5HSX3Bj
        tCi30dA3gCD2MYD361yRkczdNxbPysY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639038006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rb/m0Ra3zud7jrbpRMNDYOhrYShvl4yjODNowQYi8WE=;
        b=U67Qk+a08aU0sATXV/TJ/HjPSMt4w4p6sbg6E8q9SrWsWNhCIta+FU4cLNIIkmkEq0Fm/3
        epIBJwd7qNK+QgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07C4B13CBE;
        Thu,  9 Dec 2021 08:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7sI8ATa8sWGGRgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 09 Dec 2021 08:20:06 +0000
Subject: Re: [PATCH 10/73] libata: drop debugging statements for bus-master
 DMA
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-11-hare@suse.de>
 <19a676ed-da38-d058-f7d2-fee566aa1e95@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <645a724d-c83d-7a17-e70d-6240ca85c9f0@suse.de>
Date:   Thu, 9 Dec 2021 09:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <19a676ed-da38-d058-f7d2-fee566aa1e95@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/21 1:46 AM, Damien Le Moal wrote:
> On 2021/12/09 1:31, Hannes Reinecke wrote:
>> Bus-master DMA is now logged with generic tracepoints, so we can
>> drop the DPRINTK()/VPRINTK and dev_dbg() calls here.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Wouldn't it be better to merge this in the previous patch ?
> 
Sure, can do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
