From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.22-rc1-mm1: IDE compile error
Date: Thu, 24 May 2007 01:45:37 +0200
Message-ID: <200705240145.38055.bzolnier@gmail.com>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <20070516185552.GA4086@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:2956 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759778AbXEXBYC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 21:24:02 -0400
Received: by ug-out-1314.google.com with SMTP id 70so758443ugb
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 18:24:01 -0700 (PDT)
In-Reply-To: <20070516185552.GA4086@stusta.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Wednesday 16 May 2007, Adrian Bunk wrote:
> On Tue, May 15, 2007 at 08:19:14PM -0700, Andrew Morton wrote:
> >...
> > - Added an i386 early-startup development tree, as git-newsetup.patch ("H. 
> >   Peter Anvin" <hpa@zytor.com>)
> >...
> > Changes since 2.6.21-mm2:
> >...
> >  git-newsetup.patch
> >...
> >  git trees
> >...
> 
> This breaks the compilation of the oldest of our IDE disk drivers:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `hd_init':
> hd.c:(.init.text+0x44a7d): undefined reference to `drive_info'
> hd.c:(.init.text+0x44a89): undefined reference to `drive_info'
> hd.c:(.init.text+0x44a95): undefined reference to `drive_info'
> hd.c:(.init.text+0x44aa1): undefined reference to `drive_info'
> hd.c:(.init.text+0x44aad): undefined reference to `drive_info'
> drivers/built-in.o:hd.c:(.init.text+0x44ab9): more undefined references to `drive_info' follow
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> Considering the fact that we have two more recent drivers with the same 
> functionality, it might be an option to simply remove this driver...

Care to send a patch?

Thanks,
Bart
