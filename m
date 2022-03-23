Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC3C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 22:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbiCWWMN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbiCWWMJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 18:12:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1F68F98B
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 15:10:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e16so4964857lfc.13
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUeE8G9Vx8PFGOVX3Q4nK5GeWxn1zx9g+XFxHJK9Vhk=;
        b=JrrFS/MBqXRKVJs7YcYaFQzytd9lmkb0lUUKRqzUzPm7iKbeQVSthlXXxkGcLCzzFO
         P6eb+JvotU9OGmUKprw/KsihPoSilzNndM8e6npnPiAlUwXHwtZVZbbNy4gkuMcBDVRV
         UBN3DemAkXw7927BNk8WUFABGCf0NDWzezccE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUeE8G9Vx8PFGOVX3Q4nK5GeWxn1zx9g+XFxHJK9Vhk=;
        b=JPbbxHSqQnOBRDO6LevZe7DW0b9LO//A33WF2TIunIjBtUqFsnBQeYBFUDld18V4NB
         CHTMJt5te237kPvr3Pdwoc0pkymH7RlWB6DugB9P/Wjz6tQlzP+VQY0Uq4yRAyQyD3bE
         knKyTsWxMbO2/jfeMCEJobAaElWAJsApMcD3BmAh0ci0hbakV+1EpZMtCMPqpkomIxup
         Ovy77P8kEzlYJolJRBqduqDDb6cFhyPJuXf9xecGooGxJIWsD+Gi4HWMju0jrVr6x3Ng
         LaArFyp1xUwUj9BFEQ0CSroRCD2P5pD4Tsf7yErtuRxpXMOTA/0vywOwTn+GZNBRyCdl
         1Icw==
X-Gm-Message-State: AOAM532423Ftpdn5uDpZ0QBTzsIVe6ssNnz8o3XGz4ZnyHuGnwookLub
        V++Vp8N2r8Vi6ftsysCAx6AsaQxOBirdQuqw6gQ=
X-Google-Smtp-Source: ABdhPJz7G8c9ZE6QQX0L8GLGc+9KhU/3BvxsDfpEZ2Zwm+1gUQQAfTVuhWaqE7NJbRsVVVnAqN5bbA==
X-Received: by 2002:a05:6512:90f:b0:449:f469:2301 with SMTP id e15-20020a056512090f00b00449f4692301mr1439964lft.309.1648073436515;
        Wed, 23 Mar 2022 15:10:36 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m28-20020a19711c000000b0044a1fd4133asm106050lfc.215.2022.03.23.15.10.35
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 15:10:35 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id d5so5009136lfj.9
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 15:10:35 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr1440760lfu.531.1648073435244; Wed, 23
 Mar 2022 15:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 15:10:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
Message-ID: <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Mar 21, 2022 at 11:57 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> * Rename ahci_board_mobile to board_ahci_low_power to be more descriptive
>   of the feature as that is also used on PC and server AHCI adapters,
>   from Mario.
>
> Mario Limonciello (3):
>       ata: ahci: Rename board_ahci_mobile
>       ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
>       ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item

So I've pulled this, but it's worth noting that particularly renaming
that CONFIG option was probably not a good idea.

Why?

Because it means that people silently lose their old values. And it has that

        range 0 4
        default 0

with 4 being explicitly marked as very dangerous - but at least Fedora
seems to actually have a default of 3 in their kernels:

  /boot/config-5.16.13-200.fc35.x86_64:
        CONFIG_SATA_MOBILE_LPM_POLICY=3

so that "default 0" may actually not be the right one.

Now, we're at the point where few enough people likely care about ATA,
but the corollary to that is also that these kinds of changes can
cause user pain that then developers have *no* idea about.
Particularly when the pain ends up being caused by some subtle default
config option silently changing that nobody even thought about.

Now, that "default 0" is probably the only safe default - and I don't
dispute that part. But I also suspect that Fedora chose that value '3'
because it probably makes a noticeable power use difference on at
least some platforms.

I don't know. But I doubt really *anybody* knows, so renaming them and
silently likely changing config options for some less-than-critical
reason is just not a great idea.

                Linus
