Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C2EC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbiCWXPF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiCWXPE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 19:15:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968790CC4
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:13:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d5so5216215lfj.9
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDiXgDZyybGGzHBKdXZKetwVr0zYxw5j9zlnOBNV0xI=;
        b=Y9HzWa4QfUOkrbHsaQJmvTpSEtMXtQ9uSfiBJOcSbCjdYw88WdCRU49CWmC/L35Bnl
         /a2Rn3NI2eySJbvSqnXgC7KOsO9mj47J8+cKc/oHH/vTSy3BIRmJfkfYpWOkII2PHsWl
         7AXHCwKKYqGjwsVg1xrlVX1SYctQCmcUaBeWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDiXgDZyybGGzHBKdXZKetwVr0zYxw5j9zlnOBNV0xI=;
        b=mFehqOcwozUBl4YVokYlbtU6Rd2csD3YuI1FaFWLyoO89tfXw3UpthXvEh5cPkl8nt
         kr8cV7GA9DUIfp4wLmHx6V2iRxdFyV9B9vBkndre9cPqg2vD9X8WSyhMypCdHd6N2TP2
         tX2cB2T1T8QyiLUzCcz6HZDva+7XqMEKhpLhE2a2z2pHl8lFgTsgC5KNYnBMmk80LYzx
         M7KD+roY+rWvCyG7vWvK+3npr2h+lf7cK+g8C4ah1BS89FEJDRSucu9H55w63tjnfhck
         KOB2b3ugMhefSrLWSzfmmYGrgvPOQR2o8wbq1+3jljd8rr3GQzSetXQSDOaiyMAljS6N
         r7gw==
X-Gm-Message-State: AOAM533XCKNUmcOiCnWoEla+iIKbA9yXAClIP7P/5QRujgdJ6szBa+Vh
        W+D9jEMuCo9e/3ZyqUk0ikm6C9WvUTcLUhCCw6A=
X-Google-Smtp-Source: ABdhPJz73ejixE8l20slNS8pfnrJ+zrF8MDNYs4tKvzdtrpsvLTXXUQZBpQ9xHsgAfVGoBk2sMSHyg==
X-Received: by 2002:a05:6512:22cc:b0:44a:1097:b5 with SMTP id g12-20020a05651222cc00b0044a109700b5mr1677243lfu.659.1648077211247;
        Wed, 23 Mar 2022 16:13:31 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm117098lfb.302.2022.03.23.16.13.30
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 16:13:30 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id bn33so3951046ljb.6
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:13:30 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr1999562lja.443.1648077210285; Wed, 23
 Mar 2022 16:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com> <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 16:13:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQhOw4LOejeLKtEMWS3+xVZ-+zh=EqhdDn=E0d3C1e6w@mail.gmail.com>
Message-ID: <CAHk-=wgQhOw4LOejeLKtEMWS3+xVZ-+zh=EqhdDn=E0d3C1e6w@mail.gmail.com>
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Mar 23, 2022 at 4:04 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> So maybe a logical thing is to keep this change and send a follow up that also changes
> the default to 3?  If you're supportive of that I'll send something to Damien to do that.

It would probably be good to have some way to see what other distros do.

I only have F35 here, so a very limited selection of distro defaults..

            Linus
