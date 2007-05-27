From: "Gregor Jasny" <gjasny@googlemail.com>
Subject: Re: Linux v2.6.22-rc3
Date: Sun, 27 May 2007 22:15:12 +0200
Message-ID: <9d2cd630705271315x7030c91ew2f175c921c022880@mail.gmail.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org>
	 <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>
	 <46599E6B.1000209@pobox.com>
	 <9d2cd630705270907y4722653cpf79f073fa8f12f08@mail.gmail.com>
	 <alpine.LFD.0.98.0705270922030.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:25599 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbXE0UPO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 May 2007 16:15:14 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1589696mue
        for <linux-ide@vger.kernel.org>; Sun, 27 May 2007 13:15:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705270922030.26602@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>

2007/5/27, Linus Torvalds <torvalds@linux-foundation.org>:
> But if it doesn't help for you, you have some other issue (which is not
> surprising - yours wasn't a SETFXSR error, and I don't think it would have
> worked very well before either).
>
> So since it apparently _did_ work for you before, can you bisect it?

git bisect told me that this is the first bad commit:
commit d4b2bab4f26345ea1803feb23ea92fbe3f6b77bc
Author: Tejun Heo <htejun@gmail.com>
Date:   Fri Feb 2 16:50:52 2007 +0900

libata: add deadline support to prereset and reset methods

I suspected my unstable timing source and booted with acpi=off. Now
the printk timestamps are in sequence but the bug is still there.

The drive worked flawlessly with the old ide-cd. So what's the
difference between libata and ide-cd?

Is there a kernel parameter to completely disable probing the cdrom?

Thanks,
Gregor
