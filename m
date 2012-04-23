From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Mon, 23 Apr 2012 10:11:30 -0400
Message-ID: <x497gx6v8q5.fsf@segfault.boston.devel.redhat.com>
References: <4F8F7533.6020300@gmail.com> <4F8F82EC.1060708@teksavvy.com>
	<4F90C4CF.1010000@gmail.com> <4F921E18.6000301@teksavvy.com>
	<4F921ECF.2080303@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12062 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab2DWOLf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Apr 2012 10:11:35 -0400
In-Reply-To: <4F921ECF.2080303@teksavvy.com> (Mark Lord's message of "Fri, 20
	Apr 2012 22:43:27 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Joe Ceklosky <jfceklosky@gmail.com>, "linux-ide@vger.kernel.org >> IDE/ATA development list" <linux-ide@vger.kernel.org>

Mark Lord <kernel@teksavvy.com> writes:

> On 12-04-20 10:40 PM, Mark Lord wrote:
>> On 12-04-19 10:07 PM, Joe Ceklosky wrote:
>>> Mark,
>>>
>>>
>>> Thanks for the info, but nothing like that shows up:
>>>
>>>
>>> [jceklosk@neptune tmp]$ cat c-3.2.15
>>> noop deadline [cfq]
>>> noop deadline [cfq]
>>>
>>>
>>> [jceklosk@neptune tmp]$ cat c-3.3.2
>>> noop deadline [cfq]
>>> noop deadline [cfq]
>> 
>> 
>> Well, the stuff you posted (above) shows that cfq is being used
>> instead of noop.  For SSDs, noop is the more natural choice,
>> and used to be the default in the kernel for a while.
>> I wonder when that changed?
>
> Looking into the block layer now, I see that "cfq" at some point
> became "SSD aware", which is probably when the default io scheduler
> for SSDs changed back to cfq from noop.

The block layer never changed the I/O scheduler based on whether or not
the underlying storage was an SSD.  Maybe your particular distro did
that for you?  I can't say for sure, and it really doesn't matter as the
original report, here, is that the SAME CONFIGURATION (cfq old and new)
now regresses in performance.  We should concentrate on fixing *that*.

Cheers,
Jeff
