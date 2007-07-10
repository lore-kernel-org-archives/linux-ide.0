From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/12] piix/slc90e66: fix PIO1 handling in ->speedproc method
Date: Tue, 10 Jul 2007 21:50:37 +0200
Message-ID: <200707102150.38069.bzolnier@gmail.com>
References: <200707081536.54841.bzolnier@gmail.com> <46926A49.3020802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21068 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbXGJWEd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:33 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1434490ugf
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:32 -0700 (PDT)
In-Reply-To: <46926A49.3020802@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 09 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Don't call {piix,slc90e66}_dma_2_pio() for PIO modes in
> >   {piix,slc90e66}_tune_chipset().
> 
>     XFER_PIO_* switch cases might have been be deleted from 
> {piix,slc90e66}_dma_2_pio() then...

Uh, I overlooked these...

*_dma_2_pio() are to go away in the future so not a big issue...

> > * Add PIO1 handling to {piix,slc90e66}_tune_chipset().
> 
> > * Bump driver version.  
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
