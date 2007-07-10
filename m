From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 8/12] scc_pata: PIO fixes
Date: Tue, 10 Jul 2007 21:53:23 +0200
Message-ID: <200707102153.23901.bzolnier@gmail.com>
References: <200707081537.45090.bzolnier@gmail.com> <46927290.3040205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21068 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbXGJWEg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1434490ugf
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:35 -0700 (PDT)
In-Reply-To: <46927290.3040205@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 09 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Use pio == 255 == "auto-tune" in scc_config_drive_for_dma() instead of
> >   forcing PIO4 on PIO fallback.  Fix comment while at it.
> 
> > * Rename scc_tuneproc() to scc_tune_pio() and add scc_tuneproc() wrapper.
> >   Move finding of the best PIO mode and setting of transfer mode on the device
> >   to the new wrapper.
> 
> > * Fix scc_tune_chipset() to tune PIO modes.  Do a small cleanup while at it.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
