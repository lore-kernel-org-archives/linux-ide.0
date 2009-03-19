From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] MAINTAINERS: move old ide-{floppy,tape} entries to
	CREDITS
Date: Thu, 19 Mar 2009 06:39:19 +0100
Message-ID: <20090319053919.GA24137@liondog.tnic>
References: <200903182201.32668.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:28050 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbZCSFj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2009 01:39:29 -0400
Content-Disposition: inline
In-Reply-To: <200903182201.32668.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gadi Oxman <gadio@netvision.net.il>, Paul Bristow <paul@paulbristow.net>

On Wed, Mar 18, 2009 at 10:01:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] MAINTAINERS: move old ide-{floppy,tape} entries to CREDITS
> 
> Ben Hutchings noticed that MAINTAINERS somehow still contain old
> ide-{floppy,tape} entries.  Fix it by moving them to CREDITS (kudos
> to Gadi and Paul for all the early hard work on ide-{floppy,tape}).
> 
> Cc: Gadi Oxman <gadio@netvision.net.il>
> Cc: Paul Bristow <paul@paulbristow.net>
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Borislav, maybe it would make sense to rename IDE/ATAPI CDROM DRIVER
> entry to IDE/ATAPI DRIVERS one nowadays (you're the one doing most of
> ATAPI work anyway :)?

... after you, of course :).

Fine with me. The easiest would be if you fold the change into the same patch.

> 
>  CREDITS     |    9 +++++++++
>  MAINTAINERS |   13 -------------
>  2 files changed, 9 insertions(+), 13 deletions(-)

-- 
Regards/Gruss,
    Boris.
