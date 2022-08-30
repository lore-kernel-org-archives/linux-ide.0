Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE064ECAAA1
	for <linux-ide@archiver.kernel.org>; Tue, 30 Aug 2022 07:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiH3HCr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiH3HC3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2022 03:02:29 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD8AA4F9
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2022 00:02:28 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id kh8so8071331qvb.1
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2022 00:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=oLcaLtHHs82rV6BPpGNH7nPU3vEgjWiGDMihOnet7YI=;
        b=ROTxh87BvYNgSdYxeHRiMlYjgxxBtCbDX99BWooBH67tlVVLTrq62AHYflIJNEBW7T
         O1yJH1eky/sCikP+X3OI4kRtxK/OsYf2mgXR75D2LDfUNoffgOjAYbFHbJv66i/Ch0Ad
         1LCkG5fVbEwF+tX6dyDfrQyk5f1+xak/lP5WFk4HO1HLL9IX1ASJhH08D3OKIB62/Deq
         OEPF5Y92N5b2HcW/P8zqpBXruIaqHkegCbPA045qLfFisjfc/TcsaBvGqxPl6nKlGb/j
         mOppU0dJbH1IMQOIlzttAsNpxMMjv12kvBPkYVYf7PCtpxZ/N63hkT9/8WaG1oMLw0V4
         yCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=oLcaLtHHs82rV6BPpGNH7nPU3vEgjWiGDMihOnet7YI=;
        b=hmlG0dVAYc8RI6NALI/0/DGNuXUUWJq53HJgV/rcsil656b7BPJSNd3a63kwjzcnuK
         WKs3z3jEb7ZRHkraJNACQeu7C+MQV9Qxudaqc8ZayoizotbPw9SvWsNVo7I71LBrx3LJ
         QnnejJzVS31jOIOWUc+1blunKtbV4s6xtR7423PlxxH+oAD9w6/Br3XsqdE3njgTEFGS
         El1aBa86qSYOdDUBpW2XtTWqDkkSdPvUpay0kOYoGQ5R8fO1riFkzPQJIfZH+6DYK0Cz
         O0oFQkfe8WmqW76weQcWGJfgBRgn3VIqzToMHhyC8PycjgaSNwYYVGDr1wyyrYWmjY5U
         K1AQ==
X-Gm-Message-State: ACgBeo1OXFTaE8IPfOb4h7tW5+sT2RUqVO2VxWaBeFE5H+FjzwYXs1RX
        s5BmiS1mxnqAO+e1dp8O1xIh1rPDYDix9gcZc9U=
X-Google-Smtp-Source: AA6agR7k0ys+dKjtTvdvfNfbgXMwha4V3D0szf9/eGlpAIF5ALOI0X5DyH3uaZnyEZTWcuh8ztaVsnJKjpxqLaWqulI=
X-Received: by 2002:a05:6214:2267:b0:474:8ff7:a21c with SMTP id
 gs7-20020a056214226700b004748ff7a21cmr13954943qvb.56.1661842947851; Tue, 30
 Aug 2022 00:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com> <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com>
In-Reply-To: <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com>
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Tue, 30 Aug 2022 09:02:16 +0200
Message-ID: <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Aug 30, 2022 at 1:26 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrot=
e:
> On Mon, 2022-08-29 at 08:04 +0200, Peter Fr=C3=B6hlich wrote:
> > That's the sense_table, I was referring to the stat_table. That table
> > is consulted when we fail to convert via the sense_table.
> ...
> So looking at the right code again, this is all very strange. E.g. the
> ACS specs define bit 5 of the status field as the "device fault" bit,
> but the code looks at 0x08, so bit 3. For write command, the definition
> is:
>
> STATUS
> Bit Description
> 7:6 Transport Dependent =E2=80=93 See 6.2.11
> 5 DEVICE FAULT bit =E2=80=93 See 6.2.6
> 4 N/A
> 3 Transport Dependent =E2=80=93 See 6.2.11
> 2 N/A
> 1 SENSE DATA AVAILABLE bit =E2=80=93 See 6.2.9
> 0 ERROR bit =E2=80=93 See 6.2.8
>
> And the code is:
>
>         static const unsigned char stat_table[][4] =3D {
>                 /* Must be first because BUSY means no other bits valid
> */
>                 {0x80,          ABORTED_COMMAND, 0x47, 0x00},
>                 // Busy, fake parity for now
>                 {0x40,          ILLEGAL_REQUEST, 0x21, 0x04},
>                 // Device ready, unaligned write command
>                 {0x20,          HARDWARE_ERROR,  0x44, 0x00},
>                 // Device fault, internal target failure
>                 {0x08,          ABORTED_COMMAND, 0x47, 0x00},
>                 // Timed out in xfer, fake parity for now
>                 {0x04,          RECOVERED_ERROR, 0x11, 0x00},
>                 // Recovered ECC error    Medium error, recovered
>                 {0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>         };
>
> So this does not match at all. Something wrong here, or, the "status"
> field being observed here is not the one I am thinking of. Checking
> AHCI & SATA-IO specs, I do not see anything matching there either.

Thank you for confirming that this section *is* confusing. I was down
the same rabbit-hole checking "status" in whatever ATA spec I could
get my hands on, and it didn't help. Specifically for "WRITE DMA"
where I usually see the error, it seems that bit 6 has no other
meaning than "transport dependent" which for SATA means (I believe)
"drive ready" as it's always been. But that 0x40 is *not* an
"unaligned write" whatever else it may be. My suspicion is that maybe
it went in by accident since it's also in a "whitespace" commit. On
the other hand, it has an explicit comment. I wasn't going to bother
the original author before, but maybe now I should?

> > Which is why I am pretty sure that the "unaligned write" message is
> > spurious since I am writing to a plain old SSD. It's going to be hard
> > for a userspace program to generate a write that is no properly
> > aligned for the SSD.
>
> Unless your SSD is really buggy and throws strange errors, which is
> always a possibility. Do you have a good reproducer of the problem ?

Not really, sadly. For me it happens with SSDs behind a Marvell SATA
controller but it doesn't happen when the same SSD goes behind a
fancier SAS controller. This is what led me into the ATA/SCSI layer as
the possible culprit because on the SAS boxes that layer is not used.
BTW there's another "strange" effect that sometimes seems to lose the
LBA flag on the ATA taskfile struct resulting in an obscure error
message about failed CHS addressing. In that case I suspect an
initialization gone wrong or maybe a race condition somewhere, but
it's been a real pain to track down further. If I ever get a better
handle on how to repro this stuff, I certainly will share.

Cheers,
Peter
