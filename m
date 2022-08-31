Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4640ECAAD4
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 13:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiHaNad (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHaNa3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 09:30:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B9AB06A
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 06:30:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l5so10922845qtv.4
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=71fadeo1HOgKUNJgNdgVHmP3uBfauwPzBaHUHDyH5UQ=;
        b=IlJu7kDyKBO1nRYS0P8hfE0rqcZtCoqsI4UeHMZzr7OcF8BqRDz8UIVl9Q178ysBy3
         onoinBL1pc2IVgHudspdFf8YVQujuI1kdoyMDIoiMbaqKJD8lkNSXeDTrNdS9sRJ+RzT
         Uy9bYHITsQBtJXFLQNZEIO0acpR+9KJi2xDmJBfCL1HdfEtCX2EPLuDDsbZ5xgratMOb
         U61rxBtCi5a4G1YM6u55NMMB6kzF2gUGYj43uJ0r/wyYXHeEiyFkeYfHePiu2ZLgTAGv
         ZUttdHX9FYHqNwXIIgRhT/QZu6HG4aN8SLKglZU6i7m2m8HOidW2hdjDmkWRPid7NzSH
         M3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=71fadeo1HOgKUNJgNdgVHmP3uBfauwPzBaHUHDyH5UQ=;
        b=sDpjEBLJPRqNOFeel05IstlDG5T5R3j4qMfVfo8W6UEdsqHRogVrC3DP2ajUqRXxeY
         ksYBPbaHg+YrTFWgckm+PQ3z+OyWHWtObRRspiLukCEziOjYWBVN2AErdc2PCqUAEFV4
         IovkYt8X63Gaf2zyd0MORgIxC5Xxgro2UH3ceke1q7KaSKzJzt0+5BATeHptQbNff191
         c1/HW6HgdTElw4+PzIAKvEChZ4KwY/xiuOl/zbNZH1xZidE3QHOg+WDQhPy3QWJAtQNN
         gTmOZk3eywT0HMg8ppN+k37ZO6FZPO6TCRppblaLMvjxJJbDtcY/wyTKk1VZfSB5pht8
         x7Kg==
X-Gm-Message-State: ACgBeo0Msrx0MxM6G78RU7Vs0hXEMUMIRp1pLWOmXYffEEV2hoFKTZOO
        zd/BISV0YAeA5BaZ85MWgWNKigIl40PShu6zFMQ=
X-Google-Smtp-Source: AA6agR7/gMCAdORP5apzYVBaVzTfca4MAWLBNXTDm9H9/rq0JFI11xbsGiTU/QGQn004pmZqSU+w68Njpkznpkzvf74=
X-Received: by 2002:a05:622a:1115:b0:344:5d08:ff1d with SMTP id
 e21-20020a05622a111500b003445d08ff1dmr18868546qty.23.1661952627400; Wed, 31
 Aug 2022 06:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com> <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com> <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com> <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com> <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
In-Reply-To: <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Wed, 31 Aug 2022 15:30:16 +0200
Message-ID: <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Sorry for spamming replies and quoting myself.

On Wed, Aug 31, 2022 at 12:21 PM Peter Fr=C3=B6hlich
<peter.hans.froehlich@gmail.com> wrote:
> On Wed, Aug 31, 2022 at 9:48 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> > On 8/31/22 16:15, Hannes Reinecke wrote:
> > > Oh, of course :-)
> > > That was when doing SMR support for libata.
> > > I dimly remember that some pre-spec drives had been using the DRDY bi=
t
> > > to signal an unaligned write. Which never made it into the spec, but =
the
> > > decoding stayed.
> >
> > Any idea where the other bits come from ? Except for bit 5 (device faul=
t),
> > I do not see anything else in the specs that mandate these definitions.=
..
>
> I have since discovered the "SCSI to ATA" specification which has two
> tables about mapping ATA errors to SCSI errors. Among those I was able
> to find an "unaligned write" case as well, but I cannot properly parse
> the rest of the two tables yet. They are in sections 11.6 and 11.7 of
> that document.

So I've re-read everything I can get my hands on and from what I can
tell the overall "flow" of ata_to_sense_error() is not what the
specifications would imply. For example we look at BSY on entry and
then say "ah, it's set, then let's ignore the error field" when the
specification (the way I read it) instead says "BSY is transport
dependent, so we say nothing about it here; but check the error bit in
status, if it is set, interpret the error field, otherwise there's
nothing for you in the error field". Of course I am a complete noob
when it comes to this ATA/SATA/SCSI/AHCI stuff, so please divide by at
least two. Sorry if this adds more confusion on top.

Cheers,
Peter
