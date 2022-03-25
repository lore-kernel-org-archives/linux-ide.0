Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E8C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 07:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355334AbiCYHOZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Mar 2022 03:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355505AbiCYHOY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2022 03:14:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6CC7498
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2022 00:12:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2703210DE;
        Fri, 25 Mar 2022 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648192369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUiMMn5a21vI65rOFUYa5jlUrJR4rfkXVs8Q6WmrjbY=;
        b=I6J730dPGxHZdG4ytoEG4Q8TnJMvVdOmd7Oe6F8VxpjQtaeNv6iIkhcLNBWES4JIK35jA+
        jMj/jwBAtQcO9nCZJ80rTyAxXPZGr6BWHaESEWriT4gnKVy/64tNiomjaYtQTTYEim2ZBg
        p4KSbmX6x5nqGtJ9Sn2KBrsZP+CYGjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648192369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUiMMn5a21vI65rOFUYa5jlUrJR4rfkXVs8Q6WmrjbY=;
        b=Wow0nTlFu6DHmw+YaRBnY5oV6pbqeAQV4a7Oj7WrHq4YTs2s3VvZ5grlgSsH1bQdjcG/Ln
        v75T2eCpsappXkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97811132E9;
        Fri, 25 Mar 2022 07:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lmJYI3FrPWJJTQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 25 Mar 2022 07:12:49 +0000
Message-ID: <14a82e42-bf46-05fe-0e32-c6d5a3fd0e81@suse.de>
Date:   Fri, 25 Mar 2022 08:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] libata: CONFIG_ATA_SYSFS_COMPAT
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220324123204.61534-1-hare@suse.de>
 <20220324123204.61534-3-hare@suse.de>
 <e1e36f35-deee-1ec5-732b-575a68579610@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <e1e36f35-deee-1ec5-732b-575a68579610@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/22 04:01, Damien Le Moal wrote:
> On 3/24/22 21:32, Hannes Reinecke wrote:
>> Add a config option 'ATA_SYSFS_COMPAT' to create a compability
> 
> s/compability/compatibility
> 
>> 'ata' symlink in the PCI device sysfs directory.
> 
> I am not yet convinced if this new config option is really necessary... 
> We could create the symlink unconditionally, no ?
> 
We could, but why?
The sole point of the compat symlink is to preserve compability with 
previous releases. But we don't really know if this compatility really 
is required; I haven't seen any difference in behaviour with or without 
the symlinks.
By having a config option we make it clear that the symlinks will 
eventually vanish.

> In any case, I would like to at least reduce the number of #ifdef. So 
> what about something like this on top of your patch:
> 
Sure. Will be doing so in the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
