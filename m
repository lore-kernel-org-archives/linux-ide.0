From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] pata_platform struct resource signness fix
Date: Thu, 25 Sep 2008 19:47:27 +0400
Message-ID: <20080925154727.GA1620@oksana.dev.rtsoft.ru>
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn> <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com> <48DBAF4F.3020003@linux.net.cn>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:39937 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752794AbYIYPr3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Sep 2008 11:47:29 -0400
Content-Disposition: inline
In-Reply-To: <48DBAF4F.3020003@linux.net.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wang Jian <lark@linux.net.cn>
Cc: Li Yang <leoli@freescale.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Thu, Sep 25, 2008 at 11:33:35PM +0800, Wang Jian wrote:
> Li Yang wrote:
>> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
>>> The alternative fix can be.
>>
>> This one is better as 0 is defined as 'invalid irq' for all
>> architectures.  Added linux-ide and Anton to cc.
>
> However, this is not very true. Just git grep "#define NO_IRQ" and see. It
> seems that the NO_IRQ is in transition from (-1) to (0).

Yeah, there is a mess, but it gets better as time goes by.
The platforms/drivers should be fixed, since 0 is the only
invalid VIRQ.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
