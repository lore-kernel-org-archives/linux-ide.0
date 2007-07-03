From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] it821x: fix incorrect SWDMA mask
Date: Tue, 3 Jul 2007 21:08:33 +0200
Message-ID: <200707032108.33855.bzolnier@gmail.com>
References: <200707030145.59287.bzolnier@gmail.com> <468A5887.3010609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:28914 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872AbXGCU0v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:26:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so170452ugf
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 13:26:50 -0700 (PDT)
In-Reply-To: <468A5887.3010609@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 03 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > SWDMA modes are unsupported by it821x.  Attempts to tune SWDMA modes always
> > fail (due to sanity check in ->speedproc) and result in PIO being tuned.
> 
> > * Fix incorrect SWDMA mask so core code won't try these modes and will just
> >   tune PIO if no other DMA modes are available.
> 
> > * Bump driver version.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
