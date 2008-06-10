From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] fix BLK_DEV_HD_ONLY on ARM dependencies
Date: Tue, 10 Jun 2008 19:56:15 +0200
Message-ID: <200806101956.15711.bzolnier@gmail.com>
References: <20080609222155.GA1987@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758618AbYFJTQl@vger.kernel.org>
In-Reply-To: <20080609222155.GA1987@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
List-Id: linux-ide@vger.kernel.org

On Tuesday 10 June 2008, Adrian Bunk wrote:
> This patch limits BLK_DEV_HD_ONLY to the ARM platforms offering 
> IRQ_HARDDISK, fixing the following compile error on others:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/ide/legacy/hd.o
> ...
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'hd_times_out':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: 'IRQ_HARDDISK' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: (Each undeclared identifier is reported only once
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: for each function it appears in.)
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'do_hd_request':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:661: error: 'IRQ_HARDDISK' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'hd_init':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:765: error: 'IRQ_HARDDISK' undeclared (first use in this function)
> make[3]: *** [drivers/ide/legacy/hd.o] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied, thanks

BTW Could you look into converting your "remove BLK_DEV_HD_ONLY" patch
into "move old hd driver to drivers/block/" one because the old hd driver
still has some uses (as noticed by Alan)?
