From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] export ide_doubler
Date: Tue, 10 Jun 2008 19:49:32 +0200
Message-ID: <200806101949.33005.bzolnier@gmail.com>
References: <20080609222207.GC1987@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758312AbYFJTQY@vger.kernel.org>
In-Reply-To: <20080609222207.GC1987@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 10 June 2008, Adrian Bunk wrote:
> This patch fixes the following build error:
> 
> <--  snip  -->
> 
> ...
>   Building modules, stage 2.
>   MODPOST 1204 modules
> ERROR: "ide_doubler" [drivers/ide/ide-core.ko] undefined!
> ...
> make[2]: *** [__modpost] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied
