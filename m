Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CCC001DE
	for <linux-ide@archiver.kernel.org>; Sun,  6 Aug 2023 09:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHFJv5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Aug 2023 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJvz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Aug 2023 05:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2B199A
        for <linux-ide@vger.kernel.org>; Sun,  6 Aug 2023 02:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38EE361012
        for <linux-ide@vger.kernel.org>; Sun,  6 Aug 2023 09:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300CFC433C7;
        Sun,  6 Aug 2023 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691315513;
        bh=2j7EcAIl/VN1sfHNeZB/g2M73UeMqODtzEc7QIMZQCg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nmVea4JdsokBirjuhN/eBv9EXOJpMKzBjZxikt2bHVT81n5o0bUNEqdUvySw2qUBy
         GEYwq8xCpfi/y+uHgNf8TONeiPpLYriH0wwsJ73ATV2kxeCDIXhGELIEbJprgk2IA7
         O1u2AHKVBTiYYq1cS0N2t3MIhIq4cNDS8CqFW2Pkjt7akqkqHyTMHxXteOP9k0XEXi
         /OnA8j9IjKxoPmGd1YEZrAh284URoN73Q6eh07QHLXH4ucu+C4MhRe3t5++kCxGuWE
         TFZjZ+hbdgDvScZBqODR/pjQy28V8SNahOzaSgAOvRcg0ZF4qCa72eqh9bS3OOtTmv
         KKQi9t+g23nag==
Message-ID: <e3357241-3cbe-4cc4-59a3-a97002443ba9@kernel.org>
Date:   Sun, 6 Aug 2023 18:51:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] ata fixes for 6.5-rc5
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org
References: <20230806012901.250817-1-dlemoal@kernel.org>
 <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
 <CAHk-=wi9cRUcAY1b-NvjVwysGadMPJ2W+UiTzXxzEKk==WdHxg@mail.gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wi9cRUcAY1b-NvjVwysGadMPJ2W+UiTzXxzEKk==WdHxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/6/23 11:55, Linus Torvalds wrote:
> On Sat, 5 Aug 2023 at 19:26, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>  (a) split manage_start_stop into three bits for the three actual
>> cases it deals with: (stop_on_suspend, stop_on_shutdown,
>> start_on_resume).
>>
>>  (b) then not set the "start_on_resume" bit
> 
> Side note: the ATA layer already has
> 
>  - ATA_FLAG_NO_POWEROFF_SPINDOWN
> 
> which seems to basically be very close to "don't send stop on shutdown"
> 
> And in fact, it looks like
> 
>  - ATA_FLAG_NO_HIBERNATE_SPINDOWN
> 
> is in turn very close to "don't send stop on suspend". So if that
> manage_start_stop had been just split into those three actions, it
> sounds like those ATA_FLAG flags we have would basically have
> translated to setting those bits too.

Indeed.

> And the whole "start" seems to be translated to "ATA_CMD_VERIFY for
> the first sector", which would seem to be literally just a random
> command intentionally chosen to not return any actual data.

This likely was added to force the drive to spinup, to avoid subsequent commands
to fail. The start process doing a port reset and then revalidating the drive,
which starts by issuing an IDENTIFY command, definitely will wake up the drive.
There is no need for relying on scsi to do it.

However, I am still not convinced that the revalidate should be done at all,
unless the scsi layer does do it too. As you said, this may be causing
unwarranted spinup for cases when the drive is not used after resuming. But
again here, scsi and ATA revalidate are not linked either. One does not trigger
the other.

> The *only* effect of doing that 'start' is to cause extra disk IO
> early that is then ignored. Logically it doesn't actually do anything
> useful, and it would seem like it might actually be an actively bad
> thing (ie spinning up a disk on a laptop for potentially no actual
> good reason, and waiting for this all to happen).
> 
> End result: it really smells like ATA fundamentally doesn't want the
> whole 'manage_start_stop' noise AT ALL.

Hannes suggested doing all ATA start/stop processing solely relying on libata,
that is, not using manage_start_stop at all. This is another option I am
considering.

> 
> You just removed the nasty early start with that 'no_start_on_resume'
> bit, and the spindown seems to be questionable on at least some
> machines too.

Yes it is. I have seen issues with the shutdown side, most of the time showing
as a synchronize cache failure. But until now, I had no clear understanding
how/why that happened. I understand it now and will be fixing that.

> So I wonder: did somebody test just removing the setting of that flag entirely?
> 
> I guess ATA is legacy enough these days that people want to make
> minimal changes, although that 'no_start_on_resume' really doesn't
> smell all that much more minimal to me than not sending spindown
> commands.

I will revisit everything around PM operations. ATA is indeed legacy-ish for
most desktop/laptop users as NVMe has taken over most systems. But there are
still a lot of enterprise deployments using ATA drives, and a lot of users
running old hardware. The former is rather easy to deal with as the hardware is
most of the time very recent, and so better than old devices. The former is a
constant source of headaches due to the sheer amount of buggy hardware out
there. The potential for regressions when changing something is high, so I try
to be prudent with changes.

Thank you for your comments.

-- 
Damien Le Moal
Western Digital Research

