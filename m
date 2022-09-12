Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91DECAAA1
	for <linux-ide@archiver.kernel.org>; Mon, 12 Sep 2022 07:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiILHxM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Sep 2022 03:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiILHxJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Sep 2022 03:53:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04AB22B1C
        for <linux-ide@vger.kernel.org>; Mon, 12 Sep 2022 00:53:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g23so1031863qtu.2
        for <linux-ide@vger.kernel.org>; Mon, 12 Sep 2022 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=0mC6CVULTnfDztzrPje/feYPHnG1TGzG3CtDzj/r7jE=;
        b=G6wjwsBH0xpdysHnjkfLFKeeSxvALw3acguCI7N9R4TryZQb2QLq+Y4vrZ/+N3PDKz
         x38Ehito2zGUn2EqvTGs/Dc5Ss00Py9inLzn4qJnO+AaZ72717+yK56xayHxcOGtf2Xv
         PWwBRoUgIzxCgnxoNAytRAHtUv2kHvLAnsmgN70B51X1BjTyiDdWuiGF9sW+8psyVqbN
         hnJkTuhtbNbkVcl23QE6X5yO35JuDOxA+kb4dVIdo8P6s7j9qPnlkz3rU2+svFDFE+jq
         pbtr5fWDDppGvujRB3ona8B+FnJEFy46dD3dJmc06qiWkguohrWIL9UnKrE8CwVYvrTl
         K6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0mC6CVULTnfDztzrPje/feYPHnG1TGzG3CtDzj/r7jE=;
        b=PXnT+xtniYlv0lINCiWp57WeIuocXWZrHuiGodKKglIxYoDlItGoRDA17VKrora4m5
         cnbtKUqYkfQcEW1PXcRG3NmElMNc5SAK+9vBhyFeFCuuA8NuSZfATp8T4CASwt89xZ60
         qzBKCpf+GxDroNzNyiUfPBZSlJ51yDVBOUPi8gC/yk1iG5hWBrJLX5cexs0G5iPuBVeK
         NgCUtlYDsUtFHY6e/aiga9Tai3d6akFyi6iLcqf8UFe+f/lxjn1WvDf3ZTB9Kpa5Io67
         HmvO0qrNT037pWnzcvu279R6lgB+aVZMkNf5ZVZBrGAn5hbE6BhwfcjSsBRWLp4GBY8Q
         g6fg==
X-Gm-Message-State: ACgBeo3yWg26izLtHs4lBSVLMvKX3RyaGVnihg15jQZvoHKQpAi+JVFZ
        MWHzIg/Dd9IjRdT+jhvu1NNl/HtUi37RyUT+Z6A=
X-Google-Smtp-Source: AA6agR6qUefbY8In6SYx6LPa+1O17wFencwfnL7NV6cTQBOq8LhZKRw0ajDWSFXIGiclxoEsRidKbuYq0ttQHY4nVxI=
X-Received: by 2002:a05:622a:58c:b0:343:5b5a:41ec with SMTP id
 c12-20020a05622a058c00b003435b5a41ecmr22081181qtb.377.1662969188009; Mon, 12
 Sep 2022 00:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com> <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com> <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com> <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com> <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
 <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com>
 <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com> <ed854cd3-3456-4dfc-e589-40f4946bb0e7@suse.de>
 <396b2bb5-533f-2a9c-66f2-c92465d54df1@opensource.wdc.com> <CAHXXO6ECthyiomdCCR8YaR6O8tq8XhhHn-sX3nRTnjNYkWCVLw@mail.gmail.com>
 <50673ba5-6cca-23df-e09e-d7b3f7113896@opensource.wdc.com>
In-Reply-To: <50673ba5-6cca-23df-e09e-d7b3f7113896@opensource.wdc.com>
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Mon, 12 Sep 2022 09:52:56 +0200
Message-ID: <CAHXXO6EYxC3B6L5ur7DrShmpwdw9YsqrnpRBoY7X9paTzWmD2g@mail.gmail.com>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Apologies everybody, I dropped the ball on this a little, see below.

On Fri, Sep 2, 2022 at 10:41 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> On 9/2/22 15:34, Peter Fr=C3=B6hlich wrote:
> > I don't think the drive wants to "signal" anything, instead it simply
> > "disappears" at some point. The "original" error is "Emask 0x4
> > (timeout)". So here's an example from early on when I had not made
> > many kernel changes yet:
>
> Sounds like the drive FW is crashing...

That, or maybe the interaction between the SATA controller and the
drive not being the most awesome. As I hinted before, we've had this
with different disks, both WD and Samsung disks, but the controller is
the same. Which, BTW, is this one:

02:00.0 SATA controller: Marvell Technology Group Ltd. Device 9215 (rev 11)

As far as I can tell, no major ATA quirks in the driver for that
thing, just a general PCI quirk that seems to apply to a bunch of
these Marvell chips.

> Are you running this drive with device/queue_depth set to 1 ? What is
> issuing a WRITE DMA instead of the NCQ equivalent ? Is this a passthrough
> command ?

The NCQ feature is indeed switched off because we've had problems with
other disks (spinning rust IIRC) crashing due to their NCQ
implementation being buggy. That's a different problem and has, to my
knowledge, nothing to do with the stuff here. Except that we're not
using "MULTI" commands without NCQ if I understand it correctly.

Here, finally, is why I "dropped the ball" on this thread. I played
with kernel command line parameters ON A LARK and it turns out that if
I say "libata.force=3Dpio4" then for whatever reason all these issues go
away, I can no longer reproduce the timeouts or the attendant "wrong
error message" that made me post here originally. From what I gather
(and I may be very wrong here) forcing "pio4" makes the driver use yet
another set of commands, and THOSE commands seem to confuse neither
the SATA controller nor the disk anymore. Quick benchmarks showed some
loss in speed and we're still trying to figure out more of the
details, but again, the timeouts disappeared.

I don't like the fact that I am no closer to understanding what is
actually wrong here, but maybe this data point helps someone else
formulate a new theory of what's happening. BTW, despite "pio4" when
you ask the disks what they are using, they keep saying udma5. Another
thing I don't quite understand, but again, someone more knowledgeable
might.

Cheers,
Peter
