From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] siimage: coding style cleanup (take 2)
Date: Sun, 27 Apr 2008 21:34:49 +0200
Message-ID: <200804272134.50035.bzolnier@gmail.com>
References: <200804222056.38802.sshtylyov@ru.mvista.com> <480E1C28.6090307@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:25296 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763358AbYD0TyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 15:54:19 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4628225fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Apr 2008 12:54:18 -0700 (PDT)
In-Reply-To: <480E1C28.6090307@superbug.co.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Tuesday 22 April 2008, James Courtier-Dutton wrote:
> Sergei Shtylyov wrote:
> >
> >  	/* return 1 if Device INTR asserted */
> >  	pci_read_config_byte(dev, addr, &dma_altstat);
> >  	if (dma_altstat & 8)
> > -		return 0;	//return 1;
> > +		return 0;	/* return 1; */
> > +
> >  	return 0;
> >  }
> >  
> >   
> This bit of code looks strange.
> The comment says return 1, but the return has been commented to return 0.
> But, if we return 0, why bother with the if test anyway?

Seems like we should remove this test (and the similar one in
siimage_mmio_dma_test_irq) for now?  Care to send a patch?

Thanks,
Bart
