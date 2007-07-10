From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/12] it8213: PIO fixes
Date: Tue, 10 Jul 2007 21:52:38 +0200
Message-ID: <200707102152.38274.bzolnier@gmail.com>
References: <200707081535.12938.bzolnier@gmail.com> <46926AE1.8020004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21068 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbXGJWEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1434490ugf
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:33 -0700 (PDT)
In-Reply-To: <46926AE1.8020004@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 09 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Rename it8213_tuneproc() to it8213_tune_pio() and add it8213_tuneproc()
> >   wrapper.  Move finding of the best PIO mode to the new wrapper.
> 
> > * Add setting of transfer mode on the device to it8213_tuneproc().
> 
> > * Don't call it8213_dma_2_pio() for PIO modes in it8213_tune_chipset().
> 
>    Again, XFER_PIO_* switch cases might have been be deleted from 
> it8213_dma_2_pio() then... Though the idea was to part with this function 
> completely -- to be done yet...

yes TBD :)

> > * Use it8213_tuneproc() in it8213_config_drive_for_dma().
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
