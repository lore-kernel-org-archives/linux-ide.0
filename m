From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] Convert libata pio task to slow-work
Date: Thu, 27 Aug 2009 21:58:55 +0900
Message-ID: <4A96830F.9040805@kernel.org>
References: <1251364122-9592-1-git-send-email-jens.axboe@oracle.com> <4A967DD7.20603@kernel.org> <20090827124927.GJ12579@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59880 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbZH0NAO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Aug 2009 09:00:14 -0400
In-Reply-To: <20090827124927.GJ12579@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, dhowells@redhat.com

Hello, Jens.

Jens Axboe wrote:
>> It would be nice if merging of this series and the lazy work can be
>> held a bit but there's no harm in merging either.  If the concurrency
>> managed workqueue turns out to be a good idea, we can replace it then.
> 
> It can wait, what you describe above sounds really cool and would
> hopefully allow us to get rid of all workqueues (provided it scales well
> and doesn't fall down on cache line contention with many different
> instances pounding on it).

Almost all operations are per-cpu so cache lines shouldn't bounce too
much.  The only part I worry about is the part which checks whether a
work is currently executing on the current cpu which currently is
implemeted as a hash table.  The hash table is only 16 pointers long
and will be mostly empty so hopefully it doesn't add any significant
overhead.

> Care to post it? I know you don't think it's perfect yet, but it would
> make a lot more sense to throw effort into this rather than waste time
> on partial solutions.

I have this printed out code with full of red markings from proof
reading and flush implementation is mostly broken.  Please give me a
couple of days.  I'll post a rough unsplit version which at least
compiles with the planned changes applied by the end of the week.  :-)

Thanks.

-- 
tejun
