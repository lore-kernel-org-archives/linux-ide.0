Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6963AECAAD1
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 10:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiHaKVr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHaKVp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 06:21:45 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DD2A2D90
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 03:21:36 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id w4so10456926qvs.4
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=B9WOfX1YQQDDb/ydHXroZVZRgxcenwpK92oLkcAhYKE=;
        b=M3eVw6FVnUro+0V7k+qBaZdcwINAcRneFy29AJM7lf5sxITShT/pMJJkaWpUyF7ZuK
         QwfWVNlIq/LjtVJGyEQCzYtmkLS3UKu9e/eHkI+wTcgecCQzwm6lEsCfcGQtS4mOJoed
         dQDZfQUrp5oZH4kbV6eNb5k6mgILzDGBs6Mt0xoGGq4vlVEwrXKgvgoKyhXkU9BPX+XP
         8Y49DGguke4ruG8CKilfRvYlXQRXCCru2S3AGo+XYGyPzbCgDSYASMQndW4hUewH+RJ9
         aen/nC3EeF6Rl1/oijbIKKCz4KNVBcyNQX2r4OXG19sX0VsVJJeRBqjnyiJguVUHxOIn
         5lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=B9WOfX1YQQDDb/ydHXroZVZRgxcenwpK92oLkcAhYKE=;
        b=cs7Q/QDMy18xcxQicaerBET4S++DdV6Xr/zT6yMXmjAEA2rZSbxs3VdXBAGH4WD1Nf
         fPWIZoP8T3ChTiEKd8B1L7/ctUJ0FT+ekyzqvypA0nz0/GSt/iblSGrSVLS2BqZEFGJC
         Q2y60tfIRf5SSmwT/pK3G2g20N5DPUzyjjT8NIHoo/uh76LTAEcVoBwMd6qpvgLAcKI5
         hc68RVPwT3o/JFEf4HjD3Z7xELWJcLW9FtEw7iuZPPKwO83eHcImfzJioXnSDTHZ1twu
         pJvkiCNi3652TlWg7db/o2E76/uwWdzui2VeYRTl1/E4nHv+n2NdFwJxSuLLrOLPs4/v
         XnsQ==
X-Gm-Message-State: ACgBeo1J1kcAamIHGsl3kk63hynRSA3DeZrIPlEwwaw68AfDnzo94n+g
        /4iekb2fISeGjeDmfEOcq/7l8YXwEiJ1tzdZkIQ=
X-Google-Smtp-Source: AA6agR4suIXiET+d8VjhFyyPzwws88OUXJwBN5I+JhQyKDLy6Usnzlec+Gg5LhJ1Id6G/vuR9iZ1Nv8Tseawnj9CfXA=
X-Received: by 2002:a05:6214:2267:b0:474:8ff7:a21c with SMTP id
 gs7-20020a056214226700b004748ff7a21cmr19073699qvb.56.1661941295200; Wed, 31
 Aug 2022 03:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com> <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com> <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com> <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com>
In-Reply-To: <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com>
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Wed, 31 Aug 2022 12:21:23 +0200
Message-ID: <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Aug 31, 2022 at 9:48 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> On 8/31/22 16:15, Hannes Reinecke wrote:
> > Oh, of course :-)
> > That was when doing SMR support for libata.
> > I dimly remember that some pre-spec drives had been using the DRDY bit
> > to signal an unaligned write. Which never made it into the spec, but the
> > decoding stayed.
>
> Any idea where the other bits come from ? Except for bit 5 (device fault),
> I do not see anything else in the specs that mandate these definitions...

I have since discovered the "SCSI to ATA" specification which has two
tables about mapping ATA errors to SCSI errors. Among those I was able
to find an "unaligned write" case as well, but I cannot properly parse
the rest of the two tables yet. They are in sections 11.6 and 11.7 of
that document.

> > Will be sending a patch.
> Thanks !

I concur: Thanks!

Cheers,
Peter
