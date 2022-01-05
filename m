Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE428C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 07:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbiAEHlc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 02:41:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59286 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiAEHlb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 02:41:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 888C4210F5;
        Wed,  5 Jan 2022 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641368490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kq6HAZSWjLj+d+aBYVsota8Ub+hyvWNeNACorVGZRJA=;
        b=bGN8AcOgJ16lEFE7fPwbSDSZ5Xog2K2v9x8LOX5WfydZCx+xdUFa7QpTUjpocrHzUX1VcT
        B3ZV/wM/kkfj/RRixvDwpMp3Vd7sdYJcLY7V5+Hu5xO9J1DGpf10bpFk84rsvbRRSER898
        jh53/nBSeyeqjr85VmBsb6UJUJNKgOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641368490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kq6HAZSWjLj+d+aBYVsota8Ub+hyvWNeNACorVGZRJA=;
        b=vjfXQy1sfFM/Wxmxf64kQQ5vzyMZzCHB165UUY9FGvWPNVGnsZbRICM4YeC/QevOI/Cmn9
        slyIab9x6XVH7UAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D11313B8F;
        Wed,  5 Jan 2022 07:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4C+jGapL1WFfEgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 05 Jan 2022 07:41:30 +0000
Message-ID: <8cc29e34-2d26-5976-9176-dbeac8d602b3@suse.de>
Date:   Wed, 5 Jan 2022 08:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] libata: sysfs naming option
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220103090939.36238-1-hare@suse.de>
 <e48f13f0-f79a-e8a9-d8c2-cf53657d8072@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <e48f13f0-f79a-e8a9-d8c2-cf53657d8072@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/5/22 07:18, Damien Le Moal wrote:
> On 1/3/22 18:09, Hannes Reinecke wrote:
>> This patch adds a config option ATA_SYSFS_NAMING to align the libata
>> device names in sysfs with those in the kernel message log.
>> It adds a new dummy bus 'ata', which collects all ata device objects
>> like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix to the
>> message log.
>> For consistency the 'ata_dev' name has been changed from 'ata' to 'dev';
>> as this induces a sysfs change the config option is disabled per default.
>>
>> Patch is relative to the 'for-5.17-logging' branch from Damien.
> 
> FYI, I queued the logging series in for-5.17, minus this patch.
> Everything is in for-next too to check that nothing is broken.
> 
> For this patch, as I commented, I think we can keep a backward
> compatible naming using sysfs symlinks. But I am not entirely sure if
> that can work with port-multiplier setups. Let's work on that for the
> next cycle ?
> 
Well, I'm not terribly happy about the current port multiplier 
implementation, either.
Currently they are named 'ataX.Y.0', making them the only ata objects 
with three levels. Personally I would take the PATA master/slave thingie 
as an example, and just increase the last number (such that we would 
have ata1.0, ata1.1, ata1.2 etc).
Reasoning here is that PMP is pretty much an SATA thing, and 'slave' 
drives is a PATA thing. So they'll never clash.

As for the 'ataX.Y' link; that'll require even more sysfs trickery.
Let's see if I can come up with something.
So yeah, let's hold off the patch for now.

First I need to get a PMP cable to test things out :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
