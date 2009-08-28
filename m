From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] Convert libata pio task to slow-work
Date: Fri, 28 Aug 2009 16:02:07 +0900
Message-ID: <4A9780EF.1030102@kernel.org>
References: <1251364122-9592-1-git-send-email-jens.axboe@oracle.com> <4A967DD7.20603@kernel.org> <20090827124927.GJ12579@kernel.dk> <4A96830F.9040805@kernel.org> <20090827184939.GK12579@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38566 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbZH1HD1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Aug 2009 03:03:27 -0400
In-Reply-To: <20090827184939.GK12579@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, dhowells@redhat.com

Hello, Jens.

Jens Axboe wrote:
>> Almost all operations are per-cpu so cache lines shouldn't bounce too
>> much.  The only part I worry about is the part which checks whether a
>> work is currently executing on the current cpu which currently is
>> implemeted as a hash table.  The hash table is only 16 pointers long
>> and will be mostly empty so hopefully it doesn't add any significant
>> overhead.
> 
> OK, we'll let time and experimentation be the judge.

Yeap.

>>> Care to post it? I know you don't think it's perfect yet, but it would
>>> make a lot more sense to throw effort into this rather than waste time
>>> on partial solutions.
>> I have this printed out code with full of red markings from proof
>> reading and flush implementation is mostly broken.  Please give me a
>> couple of days.  I'll post a rough unsplit version which at least
>> compiles with the planned changes applied by the end of the week.  :-)
> 
> Alright, fair enough.
> 
> One question - do the 'exposed' workqueues (the ones that drivers
> allocate/create) sitting in front of the global cpu queue allow more
> than one thread per cpu, or is that property retained for the global cpu
> queue (where it is a necessity)?

The exposed workqueues basically just play the gateway and don't have
threads associated with it, well, at least not the normal ones.  It
may have single dedicated thread which usually isn't used but only
gets summoned when a queue stall is detected (new thread needs to be
created but blocks on allocation kind of situation).  So, only the
global cpu queue has normal workers and there are multiple per cpu and
they're shared by all exported workqueues.

Thanks.

-- 
tejun
