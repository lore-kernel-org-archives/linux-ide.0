From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Tue, 23 Jun 2009 03:43:16 -0700 (PDT)
Message-ID: <20090623.034316.149816033.davem@davemloft.net>
References: <200906220843.14337.elendil@planet.nl>
	<200906221321.44672.bzolnier@gmail.com>
	<200906221604.17915.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906221604.17915.elendil@planet.nl>
Sender: sparclinux-owner@vger.kernel.org
To: elendil@planet.nl
Cc: bzolnier@gmail.com, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Mon, 22 Jun 2009 16:04:15 +0200

> On Monday 22 June 2009, you wrote:
>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Subject: [PATCH] ide: fix handling of unexpected IRQs vs request_irq()
>>
>> Add ide_host_enable_irqs() helper and use it in ide_host_register()
>> before registering ports.  Then remove no longer needed IRQ unmasking
>> from in init_irq().
>>
>> This should fix the problem with "screaming" shared IRQ on the first
>> port (after request_irq() call while we have the unexpected IRQ pending
>> on the second port) which was uncovered by my rework of the serialized
>> interfaces support.
> 
> Thanks Bart. This does solve the "nobody cared" problem.
> Tested-by: Frans Pop <elendil@planet.nl>

I've applied this patch to my tree, thanks everyone!
