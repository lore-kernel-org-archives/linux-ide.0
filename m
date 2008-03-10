From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] ide: constify struct ide_dma_ops
Date: Mon, 10 Mar 2008 22:53:30 +0100
Message-ID: <200803102253.30988.bzolnier@gmail.com>
References: <200803091702.18521.bzolnier@gmail.com> <47D417DD.20404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:52913 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYCJXMy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 19:12:54 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2142906fga.17
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 16:12:51 -0700 (PDT)
In-Reply-To: <47D417DD.20404@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Sunday 09 March 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Export ide_dma_exec_cmd() and __ide_dma_test_irq().
> 
> > * Constify struct ide_dma_ops.
> 
> > * Always set hwif->dma_ops to &sff_dma_ops in ide_setup_dma()
> >   (it is later overriden by ide_init_port() if needed) and drop
> >   'const struct ide_port_info *d' argument.
> 
> > While at it:
> 
> > * Rename __ide_dma_test_irq() to __ide_dma_test_irq().
> 
>     Huh? :-)

thanks, fixed (the latter should be ide_dma_test_irq() of course)
