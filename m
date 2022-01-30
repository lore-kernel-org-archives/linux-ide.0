Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BB5C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 30 Jan 2022 14:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354942AbiA3O2J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Jan 2022 09:28:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58628 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354983AbiA3O2I (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Jan 2022 09:28:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FBD8611D8
        for <linux-ide@vger.kernel.org>; Sun, 30 Jan 2022 14:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA9C340E4;
        Sun, 30 Jan 2022 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643552887;
        bh=27sqBmKS4PU2icWmTRabtJ1Hds/a1W1eCsg6meiL/nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LX9tqdhlWC90SE+2LHK+mUARpOZlfAgE3MAB5ERPHLx6uzWMED0dlIUIlzGFhUSIE
         s+/8WGiE/kRJATiSs+HZnf1Gx4Jfe/O8YsWy4Xu3a7DHPdUwUnwEWvIv6mYza5g6cI
         Np67H6EkxK5GDn9EEytHKnPdk0S1SjY1x26A4p3X+uTNmEvjiq/UBGimxwD5w3XraG
         ahraOqmXJYfzKxT3RVqPSI5oyws2q6gmhspPcTkEwd2Zu9w1+oZG8/pRJY4OdYtat0
         sVFd7lpgPsbC4sqf6Lr7Ehwbm+1yX9thhqaSwi9n49BfeYZS0ivq7gcsp3n1Kk+n27
         QMa3XYkZcVeyw==
Date:   Sun, 30 Jan 2022 09:28:06 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Subject: Re: [GIT PULL] Revert ata fix for 5.17-rc2
Message-ID: <YfagEeprzcZnbWjg@sashalap>
References: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
 <YfTluSca/ye+lmrn@kroah.com>
 <CAHk-=wjAajZDJoqy93DVLQ+ZJQ+w1ScCxsnS-ELdL12kqYM_Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wjAajZDJoqy93DVLQ+ZJQ+w1ScCxsnS-ELdL12kqYM_Gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Jan 29, 2022 at 09:07:14AM +0200, Linus Torvalds wrote:
>On Sat, Jan 29, 2022 at 8:59 AM Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>>
>> It's up to you all, if you think the patch is correct, keep it for now.
>
>In the fixed form (ie with Damien's fix for the wrong test polarity),
>it's certainly not wrong, and matches a lot of our standard patterns -
>including our documentation in
>
>    Documentation/driver-api/driver-model/design-patterns.rst
>
>I did a quick visual grep, and all the cases of
>devm_kzalloc(..GFP_KERNEL) I grepped for did indeed have that "if
>(!..)" error handling pattern for the return value, including other
>cases in the ATA subsystem.
>
>That was very much a "quick visual grep" though, so no guarantees, and
>I stopped looking after it was so obvious. IOW, it was just a
>
>   git grep -1 devm_kzalloc.*GFP_KERNEL
>
>and then looking at the output and saying "yup, they all seem to do
>that allocation failure test".

I think that in this case the issue isn't the correctness of the
devm_kzalloc() allocation test itself, but rather the context in which
it's made in:

         host = ata_host_alloc(dev, 1);
         if (!host)
                 return -ENOMEM;
         ap = host->ports[0];

         ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
         if (!ap->ops)
                 return -ENOMEM;

My reading of ata_host_alloc() is that it allocates a refcounted 'struct
ata_host', but due to how we handle the failure of the following
devm_kzalloc(), we will never invoke ata_host_release() because the ref
won't be dropped anywhere.

So yes, the patch looks correct in the context shown by the patch
itself, but once we look at the entire function I think it's incorrect
(or, at least, I would expect more reasoning beyond "the static checker
told us so" around why it might be correct in the patch message itself
if I'm wrong).

-- 
Thanks,
Sasha
