From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] scc_pata.c: Workaround for errata A308 (take 2)
Date: Thu, 19 Jul 2007 01:15:11 +0200
Message-ID: <200707190115.12050.bzolnier@gmail.com>
References: <200707170307.l6H37e8u003922@toshiba.co.jp> <200707182247.02664.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:3290 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbXGRW5M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 18:57:12 -0400
Received: by ik-out-1112.google.com with SMTP id b32so345526ika
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 15:57:09 -0700 (PDT)
In-Reply-To: <200707182247.02664.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: sshtylyov@ru.mvista.com, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

On Wednesday 18 July 2007, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 17 July 2007, Akira Iguchi wrote:
> > Workaround for errata A308: turn down the UDMA mode and retry
> > the DMA command when the data lost condition is detected.
> > 
> > take2:
> > udma_filter() hook is used to limit ATAPI UDMA mode.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> > Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> > ---

applied

> The previous patch has already been merged so please rediff this one
> to contain only the new changes.

Ergh, thinko on my side -- no need for new patch.

I applied the previous version to my tree but due some circustances
IDE update for Linus got delayed so I haven't pushed it yet.

Sorry for the confusion.

Bart
