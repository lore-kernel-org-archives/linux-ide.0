From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] libata: disable interrupts before soft reset
Date: Fri, 31 Mar 2006 19:32:10 +0900
Message-ID: <20060331103210.GB13172@htj.dyndns.org>
References: <442CFE96.1040203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:16676 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751256AbWCaKcQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 05:32:16 -0500
Received: by zproxy.gmail.com with SMTP id o37so819542nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 02:32:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <442CFE96.1040203@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

On Fri, Mar 31, 2006 at 06:04:06PM +0800, Albert Lee wrote:
> Changes:
> - add ata_irq_off() to libata.h
> - call ata_irq_off() to disable the interrupt before soft reset
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> When testing an old 1996 Acer 8x CD-ROM drive (CD-787E), an
> interrupt is generated in ata_devchk(), right after the device is selected.
> (The unhandled irq cause the IRQ 10 to be disabled.)
> 
> Disabling interrupts before doing soft reset fixes the problem.
> However, this problem is only seen on the specific CD-ROM drive.
> So, don't know whether the fix is necessary.
> 
> Patch against upstream (8b316a3973f05e572b4edeeda9072987f6bbaa44).
> For your review, thanks.
> 

Hello, Albert.

Please hold this off.  This issue is handled by new EH.

This problem is bigger than just during reset.  Any error condition
which leaves the device and/or controller has potential to cause
similar problems or worse (e.g. data corruption, screaming
interrupts).  New EH handles this by freezing ports when
device/controller enters unknown state.  The controller is thawed
after EH reset is complete.  The same mechanism applies to probing.
All ports are started frozen.  Only after initial reset is complete,
ports get thawed.

It's been a loooooong week but I'm splitting the patches now.  :)

-- 
tejun
