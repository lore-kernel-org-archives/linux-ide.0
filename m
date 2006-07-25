From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] avoid releasing twice the same region on ide_release_iomio_dma()
Date: Tue, 25 Jul 2006 16:22:08 +0400
Message-ID: <44C60CF0.8030008@ru.mvista.com>
References: <20060724193031.GA18463@cathedrallabs.org>	 <44C5264D.4040609@ru.mvista.com> <87f94c370607241423g71bd17f9tb3b2e4fcf0cbeb5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:37208 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1751158AbWGYMXV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jul 2006 08:23:21 -0400
In-Reply-To: <87f94c370607241423g71bd17f9tb3b2e4fcf0cbeb5d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>, linux-ide@vger.kernel.org

Hello.

Greg Freemyer wrote:

>>     dma_base2 should go away altogether -- this is the IDE 
>> maintainer's opinion:

>> http://marc.theaimsgroup.com/?l=linux-ide&m=114345699807546&w=2

>>     I have posted this patch doing this back in March:

>> http://marc.theaimsgroup.com/?l=linux-ide&m=114357441529834&w=2

>> and it was in the -mm tree for some months but has been removed 
>> recently -- I still need to coordinate it with SGI.

> IDE is officially un-maintained as of a couple weeks ago.  (And since
> April in reality).

> http://marc.theaimsgroup.com/?l=linux-ide&m=115201353310421&w=2

> That is likely why your patch disappeared.

    It didn't disappear. It was conflicting with one of Alan's patches and 
needed consent from SGI folks.

> Further Alan Cox and Jeff
> Garzik are trying to replace the whole IDE subsystem with a libata-ide
> subsystem, so IIRC major patches to IDE are being bit-bucketed.

    Not if you send them to Andrew Morton. :-)

> Greg

WBR, Sergei

