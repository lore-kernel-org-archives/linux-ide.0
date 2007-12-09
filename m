From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] hpt366: fix HPT37x PIO mode timings (take 2)
Date: Sun, 9 Dec 2007 18:10:35 +0100
Message-ID: <200712091810.36063.bzolnier@gmail.com>
References: <200712081838.10647.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:3986 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbXLIS5Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 13:57:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1357935ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 10:57:23 -0800 (PST)
In-Reply-To: <200712081838.10647.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 08 December 2007, Sergei Shtylyov wrote:
> After looking into the HPT370 manual (now that I have it) and re-checking all
> the timing tables, here's what I have discovered:
> 
> - at 33 MHz clock, PIO mode 0 timings turned to be overclocked, and all other
>   PIO modes underclocked;
> 
> - at 50 MHz clock, PIO modes 0 to 2 turned to be overclocked;
> 
> - at 66 MHz clock, PIO mode 0 was overclocked too.
> 
> Finally, the taskfile timing (matching PIO mode 0) turned to be overclocked at
> all clock frequencies (and in all manuals)...
> 
> The new timings have been tested on HPT370 chip (at 33 MHz PCI clock) and on
> HPT371N chip (at both 50 and 66 MHz DPLL clock).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

> ---
> Many PIO modes at 55/66 MHz (as well as MDDMA modes at all clocks) are also
> underclocked but I decided not to touch them, at least for the time being.
> The patch is against the Linus' tree, with PIO0 setup time correct this time...

Since it is against Linus' tree I assume that it is safe enough to be merged
for 2.6.24, right?
