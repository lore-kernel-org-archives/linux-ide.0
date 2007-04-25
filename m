From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175 init_sched_clock()
Date: Wed, 25 Apr 2007 18:15:03 +0900
Message-ID: <462F1C17.6080305@gmail.com>
References: <462E4C4D.9020806@gmail.com>	<20070425011654.222a2b4b.akpm@linux-foundation.org>	<462F1481.8010807@gmail.com> <20070425015559.e6ed537c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:61425 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423331AbXDYJPQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 05:15:16 -0400
Received: by wr-out-0506.google.com with SMTP id 76so162026wra
        for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2007 02:15:15 -0700 (PDT)
In-Reply-To: <20070425015559.e6ed537c.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Berck E. Nash" <flyboy@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Andrew Morton wrote:
>> No, that would break host probing.  The port is in frozen (controller
>> initialized and IRQs masked off) state, so it's not allowed to take
>> interrupt.
> 
> Sounds dodgy.  What happens if the IRQ line is shared with some other
> device?  We'll enter ahci_interrupt().  We've alread set up ->port_map and
> ->n_ports so we're wholly dependent upon that read from HOST_IRQ_STAT
> returning zeroes.

Shared IRQ is okay because ahci has pending IRQ register which is masked
by ->freeze().  Controllers which don't have such feature check qc
status to determine whether it's expecting IRQ, so it's okay for them
too.  So, AFAIK, libata is okay with shared IRQs.

>         /* sigh.  0xffffffff is a valid return from h/w */
> 
> if that happens we're dead, aren't we?

Yes, we are.  :-)

>>  If interrupt triggers at this point, it's low level driver
>> bug.  Berck, how reliably can you reproduce this problem?  Can you post
>> the result of 'lspci -nn'?
> 
> Berck doesn't apepar to be sharing that IRQ, so it'll be something else.

I'm pretty sure Berck's problem is caused by ->freeze() not clearing
pending IRQ bit.  We haven't been too strict about ->freeze().
Considering the above 0xffffffff case, I agree it's better to fix it in
the core instead of fixing each LLD.  Will brew up another patch.

Thanks.

-- 
tejun
