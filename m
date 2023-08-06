Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C34C001DE
	for <linux-ide@archiver.kernel.org>; Sun,  6 Aug 2023 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjHFJsJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Aug 2023 05:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJsI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Aug 2023 05:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C981B3
        for <linux-ide@vger.kernel.org>; Sun,  6 Aug 2023 02:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6308661006
        for <linux-ide@vger.kernel.org>; Sun,  6 Aug 2023 09:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E50EC433C7;
        Sun,  6 Aug 2023 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691315285;
        bh=Dq9rnBsGI6boW4InPrw6hhQDa/1vklsblq48VttsSGo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=atEHQhvFIGI7+tUyuBPNsdVJbCHspLDhq+vCe9NYm3lCwDlwnyjoEaHATcoeg4Upu
         rk0n4wlFQFCqpXxIE9QIQC/+0bSlBzI6g7bQkFjrZW50iWQv/SQcZhd24Az6KAuX4m
         bkt6wOCAywF2xzynJOh/fypkrHit0pKYBnYcl8qHIB0svP4RmrcuYDKJCKbU4IdS40
         ABg19uSzATMrNkt/fp+dG0f8czH1L3GjjiDJgIo3E8tfUCZRD1P2pzfictJQXC4R+D
         fUAlKzAn4m8nunY1mQTc+sTWMYWTBUPiyIAXTadmteFhwFYIOjDieCJfKL8GzI4rtr
         tbfVCBfA1XplA==
Message-ID: <97d6381c-67e1-0cc1-d92e-c893237577d7@kernel.org>
Date:   Sun, 6 Aug 2023 18:48:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] ata fixes for 6.5-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org
References: <20230806012901.250817-1-dlemoal@kernel.org>
 <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/6/23 11:26, Linus Torvalds wrote:
> On Sat, 5 Aug 2023 at 18:29, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>>  - Prevent the scsi disk driver from issuing a START STOP UNIT command
>>    for ATA devices during system resume as this causes various issues
>>    reported by multiple users.
> 
> Honestly, this seems pretty broken.
> 
> I mean, there are literally just three things that manage_start_stop
> does, and you just disabled one of those cases.
> 
> And it's quite illogical, since one of the two remaining cases is for
> the suspend side (the final one is shutdown).
> 
> The deeper issue seems to be that ATA is just doing something that
> other SCSI devices aren't doing (the whole set
> 'sdev->manage_start_stop' thing), and while there is one other user in
> the sbp2 firewire code, clearly the SCSI people don't really care for
> this bit, and the SCSI changes then cause problems.
> 
> I agree that the new "don't ask sd.c to send a start command" is the
> right thing to do, but I feel it was done in a particularly ugly and
> illogical manner.
> 
> I think it would have been better if maybe the approach would have been to
> 
>  (a) split manage_start_stop into three bits for the three actual
> cases it deals with: (stop_on_suspend, stop_on_shutdown,
> start_on_resume).
> 
>  (b) then not set the "start_on_resume" bit
> 
> instead of the current crazy model of first saying "please manage
> start/stop for me" and then following up with "oh, but don't do it for
> this case".
> 
> See what I'm saying? Don't mix "please do X, but don't do subset Y"
> bits. It's a completely messy thing and makes it really hard to figure
> out what you actually want for no good reason.
> 
> I've pulled this, but it really smells like a maintenance disaster to
> me. Particularly since the SCSI people really don't care about ATA
> anyway.

I fully agree with all you said. ATA suspend/resume was badly impacted by the
switch to asynchronous PM operations and the scsi layer using the regular PM ops
instead of its own. The problems come from the fact that there is no direct link
between the scsi device and ata device (and ata port/host device). As a result,
the asynchronous PM ops ordering (parent then child for suspend and reverse for
resume) does not happen and mess things up. This rather ugly "fix" is the
smallest I could think of to quickly address the multiple regressions that were
signaled by users.

This definitely needs a proper cleanup on top. Your suggestion above makes sense
and is definitely needed as the scsi START STOP UNIT command on resume is really
useless. There are also some strange things happening with stopping on shutdown
that I have noticed as well (e.g. cache flush failing), which I now suspect
happen for the same reason as this resume issue: PM operation ordering. So I
believe that a proper fix must also include creating correct device links
between ATA and scsi devices so that PM ordering works again.

This is at the top of my to-do list. Working on it.

> 
>                Linus

-- 
Damien Le Moal
Western Digital Research

