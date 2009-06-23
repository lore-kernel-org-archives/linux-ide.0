From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: Silent compiler warning in ide_pio_bytes()
Date: Tue, 23 Jun 2009 03:05:49 -0700 (PDT)
Message-ID: <20090623.030549.88246370.davem@davemloft.net>
References: <20090623085324.03b25bb9@hyperion.delvare>
	<20090623.023211.06996077.davem@davemloft.net>
	<20090623115207.58c4ff59@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43102
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752366AbZFWKFo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 06:05:44 -0400
In-Reply-To: <20090623115207.58c4ff59@hyperion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khali@linux-fr.org
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, petkovbb@googlemail.com

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Jun 2009 11:52:07 +0200

> On Tue, 23 Jun 2009 02:32:11 -0700 (PDT), David Miller wrote:
>> From: Jean Delvare <khali@linux-fr.org>
>> Date: Tue, 23 Jun 2009 08:53:24 +0200
>> 
>> > I fear somebody else will have to do that. I personally think
>> > uninitialized_var() should not have been invented, I don't want to have
>> > my name associated with any of its uses for it will inevitably lead to
>> > bugs in the future.
>> > 
>> > I'll resubmit a patch not fixing the warning (because the rest is still
>> > useful I think) but that's about all I can offer.
>> 
>> The alternative will be that someone will ask "when does the '0' case
>> get used" and have to sort through that and potentially ask people
>> here on the lists.
> 
> The comment I added, /* Silent compiler warning */, should have
> answered this question pretty clearly, methinks.

Yet the uninitialzed_var() tag was created to indicate this
tree-wide.  A convention for the entire tree.

You can try to fight city hall with your protest, but I suspect
biting off one's nose to spite one's face is not profitable in
the end.

>> But you posted and update patch which solves the problem in an
>> even nicer way :-)
> 
> Is it enough to silent the warning for you? I wasn't for me (gcc
> 4.3.2), although I expected it to... gcc should be able to see there is
> no code path leading to the variable being used uninitialized.

I didn't check, I suspected that you rewrote the patch this way
because it did kill the warning for you.  Guess not.

I'll be the pragmatist and add the uninitialized_var() myself,
and will not for posterity your continued support of "the anti-
uninitialized_var() cause" :-)
