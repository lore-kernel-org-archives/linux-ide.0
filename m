From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.22-rc1-mm1: IDE compile error
Date: Wed, 16 May 2007 20:55:52 +0200
Message-ID: <20070516185552.GA4086@stusta.de>
References: <20070515201914.16944e04.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36466 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759214AbXEPSzz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 14:55:55 -0400
Content-Disposition: inline
In-Reply-To: <20070515201914.16944e04.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, May 15, 2007 at 08:19:14PM -0700, Andrew Morton wrote:
>...
> - Added an i386 early-startup development tree, as git-newsetup.patch ("H. 
>   Peter Anvin" <hpa@zytor.com>)
>...
> Changes since 2.6.21-mm2:
>...
>  git-newsetup.patch
>...
>  git trees
>...

This breaks the compilation of the oldest of our IDE disk drivers:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `hd_init':
hd.c:(.init.text+0x44a7d): undefined reference to `drive_info'
hd.c:(.init.text+0x44a89): undefined reference to `drive_info'
hd.c:(.init.text+0x44a95): undefined reference to `drive_info'
hd.c:(.init.text+0x44aa1): undefined reference to `drive_info'
hd.c:(.init.text+0x44aad): undefined reference to `drive_info'
drivers/built-in.o:hd.c:(.init.text+0x44ab9): more undefined references to `drive_info' follow
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Considering the fact that we have two more recent drivers with the same 
functionality, it might be an option to simply remove this driver...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

