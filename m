From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: A question about NCQ
Date: Wed, 17 May 2006 14:04:27 +1000
Message-ID: <446AA0CB.60208@yahoo.com.au>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>	 <4469AE21.6000304@gmail.com>	 <1147832470.7273.112.camel@forrest26.sh.intel.com>	 <446A8C78.2000607@gmail.com> <1147836269.7273.127.camel@forrest26.sh.intel.com> <446A9E65.9040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:45188 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751209AbWEQEEb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 00:04:31 -0400
In-Reply-To: <446A9E65.9040608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Tejun Heo wrote:

>
>Anyways, anticipatory rules, great.  I don't know why NCQ is showing
>worse performance w/ AS, but I'm pretty sure it's something which can be
>fixed.  Jens, Nick, any ideas?
>

Thanks for the numbers, interesting.

Anticipatory basically tries pretty hard to control disk command
queues because they can result in starvation... not exactly sure
why it is _worse_ with NCQ than without, maybe the drive isn't too
smart or there is a bad interaction with AS.

I don't see any trivial bugs in AS that would cause this, but there
may be one...

It's unfortunate that we don't have a grand unified IO scheduler
that does everything well (except perhaps noop functionality). It
is something I guess Jens and I (or maybe someone completely
different) should get together with and try to make progress on one
day.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 

