From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] it8213: PIO fixes (take 2)
Date: Wed, 18 Jul 2007 23:07:15 +0200
Message-ID: <200707182307.15403.bzolnier@gmail.com>
References: <200707132303.09330.bzolnier@gmail.com> <4698FE15.7010407@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:49159 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbXGRVHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 17:07:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325093ugf
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 14:07:14 -0700 (PDT)
In-Reply-To: <4698FE15.7010407@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Rename it8213_tuneproc() to it8213_tune_pio() and add it8213_tuneproc()
> >   wrapper.  Move finding of the best PIO mode to the new wrapper.
> 
> > * Add setting of transfer mode on the device to it8213_tuneproc().
> 
> > * Don't call it8213_dma_2_pio() for PIO modes in it8213_tune_chipset().
> 
> > * Use it8213_tuneproc() in it8213_config_drive_for_dma().
> 
> > v2:
> > * Remove PIO modes from it8213_dma_2_pio(), they are no longer needed there
> >   (Noticed by Sergei)
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
