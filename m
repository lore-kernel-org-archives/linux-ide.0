From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/12] cs5535: PIO fixes
Date: Fri, 13 Jul 2007 21:49:47 +0200
Message-ID: <200707132149.47631.bzolnier@gmail.com>
References: <200707081534.31610.bzolnier@gmail.com> <46979A07.2030100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:44974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbXGMVa6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:30:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647448ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:30:58 -0700 (PDT)
In-Reply-To: <46979A07.2030100@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 13 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Fix cs5535_tuneproc() to pass PIO transfer mode value instead of PIO mode
> >   number to cs5535_set_speed() (fixes random PIO timings being programmed
> >   and a possible OOPS).  Do a little cleanup while at it.
> 
> > * Fix cs5535_set_speed() to check if the mate device is present (fixes PIO0
> >   taskfile timings being used if there is no other device on the cable).
> 
> > * Use cs5535_tuneproc() in cs5535_dma_check().  The old code had the same
> >   issue as cs5535_tuneproc() and add additionally caused 0x00-0x04 transfer
> >   mode values (== default PIO, default PIO w/ IORDY + two invalid values)
> >   being set on the device instead of values 0x08-0x0c (XFER_PIO_[0,4]).
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
