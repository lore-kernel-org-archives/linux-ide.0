From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 14:19:50 -0700 (PDT)
Message-ID: <20090621.141950.160759111.davem@davemloft.net>
References: <200906202352.33894.elendil@planet.nl>
	<20090620.171945.140676687.davem@davemloft.net>
	<200906211515.56804.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906211515.56804.bzolnier@gmail.com>
Sender: sparclinux-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: elendil@planet.nl, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Sun, 21 Jun 2009 15:15:56 +0200

> On Sunday 21 June 2009 02:19:45 David Miller wrote:
>> I wonder how much testing this commit received...
> 
> Too less, any help with improving testing coverage is welcomed
> (this was just a tiny part of very large rework which has been tested
> and has been sitting in linux-next for weeks before push to Linus).

Maybe you should leave the driver alone until you can get affirmative
testing results from people who have the hardware?!?!? :-/

And in leiu of that, simply leave it alone until such testing can
actually be performed.

That's why all the IDE drivers are constantly breaking on sparc.

The IDE layer is more than legacy at this point, so if you aren't
fixing bugs (those reported by users and the fix for which can
be absolutely tested), just leave it be.

So this totally eliminates any argument you may have about necessary
"infrastructure" changes that might be blocked by not being able to
make these kinds modifications to drivers for devices you can't even
test.
