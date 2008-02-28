From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [RFC] Disk shock protection (revisited)
Date: Thu, 28 Feb 2008 11:10:08 +0100
Message-ID: <87d4qh8k8v.fsf@denkblock.local>
References: <87skzgd1zk.fsf@denkblock.local> <20080226204707.GB8953@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:53196 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbYB1KMF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 05:12:05 -0500
In-Reply-To: <20080226204707.GB8953@1wt.eu> (Willy Tarreau's message of "Tue,
	26 Feb 2008 21:47:07 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Willy Tarreau <w@1wt.eu> wrote:
> Hi Elias,

Hi Willy,

>
> On Tue, Feb 26, 2008 at 12:56:31AM +0100, Elias Oltmanns wrote:
>
> [ very interesting project ]
>
>> Probably, the major problem is that I don't really know what kind of
>> applications (apart from shock protection) I should be thinking of that
>> might want to have a queue freezing facility at hand.
>
> In terms of applications, depending on the sensitivity of the accelerometer,
> we can imagine that a laptop would immediately force unmount crypted
> filesystems if it believes it's being stolen, for instance. It's just a
> random idea that comes to my mind, in the hope it may help you imagine
> some crazy usages.

Well, this application would use the same input data (acceleromtere) but
it would certainly not require a generic queue freezing facility.

> But generally you should not fool your mind with too many hypothetical
> cases, ideas will come once you provide a smart interface and this
> interface will evolve with future needs.
>
> Concerning your daemon, I think that every millisecond counts when a
> laptop falls on the floor. So I think that running it in the kernel
> should help you gain those precious milliseconds.

The idle immediate command itself may need up to 300 milliseconds to
complete according to the ATA standard. This seems like a very long time
compared to CPU standards, i.e., the time usually needed to serve a
lightweight daemon.

> I doubt your daemon could trigger fast enough while X is starting or
> during some activities which require a lot of CPU or uninterruptible
> I/O.

On my system the daemon's response *feels* just fine even while
compiling a kernel; I haven't done any measurements or benchmarks
though. The thing I'm most concerned about is uninterruptible I/O but
I'm not quite sure whether and how this can be addressed in kernel
space.

Regards,

Elias
