Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E3EC7EE24
	for <linux-ide@archiver.kernel.org>; Mon,  5 Jun 2023 15:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjFEPOS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 5 Jun 2023 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjFEPN2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jun 2023 11:13:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140D610EF
        for <linux-ide@vger.kernel.org>; Mon,  5 Jun 2023 08:12:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7F2C21B73;
        Mon,  5 Jun 2023 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685977946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0BQyrXJM6aiH4fKwGBP5GtTZ49th4zGOwNwwI4KJBQ=;
        b=zha2sypCU6nDZ3ptnE8jfmMZz3G1C4JLKSm4MzvJwIzVmqepkHnz/t6CHLGjO54HGos2dv
        zmVh+yb8DrmgLwEVaSH8lHBntBJP7pbL3S+YdwGZifAGSXCYfA2mID3AelfFJa2ZRE42uo
        +c8LmMJvoQxenrpXDpOMtXLW46ANfac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685977946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0BQyrXJM6aiH4fKwGBP5GtTZ49th4zGOwNwwI4KJBQ=;
        b=JAy2vFLYNuSLjvCx5icFQwfzZQZdzsaMvn+RyDtswY7/BDi/dAP8GF7e/0lbj/gQMsdHfq
        fBYOSZlOijbW1uCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A17E4139C8;
        Mon,  5 Jun 2023 15:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p01JJlr7fWT1bAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 05 Jun 2023 15:12:26 +0000
Message-ID: <30256648-d329-c3f7-a4b0-37d5fa49bdab@suse.de>
Date:   Mon, 5 Jun 2023 17:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/6] libata: remove references to 'old' error handler
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20230510225211.111113-1-hare@suse.de>
 <a8083851-dc1e-25bd-9790-2c5f8a851c02@kernel.org>
 <9db022f9-8f5d-fd79-9970-8a515ed4c37b@suse.de> <ZH3uZZ/Gqi6HqEwU@x1-carbon>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZH3uZZ/Gqi6HqEwU@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/5/23 16:43, Niklas Cassel wrote:
> On Mon, May 22, 2023 at 08:46:18AM +0200, Hannes Reinecke wrote:
>> On 5/22/23 02:46, Damien Le Moal wrote:
>>> On 5/11/23 07:52, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> now that the ipr driver has been modified to not hook into libata
>>>> all drivers now use the 'new' error handler, so we can remove any
>>>> references to it. And do a general cleanup to remove callbacks
>>>> which are no longer needed.
>>>
>>> Hannes,
>>>
>>> Are you sending a v2 to address the comments ?
>>>
>> Sure. Just catching up wfter yet another week of conference.
> 
> Hello Hannes,
> 
> Are you planning on sending a V2?
> 
> It would be nice for the series to cook in linux-next for the customary
> 2+ weeks before being sent to Linus, especially considering the kernel
> test robot regression report.
> 
> I assume that the regression report is related to the review comment
> that I gave, i.e. that ata_dump_status() is now called unconditionally:
> 
>           %stddev     %change         %stddev
> pp.vprintk_emit._printk.ata_dump_status.ata_scsi_qc_complete.ata_qc_complete_multiple
>        0.00           +22.4       22.41 ±  8%  perf-profile.calltrace.cycles-
> 
> 
Ah, right. Yes, will be resending.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

