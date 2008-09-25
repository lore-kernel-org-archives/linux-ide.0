From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] pata_platform struct resource signness fix
Date: Thu, 25 Sep 2008 14:48:47 +0400
Message-ID: <20080925104847.GA311@oksana.dev.rtsoft.ru>
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn> <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:38910 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752910AbYIYKst (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Sep 2008 06:48:49 -0400
Content-Disposition: inline
In-Reply-To: <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Wang Jian <lark@linux.net.cn>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Thu, Sep 25, 2008 at 06:40:59PM +0800, Li Yang wrote:
> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
> > The alternative fix can be.
> 
> This one is better as 0 is defined as 'invalid irq' for all
> architectures.  Added linux-ide and Anton to cc.

Thanks for the correct Cc.

I've sent a patch to fix the issue more than a month ago.

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg22851.html

Jeff, could you apply the patch?

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
