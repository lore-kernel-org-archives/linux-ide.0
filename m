Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B3CC77B75
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 06:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjEVGtr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 May 2023 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjEVGtX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2023 02:49:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A7268B
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2023 23:46:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 290BD1FD9C;
        Mon, 22 May 2023 06:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684737979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKUBA7Ztd8dPELAGci3Rin/N//3hdlb7RJhBQTVlnqo=;
        b=hcgU9AQ0ZrP7r7vMlZAnfgRwRjOWqFGdpKPn7NT6/A6pdcPQo2UBKMbIWJ7slXUpkXCOGx
        hVy5EkyVegZgvDM2M3yz7muwRSb8G8v87VZH+xGi82DedOcQwUm1SkRYriev7jkOs+Rd0w
        91t01oRdE06cQL3MOR9Cn2T1LahFsvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684737979;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKUBA7Ztd8dPELAGci3Rin/N//3hdlb7RJhBQTVlnqo=;
        b=p/RG3MTGYZexSCKez2F9Y/l9tpVs5v16GwM6vmIxzRvSffateZZKQniU2Zu3NklqajqBDe
        xIObeab9MNaWtSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBAC013336;
        Mon, 22 May 2023 06:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pkGjOLoPa2QuHgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 22 May 2023 06:46:18 +0000
Message-ID: <9db022f9-8f5d-fd79-9970-8a515ed4c37b@suse.de>
Date:   Mon, 22 May 2023 08:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/6] libata: remove references to 'old' error handler
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
References: <20230510225211.111113-1-hare@suse.de>
 <a8083851-dc1e-25bd-9790-2c5f8a851c02@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <a8083851-dc1e-25bd-9790-2c5f8a851c02@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/22/23 02:46, Damien Le Moal wrote:
> On 5/11/23 07:52, Hannes Reinecke wrote:
>> Hi all,
>>
>> now that the ipr driver has been modified to not hook into libata
>> all drivers now use the 'new' error handler, so we can remove any
>> references to it. And do a general cleanup to remove callbacks
>> which are no longer needed.
> 
> Hannes,
> 
> Are you sending a v2 to address the comments ?
> 
Sure. Just catching up wfter yet another week of conference.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

