From: fengxiangjun <fengxiangjun@neusoft.com>
Subject: Re: 2.6.32.2 SATA link detect failed, 2.6.32.1 works fine
Date: Thu, 24 Dec 2009 15:58:13 +0800 (CST)
Message-ID: <alpine.LNX.2.00.0912241557170.1682@darkstar.example.net>
References: <alpine.LNX.2.00.0912211855460.1689@darkstar.example.net>
 <4B30134C.1050609@gmail.com>
 <alpine.LNX.2.00.0912220859060.1686@darkstar.example.net>
 <51f3faa70912211708j200ab584wa835ffe50981415e@mail.gmail.com>
 <alpine.LNX.2.00.0912220955341.1696@darkstar.example.net>
 <4B31DB17.4050509@kernel.org>
 <alpine.LNX.2.00.0912231719440.1694@darkstar.example.net>
 <4B331957.7030906@kernel.org>
 <alpine.LNX.2.00.0912241535340.1682@darkstar.example.net>
 <4B331D93.2010000@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailget.neusoft.com ([210.83.25.69]:54873 "EHLO
	mailgate.neusoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756818AbZLXH4G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Dec 2009 02:56:06 -0500
In-reply-to: <4B331D93.2010000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Ok, I'll try. Please wait.

Thanks.

On Thu, 24 Dec 2009, Tejun Heo wrote:

> Hello,
> 
> On 12/24/2009 04:45 PM, fengxiangjun wrote:
> > Hi, I can not capture the full failing boot log.
> > The kernel panic, and shift + pageup does not work. 
> > 
> > With output to serial console, the problem goes away.
> 
> Ah... right, I forgot about this.
> 
> > I think with an initrd, I can reproduce the problem and capture the
> > full failing boot log.  But with an initrd, there's no
> > problem. Every thing works fine.
> 
> Hmmm.... can you please try netconsole?  Netconsole usually doesn't
> introduce much delay and should be able to extract the log without
> affecting timings.
> 
> Thanks.
> 
> -- 
> tejun
> 
---------------------------------------------------------------------------------------------------
Confidentiality Notice: The information contained in this e-mail and any accompanying attachment(s) 
is intended only for the use of the intended recipient and may be confidential and/or privileged of 
Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader of this communication is 
not the intended recipient, unauthorized use, forwarding, printing,  storing, disclosure or copying 
is strictly prohibited, and may be unlawful.If you have received this communication in error,please 
immediately notify the sender by return e-mail, and delete the original message and all copies from 
your system. Thank you. 
---------------------------------------------------------------------------------------------------

