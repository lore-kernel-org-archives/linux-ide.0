From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: libata reset-seq merge broke sata_sil on sh
Date: Thu, 10 May 2007 21:46:45 +0900
Message-ID: <20070510124645.GA18534@linux-sh.org>
References: <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com> <464307CC.40701@gmail.com> <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:48090 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758634AbXEJMrP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 08:47:15 -0400
Content-Disposition: inline
In-Reply-To: <464307CC.40701@gmail.com> <464301D3.5060306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 10, 2007 at 01:28:19PM +0200, Tejun Heo wrote:
> Paul Mundt wrote:
> [--snip, thanks a lot for the detailed report--]
> > However, if I go back before any of the reset changes were introduced,
> > things were working fine, and there were no problems with waiting for
> > the reset. Ideas?
> 
> * Does your drive start spun down when it boots?  Can you post dmesg
> with printk timestamp turned on with kernel prior to reset-seq merge?
> 
Yes, it's spun down at boot. I'll get the logs with the timestamps and
the results of the mdelay() incrementing in the morning when I've got the
board handy again.

On Thu, May 10, 2007 at 01:53:48PM +0200, Tejun Heo wrote:
> * According to the report, things still work till 27c78b37 - commit for
> the actual merge and there's no related change till the current master
> from there.  So, which commit actually breaks detection?  Or is
> detection just flaky after b8cffc6a?
> 
The detection is simply flaky after that point, however before the
current master it never hit the 35 second point (and thus never implied
that the link was down). I'll double check the bisect log to see if there
was anything beyond that that may have caused it.

The -ENODEV at least implies that the SRST fails, so at least that's a
starting point.

One other curious thing is that it seems to misreport the IRQ. In this
case the log indicates 0, whereas it's actually on IRQ 66. When the
system is booted, /proc/interrupts reflects that sata_sil is on the
proper IRQ (even when it's reported as 0 in the boot printk()).
