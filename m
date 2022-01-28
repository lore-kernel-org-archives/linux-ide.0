Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD46C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 28 Jan 2022 16:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245711AbiA1Q5E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:57:04 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36676 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245611AbiA1Q5E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 11:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643389024;
        bh=z9V+FuNc4VxQabZ/DvZ/nfCZvRjnNV9w47fBqD3AAjo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=G0jdQT4Zp8POZsWTo0/EdgBGIPPRgBMb9PK1P2tB/dAqzFpGZwsgND5eOBWvGHcb7
         qOkJyUUGoBJt2kTPWHJ/LSzMg+YfFj3dgRAbOjfpGr0KF1R8mQmrdCeMRdT+XtltEV
         61jtpVdbze6Q5PRTjss7lkzT3CANUHnGGfIW1vPk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2FBC01280A9A;
        Fri, 28 Jan 2022 11:57:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nAMDJXbMctJL; Fri, 28 Jan 2022 11:57:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643389024;
        bh=z9V+FuNc4VxQabZ/DvZ/nfCZvRjnNV9w47fBqD3AAjo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=G0jdQT4Zp8POZsWTo0/EdgBGIPPRgBMb9PK1P2tB/dAqzFpGZwsgND5eOBWvGHcb7
         qOkJyUUGoBJt2kTPWHJ/LSzMg+YfFj3dgRAbOjfpGr0KF1R8mQmrdCeMRdT+XtltEV
         61jtpVdbze6Q5PRTjss7lkzT3CANUHnGGfIW1vPk=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AA8181280A71;
        Fri, 28 Jan 2022 11:57:03 -0500 (EST)
Message-ID: <06c7c6ade058b2ac4684be932cff5193aa3b31b2.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] Revert ata fix for 5.17-rc2
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org
Date:   Fri, 28 Jan 2022 11:57:02 -0500
In-Reply-To: <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
References: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
         <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 2022-01-28 at 18:34 +0200, Linus Torvalds wrote:
> On Fri, Jan 28, 2022 at 2:10 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> > I forgot about the umn.edu situation and accepted a patch, which
> > was the single
> > fix in my earlier pull request. This pull request reverts the
> > patch. My
> > apologies for the noise.
> 
> Gaah. The patch looks valid, so I think reverting it just for the umn
> situation is not only noise, but a bit unnecessary.
> 
> I'm adding Greg to the cc, since he was the one most involved with
> that whole thing and maybe he feels otherwise, but I'll drop this
> revert for now on the assumption that it's fine.

The patch as fixed by Damien looks reasonable, although I don't think
it actually fixes anything ... if we get an ENOMEM there the system
won't boot because you likely can't contact your root drive, so an oops
would make the point more vividly.

However, the original patch:

https://lore.kernel.org/all/20220124164525.53068-1-zhou1615@umn.edu/

does look suspiciously like a fishing attempt to see if we'd notice the
logic inversion in the supposed null check.

James


