Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8717AC433EF
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jan 2022 06:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbiA2G7J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Jan 2022 01:59:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46838 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiA2G7J (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2022 01:59:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C799260B89
        for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2022 06:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEC3C340E5;
        Sat, 29 Jan 2022 06:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643439548;
        bh=E0MqY4prVsWftCZM1IXJXyco+Y04DG6s1otCKgzUe+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itUxczfZRcn0OT7zRuIbunU4jf2mxjt8ck99qxjHIrxqr7zqkrX2w+3VYi93UaxTK
         SCk86l+FPWjyl7GlU/gNNcKslht3qHgzbznLWwGUzWiAYAu1NmZ3QcQn6jgrsrVbJv
         Pi6dZ/IM3Hr0y466/HgEcGS6abeBlKhBWZl0qH3A=
Date:   Sat, 29 Jan 2022 07:59:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Subject: Re: [GIT PULL] Revert ata fix for 5.17-rc2
Message-ID: <YfTluSca/ye+lmrn@kroah.com>
References: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jan 28, 2022 at 06:34:16PM +0200, Linus Torvalds wrote:
> On Fri, Jan 28, 2022 at 2:10 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > I forgot about the umn.edu situation and accepted a patch, which was the single
> > fix in my earlier pull request. This pull request reverts the patch. My
> > apologies for the noise.
> 
> Gaah. The patch looks valid, so I think reverting it just for the umn
> situation is not only noise, but a bit unnecessary.
> 
> I'm adding Greg to the cc, since he was the one most involved with
> that whole thing and maybe he feels otherwise, but I'll drop this
> revert for now on the assumption that it's fine.

It's up to you all, if you think the patch is correct, keep it for now.
I had review comments on it yesterday here:
	https://lore.kernel.org/all/YfQSdJgi4x5hN3Ee@kroah.com/

but it seems like it might be right.

I have contacted the university again, and they privately apologized and
have said they will stop contributing until the process we worked on is
in place.  Someone decided to ignore their administration's rules here
it seems :(

thanks,

greg k-h
