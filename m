From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Tue, 12 Feb 2008 10:43:24 +0100
Message-ID: <871w7i33yb.fsf@denkblock.local>
References: <87ir0w4rzo.fsf@denkblock.local> <47AFD7C1.7070204@gmail.com>
	<871w7k9b8y.fsf@denkblock.local> <47B00AA1.3010104@gmail.com>
	<87r6fj2lsx.fsf@denkblock.local> <47B0F2E0.9020204@gmail.com>
	<877iha3621.fsf@denkblock.local> <47B1614B.5020209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:46842 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762109AbYBLJnb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Feb 2008 04:43:31 -0500
In-Reply-To: <47B1614B.5020209@gmail.com> (Tejun Heo's message of "Tue, 12 Feb
	2008 18:05:15 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> Elias Oltmanns wrote:
>> This proves that piix_qc_defer() has declined the same command 100
>> times in succession. However, this will only happen if the status of
>> all the commands enqueued for one port hasn't changed in the
>> meantime. This suggests to me that the threads scheduled for command
>> execution and completion aren't served for some reason. Any ideas?
>
> Blocked counts of 1 will cause busy looping because when blk_run_queue()
> returns because it's recursing too deep, it schedules unplug work right
> away, so it will easily loop 100 times.  Max blocked counts should be
> adjusted to two (needs some testing before actually submitting the
> change).  But that still shouldn't cause any lock up.  What happens if
> you remove the 100 times limit?  Does the machine hang on IO?

Yes, it does. In fact, I had already verified that before sending the
previous email.

Regards,

Elias
