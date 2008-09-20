From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 2/2 v3] libata: Implement disk shock protection support
Date: Sat, 20 Sep 2008 13:12:46 +0200
Message-ID: <87wsh75avl.fsf@denkblock.local>
References: <87tzcb7r0r.fsf@denkblock.local>
	<20080919214400.7183.64611.stgit@denkblock.local>
	<48D4805A.3090707@kernel.org> <87abe37462.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:34423 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbYITLNA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Sep 2008 07:13:00 -0400
In-Reply-To: <87abe37462.fsf@denkblock.local> (Elias Oltmanns's message of
	"Sat, 20 Sep 2008 07:54:45 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

[ Readding LKML which I dropped when starting this thread for some
inexplicable reason. ]

Elias Oltmanns <eo@nebensachen.de> wrote:
> Tejun Heo <tj@kernel.org> wrote:
>>> +static ssize_t ata_scsi_park_store(struct device *device,
>>> +				   struct device_attribute *attr,
>>> +				   const char *buf, size_t len)
>>> +{
>> ...
>>> +		complete_all(&ap->park_req_pending);
>>
>> Sorry to catching this this late but calling complete_all() twice will
>> overflow the done counter.  I think complete() should just work here,
>> no?
>
> Sorry for missing that in the first place, rather embarrassing that. I
> had just assumed that the done counter was set to an absolute value
> rather than added to. I really think that this is what we actually want,
> so, perhaps, a seperate patch for Ingo or someone is in order?

By the way, this doesn't really matter in our particular case. The
reason is that we only care about whether park_req_pending.done is equal
or unequal to zero. Since UINT_MAX is of the form 2n+1 (where n is some
interger value), calling complete_all() m times may overflow but will
still result in a non-zero value provided that m is smaller than n.
Assuming that m != 0 is even, we have:

m * n < m / 2 * (2 * n + 2).

Additionally, we have:

(m / 2 - 1) * (2 * n + 2) == (m - 2) * (n + 1) == m * n + m - (2 * n + 2).

This means that for 0 < m < UINT_MAX (and m even) we get:

m * n > (m / 2 - 1) * (2 * n + 2)

and consequently

m * n % (UINT_MAX + 1) == m * n - (m / 2) * (2 * n + 2) == 2 * n + 2 - m
== UINT_MAX + 1 - m.

Now consider the case that m is odd:

m * n < (m + 1) / 2 * (2 * n + 2).

But

(m - 1) / 2 * (2 * n + 2) == (m - 1) * (n + 1) == m * n + m - n - 1.

For m <= n (and m odd) we get:

m * n >= (m - 1) / 2 * (2 * n + 2)

and consequently

m * n % (UINT_MAX + 1) == m * n - (m - 1) / 2 * (2 * n + 2) == n + 1 - m.

This proves that the done counter will be non-zero if we call
complete_all() at least once and up to (UINT_MAX - 1) / 2 times. So,
I'll add some more comments about clearing ATA_EH_PARK and why it's
needed and then resend the patch. Mind you, I still think that
complete_all() should be changed. I'll take a look at other use cases in
the kernel and see whether overflowing is an issue there.

Regards,

Elias
