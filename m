From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] aec62xx: fix PIO/DMA setup issues
Date: Tue, 24 Apr 2007 00:33:21 +0200
Message-ID: <200704240033.21244.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200704222205.27410.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754396AbXDWWac@vger.kernel.org>
In-Reply-To: <200704222205.27410.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: codermattie@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sunday 22 April 2007, Sergei Shtylyov wrote:
> Teach the driver's tuneproc() method to do PIO auto-runing properly since it
> treated 5 instead of 255 as auto-tune request, and also passed the mode limit
> of PIO5 to ide_get_best_pio_mode() despite supporting up to PIO4 only.
> 
> While at it, also:
> 
> - remove the driver's wrong claim about supporting SWDMA modes;
> 
> - stop hooking ide_dma_timeout() method as the handler clearly doesn't fit for
>   the task...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Warning: the patch has only been compile tested (the driver was on the way of
> some cleanup -- that's why I got around to fixing it :-).

applied
