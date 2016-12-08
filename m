From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 00/19] ide: remove deprecated host drivers (part 1)
Date: Thu, 08 Dec 2016 11:39:57 -0500 (EST)
Message-ID: <20161208.113957.686350007074631834.davem@davemloft.net>
References: <3280015.pSoKvQuVNQ@amdc3058>
        <20161208.102308.460750923427290066.davem@davemloft.net>
        <5007114.YSRHeGyTgl@amdc3058>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5007114.YSRHeGyTgl@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: b.zolnierkie@samsung.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org, gnomes@lxorguk.ukuu.org.uk, sergei.shtylyov@cogentembedded.com
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 08 Dec 2016 17:15:16 +0100

> On Thursday, December 08, 2016 10:23:08 AM David Miller wrote:
>> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Date: Thu, 08 Dec 2016 14:42:12 +0100
>> 
>> > Ping.. since there was no negative (or any other) feedback I think that
>> > this can be put into -next for some wider exposure..
>> 
>> I'm not going to apply this and break things on people, sorry.
> 
> People building their own kernels with their own kernel config files
> and still using IDE drivers (deprecated in 2009 BTW) will have to
> update their setups to libata but otherwise nothing is supposed to
> break.  So could you please explain in more detail what do you mean
> by "break things on people"?

There is no proof that the PATA drivers work %100 reliably as well as
the IDE driver they replace for every possible chip and architecture.

Therefore the only safe thing is to keep the IDE drivers around
forever.

They are not a maintainence burdon, I rarely get more than 1 patch
each merge window and most of the time those are cleanups or for the
handling of a kernel wide API change rather than bug fixes.
