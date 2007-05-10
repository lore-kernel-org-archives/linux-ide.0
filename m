From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata reset-seq merge broke sata_sil on sh
Date: Thu, 10 May 2007 15:08:59 +0200
Message-ID: <4643196B.7070806@gmail.com>
References: <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com> <464307CC.40701@gmail.com> <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com> <20070510124645.GA18534@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:26360 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941AbXEJNJK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 09:09:10 -0400
Received: by py-out-1112.google.com with SMTP id a29so466342pyi
        for <linux-ide@vger.kernel.org>; Thu, 10 May 2007 06:09:09 -0700 (PDT)
In-Reply-To: <20070510124645.GA18534@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Mundt wrote:
> Yes, it's spun down at boot. I'll get the logs with the timestamps and
> the results of the mdelay() incrementing in the morning when I've got the
> board handy again.

I see.  That's where the expected initial prereset failure comes from.

> On Thu, May 10, 2007 at 01:53:48PM +0200, Tejun Heo wrote:
>> * According to the report, things still work till 27c78b37 - commit for
>> the actual merge and there's no related change till the current master
>> from there.  So, which commit actually breaks detection?  Or is
>> detection just flaky after b8cffc6a?
>>
> The detection is simply flaky after that point, however before the
> current master it never hit the 35 second point (and thus never implied
> that the link was down). I'll double check the bisect log to see if there
> was anything beyond that that may have caused it.
> 
> The -ENODEV at least implies that the SRST fails, so at least that's a
> starting point.

If prereset() fails to get the initial DRDY before 10secs, it assumes
something went wrong and escalates to hardreset.  sil family of
controllers report 0xff status while the link is broken and it seems
that your particular drive needs more than the current 150ms to recover
phy link.  It probably went unnoticed till now because the device was
never hardreset before.  If the diagnosis is correct, increasing the
delay in hardreset should fix the problem.  Well, let's see.  :-)

> One other curious thing is that it seems to misreport the IRQ. In this
> case the log indicates 0, whereas it's actually on IRQ 66. When the
> system is booted, /proc/interrupts reflects that sata_sil is on the
> proper IRQ (even when it's reported as 0 in the boot printk()).

That's somthing I've missed during init model conversion.  It's just
printk problem.  I'll fix it.

Thanks.

-- 
tejun
