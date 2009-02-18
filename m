From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: linux-next: Tree for February 12 (ide)
Date: Wed, 18 Feb 2009 19:58:18 +0100
Message-ID: <200902181958.18733.bzolnier@gmail.com>
References: <20090212194408.ff7489c1.sfr@canb.auug.org.au> <200902171519.27031.bzolnier@gmail.com> <499C42A8.7060003@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <499C42A8.7060003@oracle.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-ide@vger.kernel.org

On Wednesday 18 February 2009, Randy Dunlap wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 12 February 2009, Randy Dunlap wrote:
> >> Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20090211:
> >>
> >> When
> >> # CONFIG_BLK_DEV_IDEDMA is not set
> >>
> >> linux-next-20090212/drivers/ide/ide-taskfile.c:108: error: 'ide_dma_intr' undeclared (first use in this function)
> > 
> > Thanks for spotting this, I fixed it in the revised patch:
> 
> Hi Bart,
> 
> Have you pushed this patch yet?
> 
> linux-next (20090218) is still getting this IDE build error.

I got caught by some other things yesterday so this was pushed
out today.  Sorry about confusion/delay.

Thanks,
Bart
