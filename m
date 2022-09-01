Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A056FECAAD1
	for <linux-ide@archiver.kernel.org>; Thu,  1 Sep 2022 06:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIAGKb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Sep 2022 02:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiIAGKa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Sep 2022 02:10:30 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BEE76755
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 23:10:29 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jy14so6949214qvb.12
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 23:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JqSngrlTiSo7Vykm2o2zviNhbMHsI57MSnQxkLe7E1E=;
        b=gH2kn3W8DClS+bKcrFQcnYvz+LhujNQAzFmVKJSwZpvDoU21KS667E7K9jF2HcUnt7
         F6GShJ6oesh5Pu5php/V5kZA3TA6tdXZvzpa/C89GuxLLFF3ckgBI3nXLs++p2X4jGEU
         sk7ozN4TESatLcYWUqIeVGsSnxcnJjqt9gUXiYBw5xuBTlPtsdtJpXQTI9a2koUJncLL
         z1pjLFOaaQb9vuXKGkQkzFs/iZXsrv3EWryms+a4mUcX4OK1Jpv4qrkf22qYlxajUf1G
         5yGdVBsFJPyI7KBFYVnTGPvL/NrMiqfoULJbUP97IQLyRi/p47111cV3Cp9Fbrf0Wrml
         fhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JqSngrlTiSo7Vykm2o2zviNhbMHsI57MSnQxkLe7E1E=;
        b=ds1h02djLuuWe5oG6c95f/qWGMQx3nFz8+D3NauuFXTT7h4Lwe3G0MGiZlaf6MR9rz
         T1vFcPmNTf/tVcpQ6jVqq1WunnIO+kc/Lh2OiPHBUGdEW70KYHx6M+dvaBJlHtd2Un9F
         TWgJJGNG3KgyuCcuFc2PBinHwCEPomXA51rZ7wkYEAVbIeNJoIB62MLqWfZMJ7eIIhRb
         CFoSgBm+vX35S3sMzeIjrwgK30f5OVhAFT3aQ6weaAr51Uv76QAAz8+KCEgEwufes9Ni
         gEy+5S9YZeA/vxsAHcqO1mOFxKOmrQZtRI4/XTb6zSxvXNCJ87zEUHrkfSkqM3eRgvLc
         CB0w==
X-Gm-Message-State: ACgBeo1n84AxzUv3rJsEF7B2IAvFqFOozAxXFzIm96a8ohwjpoggjhVS
        TsJfwuuCXO3BfJPegOc9R2R/7amALRX5t3EJXlk=
X-Google-Smtp-Source: AA6agR6O4CsNmBGZiyElAf4PEbD9w1HTx8l/LIuxaZAepgGdP8aTYr0RN0aBoPRYzy7vuRoPHpoynQpGciXK49XfsjU=
X-Received: by 2002:a05:6214:5285:b0:474:69d7:c22b with SMTP id
 kj5-20020a056214528500b0047469d7c22bmr23277979qvb.97.1662012628476; Wed, 31
 Aug 2022 23:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com> <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com> <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com> <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com> <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
 <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com> <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com>
In-Reply-To: <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com>
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Thu, 1 Sep 2022 08:10:17 +0200
Message-ID: <CAHXXO6HJ9Z4pXNKiPc4vp+V66F4kRr0E89vwdKHbhFHrBLNArg@mail.gmail.com>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Sep 1, 2022 at 12:55 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> As for the stat_table, except for the first buggy entry as mentioned
> above, I have no clue where these come from. SAT only defines the HARDWARE
> ERROR / INTERNAL TARGET FAILURE for when the status field device fault bit
> is set. Need to dig further, but I am afraid this code may be due to years
> of supporting drives returning weird errors that got mapped to sensible
> sense codes instead of a pure implementation of the specs...

That last sentence is probably the key to a lot of this, in which case
one would wish for a comment or two as to why. I was trying to do some
more digging in the git history, but it seems that interesting bits
predate the 2005 git import date of the kernel sources and I am not
sure how to look further back. Also it might be that by now
"consumers" of these error codes may require them to stay the way they
are, i.e. even if something turns out to be "wrong" it might be
"unfixable" to not break userland?

> I need to spend some quality time with ACS and SAT documents to sort out
> this one... And lots of coffee too probably :)

I am starting to feel bad for kicking a hornet's nest in the shape of
a tiny function. :-D Thank you so much, both of you, for spending time
on this.

Cheers,
Peter
