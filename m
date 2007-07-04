From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/15] ide: ide_find_best_pio_mode() fixes
Date: Wed, 4 Jul 2007 21:00:49 +0200
Message-ID: <200707042100.49245.bzolnier@gmail.com>
References: <200706302104.42299.bzolnier@gmail.com> <200707022005.01655.bzolnier@gmail.com> <468BC8A0.1080200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:12051 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723AbXGDSqG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 14:46:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so342651ugf
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 11:46:05 -0700 (PDT)
In-Reply-To: <468BC8A0.1080200@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 04 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > [PATCH] ide: ide_find_best_pio_mode() fixes (take 2)
> 
> > * Check IORDY bit for PIO modes > 2.
> 
> > * Some devices claim maximum PIO mode > 2 in id->tPIO, they were punished too
> >   severly for this by being limited to PIO_SLOW.  Limit them to PIO2 instead.
> 
> > v2:
> > * Fix PIO number being returned incorrectly instead of PIO mode
> >   (Noticed by Sergei).
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
