From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Wed, 27 Oct 2004 18:22:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <58cb370e04102709221d6a9103@mail.gmail.com>
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	 <200410271215.55472.gene.heskett@verizon.net>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262507AbUJ0Q3N@vger.kernel.org>
In-Reply-To: <200410271215.55472.gene.heskett@verizon.net>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 27 Oct 2004 12:15:55 -0400, Gene Heskett
<gene.heskett@verizon.net> wrote:
> On Wednesday 27 October 2004 09:07, Bartlomiej Zolnierkiewicz wrote:
> >Please do a
> >
> > bk pull bk://bart.bkbits.net/ide-2.6
> >
> >This will update the following files:
> >
> > drivers/ide/ide-disk.c         |    1 +
> > drivers/ide/ide-dma.c          |   32
> 
> Even after fixing the 4 wrapped lines in the patch, I'm not going in
> cleanly here:
> 
> patching file drivers/ide/ide-dma.c
> Hunk #1 FAILED at 681.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/ide/ide-dma.c.rej
> 
> The first 'grep' line of the patch is found at an offset of about +180
> lines in the original file.
> 
> The rest of it seems to have found a home, but at offsets in excess of
> 159 lines for a few of them.
> 
> This was against a 2.6.9 tree, and 2.6.9-mm1 failed in similar
> fashion.  What src tree is this to be applied to?

current linus' -bk tree, latest -bk snapshot should also be OK
