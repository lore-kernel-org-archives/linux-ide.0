From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-cd: Improve "weird block size" error message
Date: Tue, 23 Jun 2009 16:01:23 -0700 (PDT)
Message-ID: <20090623.160123.142620779.davem@davemloft.net>
References: <200906230951.24615.elendil@planet.nl>
	<20090623.035926.155211513.davem@davemloft.net>
	<200906232330.20519.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760196AbZFWXBa@vger.kernel.org>
In-Reply-To: <200906232330.20519.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: elendil@planet.nl
Cc: bzolnier@gmail.com, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Tue, 23 Jun 2009 23:30:18 +0200

> On Tuesday 23 June 2009, David Miller wrote:
>> ide-cd: Don't warn on bogus block size unless it actually matters.
>>
>> Frans Pop reported that his CDROM drive reports a blocksize of 2352,
>> and this causes new warnings due to commit
>> e8e7b9eb11c34ee18bde8b7011af41938d1ad667 ("ide-cd: fix oops when using
>> growisofs").
>>
>> What we're trying to do is make sure that "blocklen >> SECTOR_BITS"
>> is something the block layer won't choke on.
>>
>> And for Frans case "2352 >> SECTOR_BITS" is equal to
>> "2048 >> SECTOR_BITS", and thats "4".
> 
> Pedantic correction: Frans' case

Corrected, thanks.

>> So warning in this case gives no real benefit.
>>
>> Reported-by: Frans Pop <elendil@planet.nl>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> As expected, it's gone. Nice.
> 
> Tested-by: Frans Pop <elendil@planet.nl>

Applied, thanks for testing!
