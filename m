From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] fix wrong __init usage in IDE PCI drivers
Date: Thu, 3 Feb 2005 15:26:09 +0100
Message-ID: <58cb370e050203062679e156e4@mail.gmail.com>
References: <20050109131959.GA20622@lst.de>
	 <58cb370e05011417376956cfcb@mail.gmail.com>
	 <20050119114219.GA10965@lst.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:33606 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263368AbVBCO0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 09:26:14 -0500
Received: by wproxy.gmail.com with SMTP id 67so259833wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 06:26:11 -0800 (PST)
In-Reply-To: <20050119114219.GA10965@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hi,

On Wed, 19 Jan 2005 12:42:19 +0100, Christoph Hellwig <hch@lst.de> wrote:
> On Sat, Jan 15, 2005 at 02:37:36AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Sun, 9 Jan 2005 14:19:59 +0100, Christoph Hellwig <hch@lst.de> wrote:
> > > PCI probe routines (and funcions called by them) must use __devinit
> > > as they can be called from PCI hotplug operations.
> > >
> > > While most of the drivers touched in the patch are for hardware that's
> > > soldered on mainboards we now have a fake PCI HP driver that allows
> > > hot remove / replug for them which they need to handle.

Heh, hot remove is unsupported currently so this is not a problem
at the moment.  I queued your patch to be merged after hotplug is fixed.

> > Ugh... I really hate (lack of) flexibility of CONFIG_HOTPLUG...
> >
> > Shouldn't we have __fakedev{init,exit} ?
> 
> This really gets a little too complex.  We also tended to trade a tiny
> bit of vasted memory over complexity all the time in Linux's past..
 
agreed
