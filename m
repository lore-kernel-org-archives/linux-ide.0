From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/6] amd74xx/via82cxxx: use ide_tune_dma()
Date: Fri, 13 Jul 2007 22:03:58 +0200
Message-ID: <200707132203.58580.bzolnier@gmail.com>
References: <200707110204.42227.bzolnier@gmail.com> <4697AEE4.9060001@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:44974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbXGMVbA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647448ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:31:00 -0700 (PDT)
In-Reply-To: <4697AEE4.9060001@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 13 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Use ide_tune_dma() in amd74xx/via82cxxx driver, this fixes following bugs:
> >   - DMA capability bit not being checked on the device
> >   - DMA blacklist not being checked
> >   - DMA mode being programmed even if drive->autodma == 0
> >     (thus possibly destroying PIO timings)
> 
> > * Bump driver version.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
