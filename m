From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.22-rc1-mm1: IDE compile error
Date: Thu, 24 May 2007 11:55:49 +0100
Message-ID: <20070524115549.01c0e1ca@the-village.bc.nu>
References: <20070515201914.16944e04.akpm@linux-foundation.org>
	<20070516185552.GA4086@stusta.de>
	<200705240145.38055.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:36403 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755855AbXEXKxB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 06:53:01 -0400
In-Reply-To: <200705240145.38055.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > hd.c:(.init.text+0x44a7d): undefined reference to `drive_info'
> > hd.c:(.init.text+0x44a89): undefined reference to `drive_info'
> > hd.c:(.init.text+0x44a95): undefined reference to `drive_info'
> > hd.c:(.init.text+0x44aa1): undefined reference to `drive_info'
> > hd.c:(.init.text+0x44aad): undefined reference to `drive_info'
> > drivers/built-in.o:hd.c:(.init.text+0x44ab9): more undefined references to `drive_info' follow
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > 
> > <--  snip  -->
> > 
> > Considering the fact that we have two more recent drivers with the same 
> > functionality, it might be an option to simply remove this driver...
> 
> Care to send a patch?

hd.c can drive MFM and RLL disks and drivers/ide cannot. Although it
really wants burying further down the config tree the ability to read MFM
and RLL disks when recovering ancient data is useful and people do
actually use this driver now and then rescuing stuff like twenty year old
datasets.

It thus needs fixing not removing.


Alan
