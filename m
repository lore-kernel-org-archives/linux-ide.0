From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix wrong __init usage in IDE PCI drivers
Date: Wed, 19 Jan 2005 12:42:19 +0100
Message-ID: <20050119114219.GA10965@lst.de>
References: <20050109131959.GA20622@lst.de> <58cb370e05011417376956cfcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:52180 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261695AbVASLm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jan 2005 06:42:27 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e05011417376956cfcb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Sat, Jan 15, 2005 at 02:37:36AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Sun, 9 Jan 2005 14:19:59 +0100, Christoph Hellwig <hch@lst.de> wrote:
> > PCI probe routines (and funcions called by them) must use __devinit
> > as they can be called from PCI hotplug operations.
> > 
> > While most of the drivers touched in the patch are for hardware that's
> > soldered on mainboards we now have a fake PCI HP driver that allows
> > hot remove / replug for them which they need to handle.
> 
> Ugh... I really hate (lack of) flexibility of CONFIG_HOTPLUG...
> 
> Shouldn't we have __fakedev{init,exit} ?

This really gets a little too complex.  We also tended to trade a tiny
bit of vasted memory over complexity all the time in Linux's past..
