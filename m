From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_platform struct resource signness fix
Date: Mon, 29 Sep 2008 00:19:14 -0400
Message-ID: <48E05742.1030609@pobox.com>
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn> <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com> <20080925104847.GA311@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34477 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbYI2ETd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:19:33 -0400
In-Reply-To: <20080925104847.GA311@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Li Yang <leoli@freescale.com>, Wang Jian <lark@linux.net.cn>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Anton Vorontsov wrote:
> On Thu, Sep 25, 2008 at 06:40:59PM +0800, Li Yang wrote:
>> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
>>> The alternative fix can be.
>> This one is better as 0 is defined as 'invalid irq' for all
>> architectures.  Added linux-ide and Anton to cc.
> 
> Thanks for the correct Cc.
> 
> I've sent a patch to fix the issue more than a month ago.
> 
> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg22851.html
> 
> Jeff, could you apply the patch?

Can you resend, I don't seem to have it...


