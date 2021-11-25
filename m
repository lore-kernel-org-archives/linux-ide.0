Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF986C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 25 Nov 2021 01:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbhKYBLl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:11:41 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58255 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235652AbhKYBJk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2021 20:09:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3EB263201CCD;
        Wed, 24 Nov 2021 20:06:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 24 Nov 2021 20:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZZzaNw
        Uz3U4hcZU/AFAuT4cjKidA9gwJwj+D57cATy4=; b=nZWMSoR7w7Hvt3CKOZn7xR
        r2NAeHtQj4MEQldQl+6DpNqSfHtV49idMsU8Iaw80IGiw0rtSWebbmhxHZjkhXDj
        b+G3IWjSxpiwZEatIvOL44m/DKpmSpfobgTgIn1AiSxfbUdvKdSj3P5cVvhSclxd
        ifj8YcJaO3fzReVnNDLab7xUNuOU6wm0RLdNwbEMchecHZb0I191pMzsR35WtZpq
        7BANLjI33mQqmIyXOZU6NpyNabBc6YpCgmxoXnYb9E0vwgXGnGSZbRb8bUKOKYGf
        cSkSSLX6LQwBsMZzGYwT8+CGQA1Kc3HSXN11v0pLKxGTsoZ08QI3zEzwNZJlJiGw
        ==
X-ME-Sender: <xms:k-GeYeUxq7CRwD3cQTzGe1TAYcUIJsljQkoTYlZevGSTaaDFST_aVQ>
    <xme:k-GeYakYyuSyLIK2W-KorZUtfpijSU2Fm8Ecvmgmk6OB9_lZ_c-ntkBHOBn6agw8z
    CuIr4zGib9wpOE2MyI>
X-ME-Received: <xmr:k-GeYSauYD2B0HCvDnhSTWaeuHsGYUb9TEi8sV-l77fbCreswHyZmenQFlDzmqyw0NWeqQ0kks1Z13yt0pyZpg28gEJ13fCR7jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeelgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeekveevtdekfedtfefhvdfgleelfefhtdefieetjeejvefghfdufeejkeehgfeu
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrgh
X-ME-Proxy: <xmx:k-GeYVW2i8Jyyk2_cF3KYfcqKhl0EM1GJvkRcEDur15WQw5Si5vlhA>
    <xmx:k-GeYYnE7GMqLB7RLh4YkjkX3Y1b3FJG8Lt40KpQ-xSIq7bt8pqOsQ>
    <xmx:k-GeYadglcHeSXIt7voxRdhsx44cdMfAod5uYB62z1Mdpp9-n7DjPA>
    <xmx:lOGeYZCkUo1sz6CaEcUx68Q8AWkh9DBfqALgpO2853VhTWY5ReBE1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Nov 2021 20:06:24 -0500 (EST)
Date:   Thu, 25 Nov 2021 12:06:27 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
In-Reply-To: <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com>
Message-ID: <35a85d2f-ab6a-4ab7-85a8-626f1560a57d@linux-m68k.org>
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org> <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, 24 Nov 2021, Geert Uytterhoeven wrote:

> Thanks for your patch!
> 
> > --- a/drivers/ata/pata_falcon.c
> > +++ b/drivers/ata/pata_falcon.c
> > @@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
> >         /* Transfer multiple of 2 bytes */
> >         if (rw == READ) {
> >                 if (swap)
> > -                       raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
> >                 else
> > -                       raw_insw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_insw((u16 __iomem *)data_addr, (u16 *)buf, words);
> >         } else {
> >                 if (swap)
> > -                       raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
> >                 else
> > -                       raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_outsw((u16 __iomem *)data_addr, (u16 *)buf, words);
> 
> Can't you just drop the casts? data_addr is an __iomem void *.
> 

Yes, that works here (i.e. removing the data_addr casts and not the buf 
casts). But is it prudent?

Given the implementation of raw_in/out is subject to change, it seems like 
the original casts were defensive programming.

Here's an example of a recent regression that was fixed by casting a macro 
argument to a specific width:

https://lore.kernel.org/linuxppc-dev/79ae1f49-f6b1-e9ad-977d-0cc7e553c7b9@csgroup.eu/ 
https://lore.kernel.org/linuxppc-dev/08bbe7240b384016e0b2912ecf3bf5e2d25ef2c6.1636501628.git.fthain@linux-m68k.org/ 

BTW, that bug eventually got fixed using a different patch.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/powerpc/kernel/signal.h?id=5499802b2284331788a440585869590f1bd63f7f

Note that __get_user_sigset() still lacks width casts here, so it remains 
non-portable.
