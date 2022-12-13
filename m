Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38384C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 13 Dec 2022 12:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiLMMJv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Dec 2022 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiLMMJp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2022 07:09:45 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C628164B7
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2022 04:09:42 -0800 (PST)
Date:   Tue, 13 Dec 2022 12:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1670933377; x=1671192577;
        bh=oTRxxX9Enq5UALY44k55FURulBH7TW1CgVUR/Z6iCp4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=opEgIpNVkpV2v+KDqqA10gTrVvfpd3k2mPGA1I+S6a5SyvRhIqhe+Zcn//krfLhWd
         TKF4dEfeBqrJNS4l/UEh7Mg5OQbYA+B9FdqkAJPbzTJRHax86BOT4PkzdcVahUncrC
         vkDcuxVgtnNc7ckNyj/I9gI1wExvby6TB9+1aOZFoBA6gdgofGC/GaK5JXoZfV6Ead
         ZJa/rqRvFcl8+tnkMXsqvWSsezw1Ol5wG/N+YnbAuRNnpAtmoY+K1H/5T8NGWFCFSh
         bXn82MMeYH/YHJhzshZ9b3xf3PJnPyIJ1LC78lgE6i5zWK1iqTI0xuh97urBFyjqEy
         3J27UZt2PZkkQ==
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
From:   Adam Vodopjan <grozzly@protonmail.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v4] ata: ahci: Fix PCS quirk application for suspend
Message-ID: <J-BrMQVYN_WppNY1mlrEbV9PFxp3OqCk7wFHE20Vto93A03Zl4fA8y0uYRyxWCARZzEz_hRlTmDgCQR76RalCeKwVZL5zkkcz_Dx9HvSRM0=@protonmail.com>
In-Reply-To: <ada4443a-0c80-b689-936f-93cefe06fb2c@opensource.wdc.com>
References: <vl5wEUZGVJ2BjH9t6T0GGSs9qLIE5A7NQkpDYGJB6iFamXyhw1zjnrx-TeO-XJB2doendW_7lDvNblGJLb_YeehRZN0iyUHXyvdQ6Em1aXI=@protonmail.com> <yYZw0u5_0qQf-imEIyKpbp2kriN50kP7Ig_mWjSDAUNHfPQaRlmcBdz_PLuf9vAR6EmuwLWvr15o2duq83yeE7wzcxs3TIVvWQU54-xZfWU=@protonmail.com> <ada4443a-0c80-b689-936f-93cefe06fb2c@opensource.wdc.com>
Feedback-ID: 34388925:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tuesday, December 13th, 2022 at 1:38 PM, Damien Le Moal <damien.lemoal@o=
pensource.wdc.com> wrote:

> On 12/13/22 19:37, Adam Vodopjan wrote:
>=20
> > Damien, have you seen this version of the patch?
>=20
>=20
> Yes. It looks OK. Missing the Cc stable tag, but I will add it when
> applying. I will send this as a fix once 6.2-rc1 is out in a couple of
> weeks (merge window open yesterday).
>=20

Thanks
