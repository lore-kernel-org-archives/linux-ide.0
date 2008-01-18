From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk
Date: Sat, 19 Jan 2008 07:58:10 +0900
Message-ID: <47912F02.6070801@gmail.com>
References: <1200445210549-git-send-email-htejun@gmail.com> <1200681668.25782.9.camel@cinder.waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:43223 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762402AbYARW6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 17:58:17 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1997161wah.23
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 14:58:16 -0800 (PST)
In-Reply-To: <1200681668.25782.9.camel@cinder.waste.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, randy.dunlap@oracle.com, jeff@garzik.org, linux-ide@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

Matt Mackall wrote:
> On Wed, 2008-01-16 at 10:00 +0900, Tejun Heo wrote:
>> And mprintk the following.
>>
>>  code:
>>   DEFINE_MPRINTK(mp, 2 * 80);
>>
>>   mprintk_set_header(&mp, KERN_INFO "ata%u.%2u: ", 1, 0);
>>   mprintk_push(&mp, "ATA %d", 7);
>>   mprintk_push(&mp, ", %u sectors\n", 1024);
>>   mprintk(&mp, "everything seems dandy\n");
> 
> I prefer Matthew Wilcox's stringbuf approach which does proper memory
> management and isn't specific to printk:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0710.3/0517.html

Yeap, that's generic and nice but I think both 'generic' and 'proper
memory management' are weakness if what you're trying to do is to
support collecting messages in pieces and putting it out via printk.
Please consider the following scenario.

You're in an interrupt handler and detected a severe error condition
which should be notified to the user but the information is rather
complex and best built in pieces, so you create a stringbuf and does
sb_printf() to it w/ GFP_ATOMIC but alas memory allocation failed and
you end up printing "out of memory" unless you detect the failure and go
back and printk messages piece-by-piece manually.  I would rather
assemble the message manually from the get-go into an on-stack buffer.

By being specifially 'printk' and let the user supply buffer, which in
most cases can be on-stack (messages shouldn't be too long anyway),
mprintk either can avoid those problems from the beginning or can
automatically work around when problem arises (initialized with NULL
buffer from allocation failure) without losing any message, so it's
essentially as simple as using printk.  There is no error handling (both
mprintk and kfree can handle NULL pointer) and the message is guaranteed
to go out no matter what.

Auto-expanding string buffer is nice but I don't think it fits the bill
here.

Thanks.

-- 
tejun
