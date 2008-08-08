From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] drivers/ide/pci/: use __devexit_p()
Date: Fri, 8 Aug 2008 18:14:58 +0200
Message-ID: <200808081814.58997.bzolnier@gmail.com>
References: <20080807164539.GA26947@flint.arm.linux.org.uk> <20080807170932.GC9692@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:19736 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbYHHQds (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 12:33:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so586955fgg.17
        for <linux-ide@vger.kernel.org>; Fri, 08 Aug 2008 09:33:46 -0700 (PDT)
In-Reply-To: <20080807170932.GC9692@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Thursday 07 August 2008, Adrian Bunk wrote:
> On Thu, Aug 07, 2008 at 05:45:39PM +0100, Russell King wrote:
> >...
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> > @@ -1594,7 +1594,7 @@ static int __devinit hpt366_init_one(struct pci_dev *dev, const struct pci_devic
> >  	return ret;
> >  }
> >  
> > -static void __devexit hpt366_remove(struct pci_dev *dev)
> > +static void hpt366_remove(struct pci_dev *dev)
> >...
> 
> Thanks for your report.
> 
> The code is buggy, but:
> - that's not the correct fix and
> - there are far more such bugs under drivers/ide/pci/
> 
> Patch below.
> 
> > Russell King
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> This patch adds missing __devexit_p's.
> 
> Reported-by: Russell King <rmk+lkml@arm.linux.org.uk>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied, thanks
