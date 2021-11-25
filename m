Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B2FC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 25 Nov 2021 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhKYWmF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:42:05 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51559 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238402AbhKYWkF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Nov 2021 17:40:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 016135C01ED;
        Thu, 25 Nov 2021 17:36:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 25 Nov 2021 17:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5zdxyc
        JIKRW4j7oFSN3KP5jOmnSpqaDy8dBhTuplRRA=; b=BENsBC6hRoybmKz9OYy6uA
        51cWrzOWpsN0EuMtNN+LjUSU2Y7R3j5ErS9CgHd9/kfq1ryZoNqZaWcCn1OCRjKL
        HlmiVH2a1IHiNoWCajIOJI+7s9XgmmgXUqzt3opsU1XFMuqCSiuS+ArqCnvIzeSn
        PwjX5mymESB/yCBW1yjgdhZ1bRzb8Vdd0dBoHtXPkupW3Xu/73UNLkgL++BeGyXm
        vqOcNUPJmPU040HnbFiadikkiQ/ELywj5UlogugRvT5eEbvqFN2iYboRI8Lmgfbk
        2fT1auPiG0r+Vjv3Dhr8Sb1L0+8Der9UhQTf2HOhW8GK5bChEfHzElNSfMGBe9fQ
        ==
X-ME-Sender: <xms:BBCgYfktbjoixWvZll1AFf0nhdP5HSt86SpCow2ojalg_Qtbgw-oDg>
    <xme:BBCgYS1luXXAzaLYnHo-mtyAh_v-KnecBCDnaDbpZmO_4ls7JZHfi_8yP49L6ymtk
    dQxkwwDGvtfvk58nX8>
X-ME-Received: <xmr:BBCgYVrasvPT7QO7vhO4PAMJS61tND7XNprtgwS1MgbU89HbNTOMY5elm0GgZ7bLBr2Fkmm0-iBiWRL_x2vGnV_nUIPiWYir8IY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedtgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:BBCgYXlALw_P9fJ0LLiHqbtsAjR0BRtCFA_xhFE4lz2KBwyfcLmIPw>
    <xmx:BBCgYd3t2oTER9Yg3avvfVC9fRGMD6mTZJRvRWYpDRAJDWRcvhiMDA>
    <xmx:BBCgYWtxjrHW_YX5nMf5qs03IvEebPOVXKljGA7s-4BRbJ0BxR3JGQ>
    <xmx:BBCgYYRaV0Kl9J6-M7rTFYXFLK7ybxxavy_PG0pDUH46Dtq5M9T4Zw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Nov 2021 17:36:50 -0500 (EST)
Date:   Fri, 26 Nov 2021 09:36:56 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
In-Reply-To: <CAMuHMdXy-XyR5PtczK9J1p_i=jugp4yq6JF8_MhVC1FMK5dtPw@mail.gmail.com>
Message-ID: <9713ea83-b4e7-4eee-5ab1-7fb2dccb4ccd@linux-m68k.org>
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org> <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com> <35a85d2f-ab6a-4ab7-85a8-626f1560a57d@linux-m68k.org>
 <CAMuHMdXy-XyR5PtczK9J1p_i=jugp4yq6JF8_MhVC1FMK5dtPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 25 Nov 2021, Geert Uytterhoeven wrote:

> 
> Yeah, you do have to be careful with macros that derive a size from the 
> type of the passed data.  The *{in,out}sw() functions do not suffer from 
> that: they are defined to operate on a 16-bit I/O register. It is very 
> unlikely these semantics will ever change.
> 
> Here I'm more worried about the other danger: keeping casts will silence 
> any warning that may be introduced in a future change to the driver 
> code.
> 

Fair enough. I'll send v2.
