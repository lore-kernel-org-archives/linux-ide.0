Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF687C0502E
	for <linux-ide@archiver.kernel.org>; Mon, 29 Aug 2022 06:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiH2GEx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 Aug 2022 02:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiH2GEv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2022 02:04:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B4FC71
        for <linux-ide@vger.kernel.org>; Sun, 28 Aug 2022 23:04:47 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a15so5358997qko.4
        for <linux-ide@vger.kernel.org>; Sun, 28 Aug 2022 23:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=fJthO6MUCq9ERN/kOkLb40SfK2NiNWqwIK1FuvDbRm8=;
        b=b4hYv39BLmX/xdPgGAO3A9t36fbYEmZzJePylcm7QKsmCewlgCjwJFuxkU10ZLyS9U
         gn0lPxhmDBwOh9EW4TVd5BliziuMOlNNyUk2RZwwx2bZiVxakvA4OgRJCUOambzu3pGE
         4bqvNAACa/8YCBdu4rDkJo5TIVthyp2ULv6Umv3kE04jzM73qZzYIIMjNdwBWkMtC1p+
         aYHJ6f5RVaLZFYCWdheXLxCSSQIVd2rjtKdkZ+c4US7zYHr80MET6AWWk3/n0vsVp5d2
         beu7XXCFyNKpcpjqelEoJE0vZ/5xcPGDs/NUlv6ag4iXCu43OrhdQpN0vSIbxf66fwws
         vYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=fJthO6MUCq9ERN/kOkLb40SfK2NiNWqwIK1FuvDbRm8=;
        b=q9hajFZFpb4Heik2RMNWgFqyYFh2qnCffhAU4t6I1yTLZZ0QA2Wcg79wfSi7DS6OCt
         6RWfNHcB65kI1ZuSLrEk5Oglg7+MrEWM6E93fS/M04V+4isVwQAUdNkv9IZ9HTFt+cHR
         DiDeyEk8tE7zY6TvQymDluhGAbkZcTnK7YofL0osBo054Lu0DROnlK+rlCwR9suddCom
         Lmfhg5rT/U+F/Ez1YreLWouH4NQEn2+HtjfITjB4t2NdzmsADyF9XOHXbI0/LzjfLRF8
         JIqJ1PoiFhr2LH2LpCoCWDWe5F4vqCgbMAGT2Q95Kvy3SH9Z5neCA8+9LN2RFKL4T+IO
         mQrA==
X-Gm-Message-State: ACgBeo2glCoxdNBL5qnEAxWTo3/1COEoyKfnMtYyf0sQ/B+oV2COOMpm
        g0JRd777CiszyrJDDG/XlhHWeVvveLsjZzlx+R6t9uwj
X-Google-Smtp-Source: AA6agR455lyvIhATqiL8qEAOVYdtNrYOuakASBaxRi7jUStVFcr/DLYuU8dZtck3gVyU33csQbeK6/9gE1zLZtINmfM=
X-Received: by 2002:ae9:f40b:0:b0:6ba:c027:8d2d with SMTP id
 y11-20020ae9f40b000000b006bac0278d2dmr7112179qkl.642.1661753086228; Sun, 28
 Aug 2022 23:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
In-Reply-To: <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Mon, 29 Aug 2022 08:04:35 +0200
Message-ID: <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Aug 29, 2022 at 1:20 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> On 2022/08/26 21:00, Peter Fr=C3=B6hlich wrote:
> > In commit 8ae720449fca4b1d0294c0a0204c0c45556a3e61 "libata: whitespace
> > fixes in ata_to_sense_error()" we find, among many actual whitespace
> > changes, another change that adds an entry for 0x40 to the stat_table.
> > ...
>
> See the code below that table definition. You can see this hunk:
>
>         if (drv_err) {
>                 /* Look for drv_err */
>                 for (i =3D 0; sense_table[i][0] !=3D 0xFF; i++) {
>                         /* Look for best matches first */
>                         if ((sense_table[i][0] & drv_err) =3D=3D
>                             sense_table[i][0]) {
>                                 *sk =3D sense_table[i][1];
>                                 *asc =3D sense_table[i][2];
>                                 *ascq =3D sense_table[i][3];
>                                 goto translate_done;
>                         }
>                 }
>         }

That's the sense_table, I was referring to the stat_table. That table
is consulted when we fail to convert via the sense_table.

> Are you using an SMR drive ? Getting an aligned write should not happen f=
or a
> regular disk as the kernel ensure alignments of IO to LBAs. But for SMR, =
it is
> possible to send a write command that is not aligned to a zone write poin=
ter
> position, resulting in an unaligned write error.

Which is why I am pretty sure that the "unaligned write" message is
spurious since I am writing to a plain old SSD. It's going to be hard
for a userspace program to generate a write that is no properly
aligned for the SSD.

Cheers,
Peter
