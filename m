Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF577C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 09:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLIJfx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLIJfw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2022 04:35:52 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE94F1F9C3
        for <linux-ide@vger.kernel.org>; Fri,  9 Dec 2022 01:35:51 -0800 (PST)
Date:   Fri, 09 Dec 2022 09:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1670578548; x=1670837748;
        bh=qJMSkQmWGkXtpYGGcZDEwbH32foECXJVe4sPVgL9PYg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Gab7YkigVb62Z8qiErTpLnXNYiYRS6wV8Y9v79RDHNCTPKuqHnyc3vW0mRzNpjNAN
         Qt+MzRNOClkLwhSfKsqr+AffkLhDXhgjWoZfP9zkxmEUlIrFufCkzOZ1cYelbManjc
         c9JJsPracnDGf0jxjLroHD4L+zSW7Ie1aIcR6J22b1kTf88cCgbNymg7hTq090nWP5
         D4164Dn5RyBX2+DHbwFqYSuRMq5qkHW4YERVNYMpZbcHXDbEQ3L+EorscKbj+gD2Cp
         UHF05X7C/Maix401IoW4wnadnRVbT81ZdDU8m1n9BhJyb29MTHwWcTzd+7r74vk7fP
         v+V8K8Z3qCv0w==
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
From:   Adam Vodopjan <grozzly@protonmail.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v3] libata/ahci: Fix PCS quirk application for suspend
Message-ID: <bzhQ9jwYSZq-dhfZRPhFi7RmdFRG1Fry0N0LBmvm0GLhDM_kl96AU3-XvVKaDYhPw-b4P2H_6AcYj5cQlB2IuzBqaz-F7bVyJvrxiG6tKws=@protonmail.com>
In-Reply-To: <2911ead1-c458-30f7-47a8-5cce343ddff6@opensource.wdc.com>
References: <OM8HSmyIGyT2XF-f70AR7JA5kLpuIYEu5mYEIpyUT-4CC-u7ezc6po32ZIGOSN_7PlsF0RhOvUs8HpVJiAHGrh2ytgiBEltBpz0MuKiy-vg=@protonmail.com> <2911ead1-c458-30f7-47a8-5cce343ddff6@opensource.wdc.com>
Feedback-ID: 34388925:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> Looks good now. I will queue this up for 6.2 and add cc: stable.
> Thanks.

Thanks for your reviews. Mby it is important to remind: branch 4.19.y is af=
fected as well. Older lts branches are OK.
