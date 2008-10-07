From: Wang Jian <lark@linux.net.cn>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 07 Oct 2008 17:18:38 +0800
Message-ID: <48EB296E.5050808@linux.net.cn>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru> <48EA77EF.6080502@genesi-usa.com> <20081006213209.GA13072@oksana.dev.rtsoft.ru> <48EABBD3.1010401@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [210.82.31.146] ([210.82.31.146]:36349 "EHLO mx.linux.net.cn"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbYJGJSo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Oct 2008 05:18:44 -0400
In-Reply-To: <48EABBD3.1010401@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: avorontsov@ru.mvista.com, Matt Sealey <matt@genesi-usa.com>, Jeff Garzik <jgarzik@pobox.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>

Tejun Heo wrote:
> Anton Vorontsov wrote:
>> On Mon, Oct 06, 2008 at 03:41:19PM -0500, Matt Sealey wrote:
>>> There is a simple problem with the patch which is that an "IRQ 0" can and does
>>> actually exist on a bunch of platforms, at least to the best of my knowledge.
>>>
>>> Checking for -1 (which means for definite, no irq at all, because it is
>>> totally unambiguous, as a -1 IRQ numbering is "impossible") is more correct.
>> This was discussed years ago.
>>
>> http://lkml.org/lkml/2005/11/22/159
>> http://lkml.org/lkml/2005/11/22/227
>>
> 
> Would this break any existing platforms?  If so, can those be fixed
> together or does it become a much bigger problem that way?
> 

Pata_of_platform stacks upon pata_platform. This patch fixes problem
concerning definition of "no irq" without touch any other place.  So
far I can't see any new problem.
