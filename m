From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_port_wait_eh(): Change irqsave into unconditional
 closing of interrupts
Date: Thu, 26 Sep 2013 09:31:53 -0400
Message-ID: <20130926133153.GA2480@htj.dyndns.org>
References: <1491380201679@web5j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:53650 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab3IZNcD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2013 09:32:03 -0400
Received: by mail-yh0-f47.google.com with SMTP id l109so423131yhq.6
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2013 06:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491380201679@web5j.yandex.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kirill Tkhai <tkhai@yandex.ru>
Cc: linux-ide@vger.kernel.org

Hello, Kirill.

On Thu, Sep 26, 2013 at 05:21:19PM +0400, Kirill Tkhai wrote:
> Hi,
> 
> ata_port_wait_eh() uses spin_lock_irqsave() and this can confuse in fact
> that it is suitable to use in irqs_disabled() context. But we can't.
> 
> (schedule() returns with interrupts enabled so it's possible
> ata_port_wait_eh() enters with disabled interrupts but returns with enabled)
> 
> So, replace irqsave to unconditional closing of interrupts.
> 
> I propose to consider to add patch like this. (If you don't have a magic
> with flags which is not obvious for me :)

Hmmm... yeah, this was Jeff's preference, at least way back, so libata
has a lot of spin_lock_irqsave()'s where spin_lock_irq() should do.
At this point, I don't really mind either way but if you wanna change
it can you please do a full sweep through libata?  While I don't mind
either state too much, I do want them to be mostly consistent one way
or the other.

Thanks.

-- 
tejun
