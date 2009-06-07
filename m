From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] pdc202xx_old: use ide_dma_test_irq()
Date: Sun, 7 Jun 2009 14:55:46 +0200
Message-ID: <200906071455.46396.bzolnier@gmail.com>
References: <200906042329.13000.sshtylyov@ru.mvista.com> <4A28326E.2010406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:33552 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbZFGNox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 09:44:53 -0400
Received: by fxm9 with SMTP id 9so1594386fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Jun 2009 06:44:54 -0700 (PDT)
In-Reply-To: <4A28326E.2010406@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 04 June 2009 22:45:34 Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> > The driver's dma_test_irq() method, although tests some chip specific interrupt
> > bits, finally always relies on the SFF-8038i standard interrupt bit.  I see no
> > point in testing the bits that are not trusted anyway -- the driver should be
> > fully able to use the standard method implemetation, ide_dma_test_irq().
> >
> > With this change 'pdc202xx_dma_ops' finally becomes identical to 'sff_dma_ops',
> > and we can get rid of it...
> >
> > ---
> > The patch is against the ide-2.6.git 'for-next' branch, atop of 2 patches
> > sent recently...
> >
> > I'll probably revive the remomed code as a part of the test_irq() method...
> >
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >   
> 
>   Oops, put signoff under tearline again. Bart, hopefully you'll be able 
> to handle that... :-)

I somehow managed to fix it... ;)

applied 1-3
