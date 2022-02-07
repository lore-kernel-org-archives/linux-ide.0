Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2558FC4167D
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 08:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiBGIHP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347530AbiBGH5g (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 02:57:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39387C043184
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 23:57:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5D2C210E7;
        Mon,  7 Feb 2022 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644220654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Oa6rIKUhEgK1zgTOTZYy6RaoDq0OkN2Ulz+v6vUgm8=;
        b=qCVx5Sl4WlhCAXi9HpcJC4lIlumrSSTV7nVlil4LS3dcAz3bzqVKH7/hLYAkqmRbKPMXf2
        x/M3yam0csUiIwci7AutHhI8lNUhOeR0rNFwohxcVKbCM+BerT+tFuc3rageLpoIL/W5Bj
        j+WIzPnoFTR7hbQ3IpI7ov5Gunx/P30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644220654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Oa6rIKUhEgK1zgTOTZYy6RaoDq0OkN2Ulz+v6vUgm8=;
        b=GMPU8m2jq3Cl8Ta1K3XGpsekYb9jCv07bXoExFJhODSllw9v8CE9IK7Lq8jX4apVGpynRc
        0tbZyyq5MpgeGYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D514913ABC;
        Mon,  7 Feb 2022 07:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DYxMM+7QAGLvawAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Feb 2022 07:57:34 +0000
Message-ID: <b550fbed-f154-6006-2658-aa22e32027fc@suse.de>
Date:   Mon, 7 Feb 2022 08:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: libata-core: Fix ata_dev_config_cpr()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220207031616.944994-1-damien.lemoal@opensource.wdc.com>
 <e07372be-3bb5-ad24-1014-2f4d9f59dc62@suse.de>
 <28712d9a-f2d7-7c75-5a85-0e243cfb1f5d@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <28712d9a-f2d7-7c75-5a85-0e243cfb1f5d@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/7/22 08:02, Damien Le Moal wrote:
> On 2/7/22 15:50, Hannes Reinecke wrote:
>> On 2/7/22 04:16, Damien Le Moal wrote:
>>> The concurrent positioning ranges log page 47h is a general purpose log
>>> page and not a subpage of the indentify device log. Using
>>> ata_identify_page_supported() to test for concurrent positioning ranges
>>> support is thus wrong. ata_log_supported() must be used.
>>> This invalid test created boot problems for several users in the field.
>>>
>>> While at it, strengthen the detection for concurrent positioning ranges
>>> support by limiting the detection to drives implementing a recent ATA
>>> standard, that is, ACS-4 (major version 11) or later ACS versions. This
>>> additional condition effectively turns ata_dev_config_cpr() into a nop,
>>> avoiding problems in the field with older drives.
>>>
>>> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215519
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> ---
>>>    drivers/ata/libata-core.c | 19 ++++++++++---------
>>>    1 file changed, 10 insertions(+), 9 deletions(-)
>>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Thanks, but I sent a v3 with an update to include/linux/ata.h. Review OK
> on that one ?
> 
Yep.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
