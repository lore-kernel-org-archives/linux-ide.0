From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the IRQ context
Date: Fri, 7 Aug 2009 19:27:36 +0200
Message-ID: <200908071927.36367.bzolnier@gmail.com>
References: <200907011835.27586.bzolnier@gmail.com> <200908071355.21648.bzolnier@gmail.com> <20090807.090158.45976865.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754458AbZHGR2O@vger.kernel.org>
In-Reply-To: <20090807.090158.45976865.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Friday 07 August 2009 18:01:58 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Fri, 7 Aug 2009 13:55:21 +0200
> 
> > On Wednesday 01 July 2009 22:47:29 David Miller wrote:
> >> Will get to it before the end of the weekend.
> >> 
> >> If I fail or abort, I'll integrate your version of the fix Bart, don't
> >> worry :)
> > 
> > Not that I'm worried but just out of curiosity..
> > 
> > Could you please tell me which week/month/year are we talking about here?
> 
> I became busier than I expected here in New York :-)

I would say that this is a bit unprofessional attitude which normally
is not accepted by PNAELV people.. :-)

> Actually both patches #4 and #5 are in my ide-next-2.6 tree, I just
> need to publish it out to kernel.org and update the patchwork status
> on these patches.

Are you trying to tell me that after 6 weeks there is still no public
tree to hold future IDE changes?

If this is indeed a case here I hope that it will get addressed ASAP.
