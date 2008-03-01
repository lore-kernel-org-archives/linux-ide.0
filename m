From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 00/24] ide-tape: remove pipelined mode operation
Date: Sat, 1 Mar 2008 12:20:38 +0200
Message-ID: <20080301102038.GC25835@cs181133002.pp.htv.fi>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:50392 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755188AbYCAKWD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Mar 2008 05:22:03 -0500
Content-Disposition: inline
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, Jens Axboe <jens.axboe@oracle.com>

On Sat, Mar 01, 2008 at 09:58:24AM +0100, Borislav Petkov wrote:
> Hi Bart,
> 
> here's the 1st draft of the pipeline removal series. As the diffstat below openly
> states it, a lot of code got removed - even more than the cleanup series we did
> earlier.
>...

After seeing commit d48567dd43868b3d2e1fcc33ee76dc2d38a1ddeb that 
schedules ide-tape for removal I'm wondering whether any cleanups of 
this driver make any sense at all:

What:   ide-tape driver
When:   July 2008
Files:  drivers/ide/ide-tape.c
Why:    This driver might not have any users anymore and maintaining it for no
        reason is an effort no one wants to make.
Who:    Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov
        <petkovbb@googlemail.com>


Your patches will go in 2.6.26 and the driver will be removed
in 2.6.27 ...


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

