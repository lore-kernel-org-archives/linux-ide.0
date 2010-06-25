From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] ahci_platform: Provide for vendor specific init
Date: Fri, 25 Jun 2010 11:48:24 +0400
Message-ID: <20100625074824.GA2809@oksana.dev.rtsoft.ru>
References: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
 <4C245A42.1070203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61649 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab0FYHsb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 03:48:31 -0400
Received: by bwz7 with SMTP id 7so554229bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 25 Jun 2010 00:48:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C245A42.1070203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-ide@vger.kernel.org, Jassi Brar <jassi.brar@samsung.com>

On Fri, Jun 25, 2010 at 03:26:58AM -0400, Jeff Garzik wrote:
> On 06/25/2010 12:57 AM, Jassi Brar wrote:
> >From: Jassi Brar<jassi.brar@samsung.com>
> >
> >Some AHCI implementations may use Vendor Specific HBA[A0h, FFh]
> >and/or Port[70h, 7Fh] registers to 'prepare' for initialization.
> >For that, the platform needs memory mapped address of AHCI registers.
> >
> >This patch adds the 'mmio' argument and reorders the call to
> >platform init function.
> >
> >Signed-off-by: Jassi Brar<jassi.brar@samsung.com>
> >---
> >  drivers/ata/ahci_platform.c   |   23 +++++++++++++----------
> >  include/linux/ahci_platform.h |    2 +-
> >  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> It is also possible that platforms may need the init to prep the
> MMIO area for use?  Anton, does this patch work for you, or
> introduce such a problem?

Currently it doesn't introduce such a problem, but you're right,
platforms might need to, for example, turn on the clocks before
the MMIO area becomes accessible (otherwise machine check
exception might arrive).

There are two options: introduce a ->post_init() hook, or just
make sure that ahci_platform driver won't start accessing the
mmio region between ioremap() and pdata->init() calls. I think
a simple comment in the code will suffice, so no need for the
additional hook.

And if we ever need some hook before ioremap(), we can name it
pre_init().

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
