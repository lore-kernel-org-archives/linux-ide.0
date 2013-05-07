From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [GIT PULL] libata maintainership update
Date: Tue, 07 May 2013 21:34:39 +0400
Message-ID: <51893B2F.6070602@cogentembedded.com>
References: <20130507171921.GB5531@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:49217 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab3EGRel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 May 2013 13:34:41 -0400
Received: by mail-la0-f47.google.com with SMTP id fh20so848454lab.34
        for <linux-ide@vger.kernel.org>; Tue, 07 May 2013 10:34:39 -0700 (PDT)
In-Reply-To: <20130507171921.GB5531@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 07-05-2013 21:19, Tejun Heo wrote:

> As discussed earlier, Jeff is leaving for something more fun and I'm
> inheriting the maintainership of libata.  Please pull from the
> following branch to receive MAINTAINERS update.

>    git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.10

> I'll manage it similarly to other trees I'm maintaining.  When X-rc1
> drops, for-X-fixes and for-X+1 are created on top of it and for-next
> will be pulling in both branches.

> Thanks!

> --
> tejun

> ----------------------------------------------------------------
> Tejun Heo (1):
>        libata: change maintainer

>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1f5fac..c5ed056 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7140,7 +7140,7 @@ F:	drivers/misc/phantom.c
>   F:	include/uapi/linux/phantom.h
>
>   SERIAL ATA (SATA) SUBSYSTEM
> -M:	Jeff Garzik <jgarzik@pobox.com>
> +M:	Tejun Heo <tj@kernel.org>
>   L:	linux-ide@vger.kernel.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

    I think you've forgotten to update the git tree to yours.

MBR, Sergei

