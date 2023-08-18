Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C35EE499B
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 23:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbjHRXvH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbjHRXvH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 19:51:07 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC543A9F;
        Fri, 18 Aug 2023 16:51:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0A092320055E;
        Fri, 18 Aug 2023 19:51:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 18 Aug 2023 19:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692402663; x=1692489063; bh=xBl0qbFSd6IRr
        eu7aGBHXSohTWVbQIhJkC/TtxWNF5E=; b=Ms8xyi1b0UdnSFbLGz7B/QdFx7pOw
        wMDTuI6f8clAUEcPQszcLooQC1XxausHcl4m8D0RLBpLcgLpLG3bv5zfu1K1aCgq
        5YPK0fzn1ZOSjPI2qVB14HylkS6SD0OV9wNPrBD02INU+cBtH/FW54/ZT1R4t8vt
        +otC4yO9+/M+VivYoKoBXGmC/eJ+Orazt75gI7j94xc8Qvp4QRnN6KCUDPR5nmJ+
        516sjePb+etR62eO9pSLUky3uKREWViHpRIA8xm74/l1MwcUOnExsGjqqvja7yNX
        ojFOJmyjCqjmyJ29d/NQpJUDrbR7dLZci8LmwyR/tGybs9ybSgHL0UkyA==
X-ME-Sender: <xms:5gPgZH8Wv4IPIndc5AM-rfUfhSjuJDeurAu_qUxonkfZuxawCk5hEA>
    <xme:5gPgZDvKnIDRb9Ulr49R_i12f1T3LNj84t_mlodcsqCAtpd4ysD1sZ0GYAFrgApF1
    L8tjrjByJBeTclqCks>
X-ME-Received: <xmr:5gPgZFB1NzCPJiYdl-nzHdsqrHN4cAPdXHlD5d6lwR5n0vtizmmUHVxAk6sj2NBsIypgcicrQWcE1qEdmsMrNUOshR5J8dJdjl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:5gPgZDc_piWmZED77GSnhsjfTxTWR1s9vKMZX30JgRapTq5ulGiJIw>
    <xmx:5gPgZMMYjJlWc4_yi0PLdOKVrB9tHdTO6NDHnl15s0REX30P23kjlw>
    <xmx:5gPgZFlZkK0YZVFMahvOH8Dc22EPu45xTxf6-Ld_BiKnF20JPhTpTg>
    <xmx:5wPgZJrjcEvyObDV01dxDJO8ycig0UxvxiHAYFqQMlzEx7EqGh0PoA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Aug 2023 19:51:00 -0400 (EDT)
Date:   Sat, 19 Aug 2023 09:51:15 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Michael Schmitz <schmitzmic@gmail.com>, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org
Subject: Re: [PATCH v2 2/3] ata: pata_falcon: add data_swab option to byte-swap
 disk data
In-Reply-To: <CAMuHMdVVWwaeMTd397z-=D6Cfp31i0a=y_R1OQqUuBytAXKyFQ@mail.gmail.com>
Message-ID: <80dcb737-6271-b0ef-6a7d-80b0a89e5e96@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com> <20230818071405.28581-3-schmitzmic@gmail.com> <16f01be8-de2e-4fb2-50c3-95f030e740ac@linux-m68k.org> <CAMuHMdVVWwaeMTd397z-=D6Cfp31i0a=y_R1OQqUuBytAXKyFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-385082581-1692402675=:3862"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-385082581-1692402675=:3862
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Fri, 18 Aug 2023, Geert Uytterhoeven wrote:

> On Fri, Aug 18, 2023 at 9:43=E2=80=AFAM Finn Thain <fthain@linux-m68k.org=
> wrote:
> > On Fri, 18 Aug 2023, Michael Schmitz wrote:

> > > --- a/drivers/ata/pata_falcon.c
> > > +++ b/drivers/ata/pata_falcon.c
> > > @@ -199,6 +205,8 @@ static int __init pata_falcon_init_one(struct pla=
tform_device *pdev)
> > >       ap->ioaddr.altstatus_addr       =3D ctl_base + io_offset;
> > >       ap->ioaddr.ctl_addr             =3D ctl_base + io_offset;
> > >
> > > +     ap->private_data =3D (void *)(uintptr_t)(pata_falcon_swap_mask =
>> (2 * pdev->id));
> > > +
> >
> > My compiler doesn't need that extra type cast in there...
>=20
> Because it's a 32-bit compiler ;-)
> With a 64-bit compiler, you would get
>=20
>     warning: cast to pointer from integer of different size
> [-Wint-to-pointer-cast]
>=20
> Alternatively, you can change pata_falcon_swap_mask from int to long.
>=20

I see. Thanks for clarifying that for me.
---1463811774-385082581-1692402675=:3862--
