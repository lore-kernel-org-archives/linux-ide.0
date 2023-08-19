Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD06EE499F
	for <linux-ide@archiver.kernel.org>; Sat, 19 Aug 2023 00:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbjHSAHC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 20:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243072AbjHSAHC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 20:07:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5941C3ABC;
        Fri, 18 Aug 2023 17:07:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3365432002E2;
        Fri, 18 Aug 2023 20:07:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 18 Aug 2023 20:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692403619; x=1692490019; bh=Wf2yENCS4slD4
        iYjol1D6Wq9V+hMbXohj61/r/7WV+k=; b=mw1nKA2mqPBhd3BIP/XbuG70KgU+8
        +EF5tK3GcMww8+G+56gyj58bMaWm9ZjjAa8ga6NMSs8g4MeP8OoY3Mzu9tND1bvs
        oIbzCPhUX+bx9jE6V9Gu+3Bz3NOap1G2hGfmbrCUKMxI5Nl5z8OQuzDwxUURybbe
        wsN8RE//l9uHnCRJ13aFl80kCIp9V4KjqFRkpd/aTExDOz84x/T+NWJGY7tapvAS
        IoxKyfeRHY92EihM9AuMWeCiDc1Yv9Y5M7/DhK52cAyl83hZkT6GLfjTAsTYXkMK
        FV8/KQQe4Rxgl7dQmpxDAvaUrPEO2WWZlPveITtEb2pggCip7BjA/0BOg==
X-ME-Sender: <xms:owfgZFy7meEZNldcsVxZrd7fCoQKC3c8fc1ifqFW0FOtCXm5P1JwTg>
    <xme:owfgZFSKj_UDCuIOtMAss0P4asmNz5f3EzAXvxt1HKFBf9BwEgi9Bjld89VdYgY0E
    mht441AahsCec0n4g4>
X-ME-Received: <xmr:owfgZPW1Ndmk5VaSpA4SLZqoVcsEp5Bwm1S7GPxPbmtqFiq73Wc29-l0DQm3b69xSCWUavkIvF5NRX5vq0FiaItTBzcnSesCeg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:owfgZHgDGDaMbgsnWKAwodkK_r2Y3OydQqcgRx_ym55r__RJlI2m8w>
    <xmx:owfgZHAOOxoZzyW12W2v6J433ZxO6XQhU50IANR8lXIP5opu-QH0Nw>
    <xmx:owfgZAJiRCpamZxUH_2r2z3e9bEB-tDqehsA5kU9gimq18eAgFrUgg>
    <xmx:owfgZC9TuXSrnmhbWzZ-eLJkV-HlaivlcJvkEqaoCEWTX15k2i4zVg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Aug 2023 20:06:57 -0400 (EDT)
Date:   Sat, 19 Aug 2023 10:07:14 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org
Subject: Re: [PATCH v2 3/3] m68k/atari: change Falcon IDE platform device to
 id 0
In-Reply-To: <41d64e82-5995-4e5c-68f5-3e9248ece153@gmail.com>
Message-ID: <5cb447ce-6436-38e1-b6e9-8a5547202a47@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com> <20230818071405.28581-4-schmitzmic@gmail.com> <CAMuHMdUkzk9DxAicq7U5yp3LT0mzaP+tgbwcSYNFx7sripBDcg@mail.gmail.com> <41d64e82-5995-4e5c-68f5-3e9248ece153@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On Sat, 19 Aug 2023, Michael Schmitz wrote:

> >
> > Iff this patch is accepted, it must go in before [PATCH v2 2/3], else 
> > the latter would cause a regression. And backporting to stable must 
> > take that into account, too.
> 
> I don't see it as a regression - the driver still works OK, it's only 
> the byte swap option that's broken on Atari, and that's newly 
> introduced.
> 
> But this patch changes the user space exposed platform device name, as 
> you point out elsewhere. That's reason enough to drop it.
> 

Such a script would be broken on q40 already.

When a fix has a dependency on a separate patch you can backport both by 
specifying a cherry-picking sequence. We may need Geert to add those 
commit hashes though. This is discussed in 
Documentation/process/stable-kernel-rules.rst
