From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Wed, 18 Nov 2009 20:56:16 +0100
Message-ID: <200911182056.16517.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <20091118184125.623e063d@lxorguk.ukuu.org.uk> <200911182007.07405.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:34271 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758281AbZKRT51 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 14:57:27 -0500
In-Reply-To: <200911182007.07405.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 18 November 2009 20:07:07 Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 18 November 2009 19:41:25 Alan Cox wrote:
> > > Maybe they are 'stable' but when it comes to features they are behind hpt366
> > > (i.e. they lack PCI PM), which is also much cleaner than your drivers, easier
> > > to understand and much smaller..
> > 
> > 37x and 3xn lack PCI PM.  Added to the TODO list.
> > 
> > The smaller size is a bit questionable given its mostly comments, and
> > three drivers versus one.
> 
> I wonder what you find 'questionable' in the numbers given..

BTW we can immediately reclaim 300 LOC by simply merging drivers back..

> > themselves don't keep common. Even more importantly we get to break *one*
> > type of device at a time.
> 
> I prefer to not break anything, but hey my way of doing things is not
> very much welcomed here..
> 
> I also like to think that by sharing code we get better testing coverage
> and are in reality able to fix problems much faster because of this..

Wait, you seem to be right!

Only pata_hpt37x has broken cable detection while pata_hpt3x2n is okay. ;)

-- 
Bartlomiej Zolnierkiewicz
