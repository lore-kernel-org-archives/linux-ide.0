From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] ide-timing.h: make the timing from the IDE device work
Date: Sat, 12 Feb 2005 10:22:29 +0100
Message-ID: <20050212092229.GB2297@ucw.cz>
References: <004001c485c0$fe5031a0$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from twilight.ucw.cz ([81.30.235.3]:26279 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262302AbVBLJV6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Feb 2005 04:21:58 -0500
Content-Disposition: inline
In-Reply-To: <004001c485c0$fe5031a0$6401a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Albert Lee <albertlee@tikira.net>, linux-ide@vger.kernel.org

On Thu, Aug 19, 2004 at 03:48:57PM +0800, Albert Lee wrote:

> ide-timing.h patch: make the timing from the IDE device work.
> 
> Albert Lee

Bartolomiej, we indeed need this patch, otherwise EIDE timings the drive
supplies to us are completely ignored in the code.

> --- linux-2.6.6\drivers\ide\ide-timing.h.ori 2004-05-10 10:32:28.000000000
> +0800
> +++ linux-2.6.6\drivers\ide\ide-timing.h 2004-08-19 13:01:17.117860800 +0800
> @@ -220,6 +220,7 @@
>   if (!(s = ide_timing_find_mode(speed)))
>    return -EINVAL;
> 
> + memcpy(t, s, sizeof(*t));
>  /*
>   * If the drive is an EIDE drive, it can tell us it needs extended
>   * PIO/MWDMA cycle timing.
> @@ -248,7 +249,7 @@
>   * Convert the timing to bus clock counts.
>   */
> 
> - ide_timing_quantize(s, t, T, UT);
> + ide_timing_quantize(t, t, T, UT);
> 
>  /*
>   * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
